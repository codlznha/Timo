<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 자유 게시판</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- 공통 CSS (절대 경로) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">

        <style>
            /* --- 1. 상단 통합 검색창 숨기기 (이 페이지 한정) --- */
            .header-search {
                display: none !important;
            }

            /* --- 2. 기본 레이아웃 강제 정렬 (디자인 깨짐 방지 핵심) --- */
            .main-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                min-width: 0;
                /* Flexbox 팽창 버그 해결 (버튼 짤림 방지) */
            }

            /* 상단 글씨 겹침 해결 */
            .page-header {
                padding: 30px 30px 0 30px;
                margin-bottom: -10px;
            }

            .content-container {
                padding: 20px 30px;
                width: 100%;
                max-width: 100%;
                box-sizing: border-box;
                min-width: 0;
            }

            /* --- 게시판 전용 스타일 --- */

            /* TOP 5 인기글 섹션 */
            .top-posts-section {
                margin-bottom: 30px;
            }

            .section-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
                color: var(--text-dark);
            }

            .top-grid {
                display: flex;
                gap: 15px;
                overflow-x: auto;
                padding-bottom: 10px;
            }

            .top-grid::-webkit-scrollbar {
                height: 6px;
            }

            .top-grid::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 4px;
            }

            .top-card {
                flex: 0 0 250px;
                background: var(--white);
                padding: 20px;
                border-radius: 12px;
                box-shadow: var(--shadow-sm);
                cursor: pointer;
                border: 1px solid var(--border-color);
                transition: 0.2s;
            }

            .top-card:hover {
                transform: translateY(-3px);
                border-color: var(--primary-blue);
            }

            .top-badge {
                display: inline-block;
                background: #ffebee;
                color: #d32f2f;
                font-size: 0.75rem;
                font-weight: bold;
                padding: 3px 8px;
                border-radius: 4px;
                margin-bottom: 10px;
            }

            .top-title {
                font-size: 0.95rem;
                font-weight: bold;
                margin-bottom: 8px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .top-meta {
                font-size: 0.8rem;
                color: var(--text-gray);
                display: flex;
                justify-content: space-between;
            }

            /* 게시판 컨트롤 (카테고리, 검색, 글쓰기) */
            .board-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }

            .category-tabs {
                display: flex;
                gap: 8px;
                overflow-x: auto;
            }

            .cat-btn {
                padding: 8px 16px;
                border: 1px solid var(--border-color);
                background: var(--white);
                border-radius: 20px;
                font-size: 0.9rem;
                cursor: pointer;
                color: var(--text-gray);
                transition: 0.2s;
                white-space: nowrap;
            }

            .cat-btn.active,
            .cat-btn:hover {
                background: var(--primary-blue);
                color: white;
                border-color: var(--primary-blue);
                font-weight: bold;
            }

            .action-group {
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: wrap;
            }

            /* 게시판 내부 검색창 */
            .board-search-box {
                display: flex;
                align-items: center;
                background: var(--white);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 6px 12px;
                flex-shrink: 0;
            }

            .board-search-box input {
                border: none;
                outline: none;
                padding: 4px;
                font-size: 0.9rem;
                width: 140px;
            }

            .board-search-box button {
                background: none;
                border: none;
                color: var(--primary-blue);
                cursor: pointer;
            }

            .btn-write {
                padding: 10px 20px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
                white-space: nowrap;
                flex-shrink: 0;
            }

            .btn-write:hover {
                background: var(--sidebar-hover);
            }

            /* 리스트 필터 (전체/내가쓴글/좋아요) */
            .list-filters {
                display: flex;
                gap: 15px;
                border-bottom: 2px solid var(--border-color);
                margin-bottom: 15px;
            }

            .filter-btn {
                background: none;
                border: none;
                padding: 10px 5px;
                font-size: 0.95rem;
                color: var(--text-gray);
                cursor: pointer;
                position: relative;
            }

            .filter-btn.active {
                color: var(--primary-blue);
                font-weight: bold;
            }

            .filter-btn.active::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 100%;
                height: 2px;
                background: var(--primary-blue);
            }

            /* 게시글 리스트 */
            .post-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-bottom: 40px;
            }

            .post-item {
                background: var(--white);
                padding: 15px 20px;
                border-radius: 12px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border: 1px solid var(--border-color);
                cursor: pointer;
                transition: 0.2s;
            }

            .post-item:hover {
                box-shadow: var(--shadow-sm);
            }

            .post-left {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .post-cat {
                font-size: 0.8rem;
                color: var(--primary-blue);
                font-weight: bold;
                background: var(--primary-light);
                padding: 4px 8px;
                border-radius: 4px;
                white-space: nowrap;
            }

            .post-info h4 {
                font-size: 1rem;
                margin-bottom: 5px;
                color: var(--text-dark);
            }

            .post-info p {
                font-size: 0.85rem;
                color: var(--text-gray);
                display: flex;
                gap: 10px;
            }

            .post-right {
                text-align: right;
                font-size: 0.85rem;
                color: var(--text-gray);
                flex-shrink: 0;
            }

            .stat-badge {
                display: flex;
                gap: 12px;
                margin-top: 5px;
                justify-content: flex-end;
            }

            .stat-badge span {
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .stat-badge .likes {
                color: #d32f2f;
            }

            /* 모달 (공통, 글쓰기, 글읽기) */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }

            .modal-overlay.show {
                display: flex;
            }

            .modal-box {
                background: white;
                width: 100%;
                max-width: 600px;
                border-radius: 16px;
                padding: 30px;
                box-shadow: var(--shadow-lg);
                max-height: 90vh;
                overflow-y: auto;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 20px;
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 15px;
            }

            .btn-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: var(--text-gray);
                cursor: pointer;
            }

            /* 글쓰기 폼 */
            .form-group {
                margin-bottom: 15px;
            }

            .form-group select,
            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 0.95rem;
                box-sizing: border-box;
            }

            .form-group textarea {
                height: 200px;
                resize: none;
            }

            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .btn-submit {
                width: 100%;
                padding: 14px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: bold;
                cursor: pointer;
            }

            /* 게시글 보기 및 댓글 */
            .view-meta {
                display: flex;
                justify-content: space-between;
                font-size: 0.9rem;
                color: var(--text-gray);
                margin-bottom: 20px;
            }

            .view-content {
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 30px;
                color: var(--text-dark);
                min-height: 150px;
            }

            .view-actions {
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 20px;
            }

            .btn-like {
                padding: 8px 20px;
                border: 1px solid #d32f2f;
                color: #d32f2f;
                background: white;
                border-radius: 20px;
                cursor: pointer;
                font-weight: bold;
                transition: 0.2s;
            }

            .btn-like:hover,
            .btn-like.active {
                background: #d32f2f;
                color: white;
            }

            /* 더보기(수정/삭제) 메뉴 */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .drop-btn {
                background: none;
                border: none;
                color: var(--text-gray);
                cursor: pointer;
                font-size: 1.2rem;
                padding: 5px;
            }

            .drop-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: white;
                min-width: 100px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                z-index: 1;
                border: 1px solid var(--border-color);
                overflow: hidden;
            }

            .drop-content a {
                color: var(--text-dark);
                padding: 10px 15px;
                text-decoration: none;
                display: block;
                font-size: 0.9rem;
            }

            .drop-content a:hover {
                background-color: var(--bg-color);
            }

            .dropdown:hover .drop-content {
                display: block;
            }

            /* 댓글 영역 */
            .comment-section h4 {
                margin-bottom: 15px;
            }

            .comment-item {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px dashed var(--border-color);
            }

            .comment-info {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .comment-author {
                font-weight: bold;
                font-size: 0.9rem;
            }

            .comment-text {
                font-size: 0.95rem;
            }

            .comment-input-wrap {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .comment-input-wrap input {
                flex: 1;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                box-sizing: border-box;
            }

            .comment-input-wrap button {
                padding: 10px 15px;
                background: var(--text-dark);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                white-space: nowrap;
            }

            /* 모바일 대응 */
            @media (max-width: 768px) {
                .board-controls {
                    flex-direction: column;
                    align-items: stretch;
                }

                .action-group {
                    justify-content: space-between;
                }

                .board-search-box {
                    flex: 1;
                }

                .board-search-box input {
                    width: 100%;
                }

                .post-item {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .post-right {
                    width: 100%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                /* 모바일 플로팅 글쓰기 버튼 */
                .btn-write {
                    position: fixed;
                    bottom: 80px;
                    right: 20px;
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    padding: 0;
                    justify-content: center;
                    z-index: 99;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                }

                .btn-write span {
                    display: none;
                }
            }
        </style>
    </head>

    <body>

        <!-- 사이드바 -->
        <%@ include file="/common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">

                <!-- 헤더 -->
                <%@ include file="/common/header.jsp" %>

                    <div class="page-header">
                        <h1>자유 게시판</h1>
                        <p>동아리원, 학우들과 자유롭게 소통해보세요!</p>
                    </div>

                    <div class="content-container">

                        <!-- 1. 주간 인기글 TOP 5 -->
                        <section class="top-posts-section">
                            <div class="section-title"><i class="fa-solid fa-fire" style="color: #ff8c00;"></i> 주간 인기글
                                TOP 5</div>
                            <div class="top-grid">
                                <!-- TOP 1 -->
                                <div class="top-card"
                                    onclick="openViewModal('UiPath Element 오류 해결법 아시는 분?', 'RPA 실습 중에 selector를 못 잡는데 어떻게 해야 하나요?', '익명', 45, 12)">
                                    <span class="top-badge">TOP 1</span>
                                    <div class="top-title">UiPath Element 오류 해결법 아시는 분?</div>
                                    <div class="top-meta">
                                        <span>익명</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 45</span>
                                    </div>
                                </div>
                                <!-- TOP 2 -->
                                <div class="top-card"
                                    onclick="openViewModal('기숙사 공용 냉장고 반찬 관련 질문', '내용 생략...', '이한국', 38, 5, true)">
                                    <span class="top-badge">TOP 2</span>
                                    <div class="top-title">기숙사 공용 냉장고 반찬 관련 질문</div>
                                    <div class="top-meta">
                                        <span>이한국</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 38</span>
                                    </div>
                                </div>
                                <!-- TOP 3 -->
                                <div class="top-card" onclick="openViewModal()">
                                    <span class="top-badge">TOP 3</span>
                                    <div class="top-title">스프링부트 vs JSP 서블릿 차이점 요약</div>
                                    <div class="top-meta">
                                        <span>웹마스터</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 31</span>
                                    </div>
                                </div>
                                <!-- TOP 4 -->
                                <div class="top-card" onclick="openViewModal()">
                                    <span class="top-badge">TOP 4</span>
                                    <div class="top-title">오늘 저녁 같이 순대국 드실 분? (1/4)</div>
                                    <div class="top-meta">
                                        <span>익명</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 25</span>
                                    </div>
                                </div>
                                <!-- TOP 5 -->
                                <div class="top-card" onclick="openViewModal()">
                                    <span class="top-badge">TOP 5</span>
                                    <div class="top-title">마우스 추천 좀 부탁드립니다.</div>
                                    <div class="top-meta">
                                        <span>개발자지망생</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 19</span>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- 2. 컨트롤 영역 (카테고리 & 검색) -->
                        <div class="board-controls">
                            <div class="category-tabs">
                                <button class="cat-btn active">전체</button>
                                <button class="cat-btn">자유</button>
                                <button class="cat-btn">질문</button>
                                <button class="cat-btn">모집</button>
                                <button class="cat-btn">후기</button>
                            </div>
                            <div class="action-group">
                                <div class="board-search-box">
                                    <input type="text" placeholder="게시글 검색...">
                                    <button><i class="fa-solid fa-magnifying-glass"></i></button>
                                </div>
                                <button class="btn-write" onclick="openWriteModal()">
                                    <i class="fa-solid fa-pen"></i> <span>글쓰기</span>
                                </button>
                            </div>
                        </div>

                        <!-- 3. 리스트 필터 -->
                        <div class="list-filters">
                            <button class="filter-btn active">전체 글</button>
                            <button class="filter-btn">내가 쓴 글</button>
                            <button class="filter-btn">좋아요 누른 글</button>
                        </div>

                        <!-- 4. 게시글 리스트 -->
                        <div class="post-list">
                            <!-- 아이템 1 -->
                            <div class="post-item"
                                onclick="openViewModal('UiPath Element 오류 해결법 아시는 분?', 'RPA 실습 중에 selector를 못 잡는데 어떻게 해야 하나요?', '익명', 45, 12)">
                                <div class="post-left">
                                    <span class="post-cat">질문</span>
                                    <div class="post-info">
                                        <h4>UiPath Element 오류 해결법 아시는 분?</h4>
                                        <p><span>익명</span> <span>|</span> <span>10분 전</span></p>
                                    </div>
                                </div>
                                <div class="post-right">
                                    <div>조회 128</div>
                                    <div class="stat-badge">
                                        <span class="likes"><i class="fa-solid fa-heart"></i> 45</span>
                                        <span><i class="fa-regular fa-comment"></i> 12</span>
                                    </div>
                                </div>
                            </div>

                            <!-- 아이템 2 -->
                            <div class="post-item"
                                onclick="openViewModal('기숙사 공용 냉장고 반찬 관련 질문', '내용 생략...', '이한국', 38, 5, true)">
                                <div class="post-left">
                                    <span class="post-cat">자유</span>
                                    <div class="post-info">
                                        <h4>기숙사 공용 냉장고 반찬 관련 질문</h4>
                                        <p><span>이한국</span> <span>|</span> <span>1시간 전</span></p>
                                    </div>
                                </div>
                                <div class="post-right">
                                    <div>조회 89</div>
                                    <div class="stat-badge">
                                        <span class="likes"><i class="fa-solid fa-heart"></i> 38</span>
                                        <span><i class="fa-regular fa-comment"></i> 5</span>
                                    </div>
                                </div>
                            </div>

                            <!-- 아이템 3 -->
                            <div class="post-item" onclick="openViewModal()">
                                <div class="post-left">
                                    <span class="post-cat">모집</span>
                                    <div class="post-info">
                                        <h4>오늘 저녁 같이 순대국 드실 분? (1/4)</h4>
                                        <p><span>익명</span> <span>|</span> <span>3시간 전</span></p>
                                    </div>
                                </div>
                                <div class="post-right">
                                    <div>조회 56</div>
                                    <div class="stat-badge">
                                        <span class="likes"><i class="fa-solid fa-heart"></i> 25</span>
                                        <span><i class="fa-regular fa-comment"></i> 3</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
            </div>

            <!-- [모달] 1. 글쓰기 팝업 -->
            <div class="modal-overlay" id="writeModal">
                <div class="modal-box">
                    <div class="modal-header">
                        게시글 작성
                        <button class="btn-close" onclick="closeWriteModal()"><i class="fa-solid fa-xmark"></i></button>
                    </div>
                    <form onsubmit="submitPost(event)">
                        <div class="form-group">
                            <select required>
                                <option value="">카테고리 선택</option>
                                <option value="자유">자유</option>
                                <option value="질문">질문</option>
                                <option value="모집">모집</option>
                                <option value="후기">후기</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" placeholder="제목을 입력하세요." required>
                        </div>
                        <div class="form-group">
                            <textarea placeholder="내용을 작성해주세요. 타인을 비방하는 글은 무통보 삭제될 수 있습니다." required></textarea>
                        </div>
                        <div class="form-options">
                            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                                <input type="checkbox" id="isAnonymous"> 익명으로 작성
                            </label>
                        </div>
                        <button type="submit" class="btn-submit">등록하기</button>
                    </form>
                </div>
            </div>

            <!-- [모달] 2. 게시글 보기 팝업 -->
            <div class="modal-overlay" id="viewModal">
                <div class="modal-box">
                    <div class="modal-header">
                        <span id="viewTitle">게시글 제목</span>
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <!-- 작성자 본인일 때만 보이는 수정/삭제 드롭다운 -->
                            <div class="dropdown" id="authorMenu" style="display: none;">
                                <button class="drop-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                <div class="drop-content">
                                    <a href="#" onclick="alert('수정 화면으로 이동합니다.')">수정하기</a>
                                    <a href="#" style="color: #d32f2f;" onclick="deletePost()">삭제하기</a>
                                </div>
                            </div>
                            <button class="btn-close" onclick="closeViewModal()"><i
                                    class="fa-solid fa-xmark"></i></button>
                        </div>
                    </div>

                    <div class="view-meta">
                        <span id="viewAuthor">작성자</span>
                        <span>2026.07.17 14:30 | 조회 128</span>
                    </div>

                    <div class="view-content" id="viewContent">
                        게시글 내용이 여기에 표시됩니다.
                    </div>

                    <!-- 좋아요 버튼 -->
                    <div class="view-actions">
                        <button class="btn-like" id="likeBtn" onclick="toggleLike()">
                            <i class="fa-solid fa-heart"></i> 좋아요 <span id="likeCount">0</span>
                        </button>
                    </div>

                    <!-- 댓글 영역 -->
                    <div class="comment-section">
                        <h4>댓글 <span style="color: var(--primary-blue);" id="commentCount">0</span></h4>

                        <div id="commentList">
                            <!-- 댓글 샘플 -->
                            <div class="comment-item">
                                <div class="comment-info">
                                    <span class="comment-author">익명1</span>
                                    <span class="comment-text">저도 그 부분에서 막혔었는데, Selector 편집기 열어서 확인해보세요!</span>
                                </div>
                                <div class="dropdown">
                                    <button class="drop-btn" style="font-size: 1rem;"><i
                                            class="fa-solid fa-ellipsis-vertical"></i></button>
                                    <div class="drop-content">
                                        <a href="#">신고하기</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="comment-input-wrap">
                            <input type="text" placeholder="댓글을 남겨보세요. (익명)">
                            <button onclick="alert('댓글이 등록되었습니다.')">등록</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 스크립트 -->
            <script src="${pageContext.request.contextPath}/js/common.js"></script>
            <script>
                // 1. 카테고리 & 필터 탭 활성화 UI 처리
                document.querySelectorAll('.cat-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        document.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
                        this.classList.add('active');
                    });
                });

                document.querySelectorAll('.filter-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                        this.classList.add('active');
                    });
                });

                // 2. 글쓰기 모달 제어
                function openWriteModal() { document.getElementById('writeModal').classList.add('show'); }
                function closeWriteModal() { document.getElementById('writeModal').classList.remove('show'); }

                function submitPost(e) {
                    e.preventDefault();
                    const isAnon = document.getElementById('isAnonymous').checked;
                    alert(isAnon ? '익명으로 게시글이 등록되었습니다.' : '게시글이 등록되었습니다.');
                    closeWriteModal();
                }

                // 3. 게시글 보기 모달 제어 (더미 데이터 바인딩)
                let isLiked = false;
                let currentLikes = 0;

                function openViewModal(title = '제목 없음', content = '내용이 없습니다.', author = '익명', likes = 0, comments = 0, isAuthor = false) {
                    document.getElementById('viewTitle').innerText = title;
                    document.getElementById('viewContent').innerText = content;
                    document.getElementById('viewAuthor').innerText = author;
                    document.getElementById('likeCount').innerText = likes;
                    document.getElementById('commentCount').innerText = comments;

                    // 본인 작성 글일 경우 수정/삭제 메뉴 표시
                    document.getElementById('authorMenu').style.display = isAuthor ? 'block' : 'none';

                    currentLikes = likes;
                    isLiked = false;
                    document.getElementById('likeBtn').classList.remove('active');

                    document.getElementById('viewModal').classList.add('show');
                }

                function closeViewModal() { document.getElementById('viewModal').classList.remove('show'); }

                // 삭제 처리
                function deletePost() {
                    if (confirm('정말 이 게시글을 삭제하시겠습니까?')) {
                        alert('삭제되었습니다.');
                        closeViewModal();
                    }
                }

                // 좋아요 토글
                function toggleLike() {
                    const btn = document.getElementById('likeBtn');
                    const countSpan = document.getElementById('likeCount');

                    if (isLiked) {
                        btn.classList.remove('active');
                        currentLikes--;
                    } else {
                        btn.classList.add('active');
                        currentLikes++;
                    }
                    isLiked = !isLiked;
                    countSpan.innerText = currentLikes;
                }

                // 모달 외부 클릭 시 닫기
                window.onclick = function (event) {
                    if (event.target == document.getElementById('writeModal')) closeWriteModal();
                    if (event.target == document.getElementById('viewModal')) closeViewModal();
                }
            </script>
    </body>

    </html>