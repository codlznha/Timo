<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 자유 게시판</title>
        <!-- 아이콘 폰트는 sidebar.jsp에서 불러오므로 생략 -->

        <style>
            /* --- 공통 및 메인 페이지 전용 CSS Variables --- */
            :root {
                --bg-color: #f4f6f9;
                --text-dark: #333333;
                --text-gray: #666666;
                --border-color: #e5e8eb;
                --primary-light: #e6f0fa;
                --primary-blue: #007bff;
                /* sidebar.jsp 변수 누락 대비 임시 */
                --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.03);
                --shadow-lg: 0 5px 15px rgba(0, 0, 0, 0.2);
                --white: #ffffff;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
            }

            body {
                background-color: var(--bg-color);
                display: flex;
                min-height: 100vh;
                overflow-x: hidden;
            }

            .main-wrapper {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                min-width: 0;
            }

            /* 상단 헤더 */
            .top-header {
                height: 70px;
                background-color: var(--white);
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 30px;
                border-bottom: 1px solid var(--border-color);
                position: sticky;
                top: 0;
                z-index: 90;
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .btn-toggle {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: var(--text-dark);
                cursor: pointer;
            }

            .header-icons {
                display: flex;
                align-items: center;
                gap: 20px;
                color: var(--text-gray);
                font-size: 1.2rem;
                cursor: pointer;
            }

            .header-search {
                display: none !important;
            }

            /* 하단 네비게이션 바 (모바일) */
            .bottom-nav {
                display: none;
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                height: 65px;
                background: var(--white);
                justify-content: space-around;
                align-items: center;
                border-top: 1px solid var(--border-color);
                z-index: 100;
            }

            .bottom-nav .nav-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                font-size: 0.75rem;
                color: var(--text-gray);
                text-decoration: none;
                width: 20%;
                gap: 4px;
            }

            .bottom-nav .nav-item i {
                font-size: 1.4rem;
            }

            .bottom-nav .nav-item.active {
                color: var(--primary-blue);
            }

            @media (max-width: 768px) {
                .main-wrapper {
                    padding-bottom: 70px;
                }

                .bottom-nav {
                    display: flex;
                }
            }

            /* --- 게시판 공통 --- */
            .content-container {
                padding: 20px 30px;
                width: 100%;
                max-width: 100%;
                box-sizing: border-box;
                min-width: 0;
            }

            /* 페이지 뷰 전환 CSS */
            .page-view {
                display: none;
                animation: fadeIn 0.3s ease;
            }

            .page-view.active {
                display: block;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* --- 1. 게시글 목록 페이지 (ListView) --- */
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
                background: #1557b0;
            }

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
                border-color: #ccc;
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

            /* --- 2. 게시글 상세 페이지 (DetailView) --- */
            .page-header-nav {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
                cursor: pointer;
                color: var(--text-gray);
                font-weight: bold;
            }

            .page-header-nav:hover {
                color: var(--text-dark);
            }

            .detail-card {
                background: var(--white);
                padding: 30px;
                border-radius: 12px;
                border: 1px solid var(--border-color);
                margin-bottom: 20px;
            }

            .detail-title {
                font-size: 1.4rem;
                font-weight: bold;
                margin-bottom: 15px;
                color: var(--text-dark);
            }

            .detail-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 15px;
                margin-bottom: 25px;
                font-size: 0.9rem;
                color: var(--text-gray);
            }

            .meta-actions button {
                background: none;
                border: none;
                font-size: 0.85rem;
                color: var(--text-gray);
                cursor: pointer;
                margin-left: 10px;
            }

            .meta-actions button:hover {
                color: var(--text-dark);
                text-decoration: underline;
            }

            .meta-actions button.delete-btn:hover {
                color: #d32f2f;
            }

            .detail-content {
                font-size: 1rem;
                line-height: 1.7;
                color: var(--text-dark);
                min-height: 200px;
                margin-bottom: 30px;
            }

            .detail-actions-center {
                text-align: center;
                margin-bottom: 30px;
            }

            .btn-like {
                padding: 10px 25px;
                border: 1px solid #d32f2f;
                color: #d32f2f;
                background: white;
                border-radius: 20px;
                cursor: pointer;
                font-weight: bold;
                transition: 0.2s;
                font-size: 1rem;
            }

            .btn-like:hover,
            .btn-like.active {
                background: #d32f2f;
                color: white;
            }

            /* 댓글 영역 */
            .comment-section h4 {
                margin-bottom: 15px;
                font-size: 1.1rem;
            }

            .comment-item {
                display: flex;
                justify-content: space-between;
                padding: 15px 0;
                border-bottom: 1px dashed var(--border-color);
            }

            .comment-info {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .comment-author {
                font-weight: bold;
                font-size: 0.95rem;
                color: var(--text-dark);
            }

            .comment-text {
                font-size: 0.95rem;
                color: var(--text-dark);
            }

            .comment-input-wrap {
                display: flex;
                gap: 10px;
                margin-top: 20px;
                background: var(--bg-color);
                padding: 15px;
                border-radius: 8px;
            }

            .comment-input-wrap input {
                flex: 1;
                padding: 12px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 0.95rem;
            }

            .comment-input-wrap button {
                padding: 10px 20px;
                background: var(--text-dark);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                white-space: nowrap;
            }

            /* --- 3. 게시글 작성 페이지 (WriteView) --- */
            .write-card {
                background: var(--white);
                padding: 30px;
                border-radius: 12px;
                border: 1px solid var(--border-color);
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 8px;
                color: var(--text-dark);
                font-size: 0.95rem;
            }

            .form-group select,
            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 1rem;
                background: var(--bg-color);
                transition: border 0.3s;
            }

            .form-group select:focus,
            .form-group input:focus,
            .form-group textarea:focus {
                border-color: var(--primary-blue);
                background: white;
            }

            .form-group textarea {
                height: 300px;
                resize: none;
                line-height: 1.5;
            }

            .form-options {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .btn-group {
                display: flex;
                gap: 10px;
            }

            .btn-cancel {
                padding: 14px 20px;
                background: white;
                color: var(--text-dark);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                flex: 1;
            }

            .btn-submit {
                padding: 14px 20px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                flex: 2;
            }
        </style>
    </head>

    <body>

        <!-- 사이드바 -->
        <%@ include file="common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">
                <header class="top-header">
                    <div class="header-left">
                        <button class="btn-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>
                    </div>
                    <div class="header-icons">
                        <i class="fa-regular fa-bell"></i>
                    </div>
                </header>

                <div class="content-container">

                    <!-- ============================================== -->
                    <!-- 1. 게시글 목록 화면 (기본 활성화) -->
                    <!-- ============================================== -->
                    <div id="listView" class="page-view active">
                        <section class="top-posts-section">
                            <div class="section-title"><i class="fa-solid fa-fire" style="color: #ff8c00;"></i> 주간 인기글
                                TOP 5</div>
                            <div class="top-grid">
                                <div class="top-card"
                                    onclick="openDetailPage('UiPath Element 오류 해결법 아시는 분?', 'RPA 실습 중에 selector를 못 잡는데 어떻게 해야 하나요?', '익명', 45, 12, false)">
                                    <span class="top-badge">TOP 1</span>
                                    <div class="top-title">UiPath Element 오류 해결법 아시는 분?</div>
                                    <div class="top-meta">
                                        <span>익명</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 45</span>
                                    </div>
                                </div>
                                <div class="top-card"
                                    onclick="openDetailPage('기숙사 공용 냉장고 반찬 관련 질문', '내용 생략...', '이한국', 38, 5, true)">
                                    <span class="top-badge">TOP 2</span>
                                    <div class="top-title">기숙사 공용 냉장고 반찬 관련 질문</div>
                                    <div class="top-meta">
                                        <span>이한국</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 38</span>
                                    </div>
                                </div>
                                <div class="top-card"
                                    onclick="openDetailPage('스프링부트 vs JSP 서블릿 차이점 요약본', '서블릿의 라이프사이클과 스프링의 의존성 주입에 대해 정리했습니다.', '웹마스터', 31, 8, false)">
                                    <span class="top-badge">TOP 3</span>
                                    <div class="top-title">스프링부트 vs JSP 서블릿 차이점 요약본</div>
                                    <div class="top-meta">
                                        <span>웹마스터</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 31</span>
                                    </div>
                                </div>
                                <div class="top-card"
                                    onclick="openDetailPage('오늘 저녁 같이 순대국 드실 분?', '정문 앞에서 6시에 같이 드실 분 구합니다.', '익명', 25, 4, false)">
                                    <span class="top-badge">TOP 4</span>
                                    <div class="top-title">오늘 저녁 같이 순대국 드실 분? (1/4)</div>
                                    <div class="top-meta">
                                        <span>익명</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 25</span>
                                    </div>
                                </div>
                                <div class="top-card"
                                    onclick="openDetailPage('마우스 추천 좀 부탁드립니다.', '내용 생략...', '개발자지망생', 19, 2, false)">
                                    <span class="top-badge">TOP 5</span>
                                    <div class="top-title">마우스 추천 좀 부탁드립니다.</div>
                                    <div class="top-meta">
                                        <span>개발자지망생</span>
                                        <span style="color:#d32f2f;"><i class="fa-solid fa-heart"></i> 19</span>
                                    </div>
                                </div>
                            </div>
                        </section>

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
                                <button class="btn-write" onclick="openWritePage()">
                                    <i class="fa-solid fa-pen"></i> <span>글쓰기</span>
                                </button>
                            </div>
                        </div>

                        <div class="list-filters">
                            <button class="filter-btn active">전체 글</button>
                            <button class="filter-btn">내가 쓴 글</button>
                            <button class="filter-btn">좋아요 누른 글</button>
                        </div>

                        <div class="post-list">
                            <div class="post-item"
                                onclick="openDetailPage('UiPath Element 오류 해결법 아시는 분?', 'RPA 실습 중에 selector를 못 잡는데 어떻게 해야 하나요?', '익명', 45, 12, false)">
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

                            <div class="post-item"
                                onclick="openDetailPage('기숙사 공용 냉장고 반찬 관련 질문', '냄새가 심한 반찬은 어떻게 보관하시나요?', '이한국', 38, 5, true)">
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
                        </div>
                    </div>

                    <!-- ============================================== -->
                    <!-- 2. 게시글 상세 화면 (숨김) -->
                    <!-- ============================================== -->
                    <div id="detailView" class="page-view">
                        <div class="page-header-nav" onclick="showListPage()">
                            <i class="fa-solid fa-arrow-left"></i> 목록으로 돌아가기
                        </div>

                        <div class="detail-card">
                            <div class="detail-title" id="viewTitle">게시글 제목</div>
                            <div class="detail-meta">
                                <div>
                                    <span id="viewAuthor" style="font-weight:bold; color:var(--text-dark);">작성자</span>
                                    <span> | 2026.07.17 14:30 | 조회 128</span>
                                </div>
                                <div class="meta-actions" id="authorActions" style="display: none;">
                                    <button onclick="alert('수정 화면으로 이동합니다.')">수정</button>
                                    <button class="delete-btn" onclick="deletePost()">삭제</button>
                                </div>
                            </div>

                            <div class="detail-content" id="viewContent">
                                게시글 내용이 여기에 표시됩니다.
                            </div>

                            <div class="detail-actions-center">
                                <button class="btn-like" id="likeBtn" onclick="toggleLike()">
                                    <i class="fa-solid fa-heart"></i> 좋아요 <span id="likeCount">0</span>
                                </button>
                            </div>

                            <div class="comment-section">
                                <h4>댓글 <span style="color: var(--primary-blue);" id="commentCount">0</span></h4>
                                <div id="commentList">
                                    <div class="comment-item">
                                        <div class="comment-info">
                                            <span class="comment-author">익명1</span>
                                            <span class="comment-text">저도 그 부분에서 막혔었는데, Selector 편집기 열어서 확인해보세요!</span>
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

                    <!-- ============================================== -->
                    <!-- 3. 게시글 작성 화면 (숨김) -->
                    <!-- ============================================== -->
                    <div id="writeView" class="page-view">
                        <div class="page-header-nav" onclick="showListPage()">
                            <i class="fa-solid fa-arrow-left"></i> 목록으로 돌아가기
                        </div>

                        <div class="write-card">
                            <form onsubmit="submitPost(event)">
                                <div class="form-group">
                                    <label>카테고리</label>
                                    <select required>
                                        <option value="">카테고리를 선택해주세요</option>
                                        <option value="자유">자유</option>
                                        <option value="질문">질문</option>
                                        <option value="모집">모집</option>
                                        <option value="후기">후기</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>제목</label>
                                    <input type="text" placeholder="제목을 입력하세요." required>
                                </div>
                                <div class="form-group">
                                    <label>내용</label>
                                    <textarea placeholder="내용을 작성해주세요. 타인을 비방하는 글은 무통보 삭제될 수 있습니다." required></textarea>
                                </div>
                                <div class="form-options">
                                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                                        <input type="checkbox" id="isAnonymous"> 익명으로 작성
                                    </label>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn-cancel" onclick="showListPage()">취소</button>
                                    <button type="submit" class="btn-submit">등록하기</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>

            <!-- 하단 네비게이션 바 -->
            <nav class="bottom-nav">
                <a href="index.jsp" class="nav-item"><i class="fa-solid fa-house"></i><span>홈</span></a>
                <a href="club_main.jsp" class="nav-item"><i class="fa-solid fa-shield-halved"></i><span>동아리</span></a>
                <a href="map.jsp" class="nav-item"><i class="fa-solid fa-map-location-dot"></i><span>지도</span></a>
                <a href="board.jsp" class="nav-item active"><i
                        class="fa-solid fa-clipboard-list"></i><span>게시판</span></a>
                <a href="mypage.jsp" class="nav-item"><i class="fa-solid fa-user"></i><span>MY</span></a>
            </nav>

            <!-- 스크립트 -->
            <script>
                // 🌟 마이페이지에서 넘어올 때 URL 파라미터를 읽어 자동으로 상세 화면 열기
                window.addEventListener('DOMContentLoaded', function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const postId = urlParams.get('postId');

                    if (postId) {
                        // 더미 데이터 세팅 (실제 환경에서는 DB 연동 데이터 출력)
                        if (postId === '101') {
                            openDetailPage('기숙사 공용 냉장고 반찬 관련 질문합니다', '냄새가 심한 반찬은 어떻게 보관하시나요? 다들 어떻게 쓰시는지 궁금합니다.', '이한국', 38, 5, true);
                        } else if (postId === '102') {
                            openDetailPage('스프링부트 vs JSP 서블릿 차이점 요약본', '서블릿의 라이프사이클과 스프링의 의존성 주입에 대해 정리해봤습니다. 공부에 도움 되시길 바랍니다.', '웹마스터', 342, 12, false);
                        } else if (postId === '201') {
                            openDetailPage('UiPath Element 오류 해결법 아시는 분?', 'RPA 실습 중에 selector를 못 잡는데 어떻게 해야 하나요?', '익명', 45, 12, false);
                        } else if (postId === '202') {
                            openDetailPage('오늘 저녁 같이 순대국 드실 분?', '정문 앞에서 6시에 같이 순대국 드실 분 구합니다.', '익명', 25, 4, false);
                        } else {
                            openDetailPage('게시글 제목 (ID: ' + postId + ')', '해당 게시글의 상세 내용입니다.', '작성자', 0, 0, false);
                        }
                    }
                });

                // 1. 페이지 전환 (SPA 방식)
                function showPage(pageId) {
                    // 모든 뷰 숨김
                    document.querySelectorAll('.page-view').forEach(page => {
                        page.classList.remove('active');
                    });
                    // 요청된 뷰만 표시
                    document.getElementById(pageId).classList.add('active');
                    // 스크롤 상단으로 이동
                    window.scrollTo(0, 0);
                }

                // 목록 페이지로 이동
                function showListPage() {
                    // 뒤로가기 시 URL에 있는 파라미터를 지워주기 위해 브라우저 히스토리 변경
                    window.history.pushState({}, document.title, window.location.pathname);
                    showPage('listView');
                }

                // 글쓰기 페이지로 이동
                function openWritePage() { showPage('writeView'); }

                // 게시글 작성 제출
                function submitPost(e) {
                    e.preventDefault();
                    const isAnon = document.getElementById('isAnonymous').checked;
                    alert(isAnon ? '익명으로 게시글이 등록되었습니다.' : '게시글이 등록되었습니다.');
                    showListPage();
                }

                // 2. 게시글 상세 보기 페이지 제어
                let isLiked = false;
                let currentLikes = 0;

                function openDetailPage(title = '제목 없음', content = '내용이 없습니다.', author = '익명', likes = 0, comments = 0, isAuthor = false) {
                    document.getElementById('viewTitle').innerText = title;
                    document.getElementById('viewContent').innerText = content;
                    document.getElementById('viewAuthor').innerText = author;
                    document.getElementById('likeCount').innerText = likes;
                    document.getElementById('commentCount').innerText = comments;

                    // 본인 글일 경우 수정/삭제 버튼 노출
                    document.getElementById('authorActions').style.display = isAuthor ? 'block' : 'none';

                    currentLikes = likes;
                    isLiked = false;
                    document.getElementById('likeBtn').classList.remove('active');

                    // 상세 페이지 표시
                    showPage('detailView');
                }

                // 삭제 처리
                function deletePost() {
                    if (confirm('정말 이 게시글을 삭제하시겠습니까?')) {
                        alert('삭제되었습니다.');
                        showListPage();
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

                // 3. UI 탭/필터 활성화 제어
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
            </script>
    </body>

    </html>