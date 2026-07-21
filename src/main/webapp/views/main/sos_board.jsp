<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - SOS 홍보 게시판</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- 공통 CSS (절대 경로) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">

        <style>
            :root {
                --bg-color: #f4f6f9;
                --text-dark: #333333;
                --text-gray: #666666;
                --border-color: #e5e8eb;
                --primary-blue: #005baa;
            }

            body {
                background-color: var(--bg-color);
                display: flex;
                min-height: 100vh;
                overflow-x: hidden;
                font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
            }

            .main-wrapper {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* --- 상단 헤더 --- */
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

            .header-search {
                display: flex;
                align-items: center;
                background: var(--bg-color);
                border-radius: 20px;
                padding: 8px 15px;
                width: 300px;
                transition: 0.3s;
            }

            .header-search input {
                border: none;
                background: transparent;
                outline: none;
                margin-left: 10px;
                width: 100%;
                font-size: 0.9rem;
            }

            .header-search button {
                background: none;
                border: none;
                cursor: pointer;
                color: var(--text-gray);
            }

            .header-icons {
                display: flex;
                align-items: center;
                gap: 20px;
                color: var(--text-gray);
                font-size: 1.2rem;
                cursor: pointer;
            }

            /* 🌟 타이틀 영역 (위쪽 간격 확실히 확보) 🌟 */
            .page-header {
                padding: 40px 30px 10px 30px;
            }

            .page-header h1 {
                font-size: 1.6rem;
                font-weight: bold;
                color: var(--text-dark);
                margin-bottom: 8px;
            }

            .page-header p {
                font-size: 0.95rem;
                color: var(--text-gray);
            }

            /* 🌟 메인 컨테이너 (위쪽 패딩 20px 추가하여 카드 상단 띄움) 🌟 */
            .content-container {
                padding: 20px 30px 40px 30px;
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                box-sizing: border-box;
                flex-grow: 1;
            }

            /* 메인 페이지의 section-card 스타일 적용 */
            .section-card {
                background: var(--white);
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
                margin-bottom: 25px;
            }

            .section-title {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 25px;
                color: var(--text-dark);
                border-bottom: 2px solid var(--border-color);
                padding-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* 툴바 (필터, 검색, 버튼) */
            .toolbar-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                flex-wrap: wrap;
                gap: 15px;
            }

            .tags {
                display: flex;
                gap: 10px;
            }

            .tag {
                padding: 8px 18px;
                border: 1px solid var(--border-color);
                border-radius: 20px;
                font-size: 0.9rem;
                color: var(--text-gray);
                cursor: pointer;
                transition: 0.2s;
                font-weight: 500;
            }

            .tag.active,
            .tag:hover {
                background: var(--primary-blue);
                color: white;
                border-color: var(--primary-blue);
                font-weight: bold;
            }

            .controls {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .search-box-local {
                display: flex;
                align-items: center;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 8px 15px;
            }

            .search-box-local input {
                border: none;
                outline: none;
                margin-left: 8px;
                font-size: 0.9rem;
                width: 180px;
            }

            .btn-write {
                padding: 10px 18px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: 0.2s;
            }

            .btn-write:hover {
                background: #004488;
            }

            /* SOS 리스트 아이템 */
            .sos-list-wrap {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .sos-item {
                border: 1px solid var(--border-color);
                border-radius: 12px;
                padding: 25px;
                cursor: pointer;
                transition: 0.2s;
            }

            .sos-item:hover {
                border-color: var(--primary-blue);
                box-shadow: 0 4px 12px rgba(0, 91, 170, 0.08);
                transform: translateY(-2px);
            }

            .sos-item-header {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
                font-size: 0.85rem;
                color: var(--text-gray);
            }

            .sos-badge {
                display: inline-block;
                font-size: 0.75rem;
                font-weight: bold;
                padding: 4px 10px;
                border-radius: 4px;
            }

            .badge-promo {
                background: #e8f5e9;
                color: #4caf50;
            }

            .badge-recruit {
                background: var(--primary-light);
                color: var(--primary-blue);
            }

            .badge-etc {
                background: #f5f5f5;
                color: #555;
            }

            .sos-club-name {
                font-weight: bold;
                color: var(--text-dark);
                border-right: 1px solid #ddd;
                padding-right: 10px;
            }

            .sos-date {
                color: #999;
            }

            .sos-item h3 {
                font-size: 1.15rem;
                color: var(--text-dark);
                margin-bottom: 12px;
                line-height: 1.4;
            }

            .sos-item p {
                font-size: 0.95rem;
                color: var(--text-gray);
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.6;
            }

            /* 페이지네이션 */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-top: 40px;
            }

            .page-btn {
                width: 38px;
                height: 38px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid var(--border-color);
                background: var(--white);
                border-radius: 8px;
                cursor: pointer;
                color: var(--text-gray);
                font-weight: bold;
                transition: 0.2s;
            }

            .page-btn:hover {
                background: var(--bg-color);
            }

            .page-btn.active {
                background: var(--primary-blue);
                color: white;
                border-color: var(--primary-blue);
            }

            /* 팝업 모달 공통 */
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

            .modal-content {
                background: var(--white);
                padding: 35px;
                border-radius: 16px;
                width: 550px;
                box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
                max-height: 90vh;
                overflow-y: auto;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 1.3rem;
                font-weight: bold;
                margin-bottom: 25px;
            }

            .btn-close {
                background: none;
                border: none;
                font-size: 1.4rem;
                cursor: pointer;
                color: var(--text-gray);
            }

            /* 글쓰기 폼 스타일 */
            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                display: block;
                font-size: 0.95rem;
                font-weight: bold;
                margin-bottom: 8px;
                color: var(--text-dark);
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 14px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 0.95rem;
                box-sizing: border-box;
            }

            .form-group textarea {
                height: 180px;
                resize: none;
            }

            /* 익명 체크박스 */
            .anon-checkbox {
                display: flex !important;
                align-items: center;
                gap: 6px;
                margin-top: 10px;
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--text-gray);
                cursor: pointer;
            }

            .anon-checkbox input[type="checkbox"] {
                width: auto;
                padding: 0;
                cursor: pointer;
            }

            .form-group input:disabled {
                background-color: var(--bg-color);
                color: var(--text-gray);
                cursor: not-allowed;
            }

            /* 익명 뱃지 (동아리명 자리에 표시) */
            .sos-club-name.is-anonymous {
                color: var(--text-gray);
                font-style: italic;
            }

            .sos-club-name.is-anonymous i {
                margin-right: 4px;
            }

            .btn-submit {
                width: 100%;
                padding: 15px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                margin-top: 15px;
                transition: 0.2s;
            }

            .btn-submit:hover {
                background: #004488;
            }

            /* 상세보기 팝업 스타일 */
            .view-header {
                border-bottom: 1px solid var(--border-color);
                padding-bottom: 20px;
                margin-bottom: 25px;
            }

            .view-title {
                font-size: 1.4rem;
                font-weight: bold;
                color: var(--text-dark);
                margin: 15px 0 10px 0;
                line-height: 1.4;
            }

            .view-meta {
                display: flex;
                gap: 12px;
                font-size: 0.95rem;
                color: var(--text-gray);
                align-items: center;
            }

            .view-body {
                font-size: 1rem;
                color: var(--text-dark);
                line-height: 1.7;
                white-space: pre-wrap;
                min-height: 200px;
            }

            @media (max-width: 768px) {
                .toolbar-wrapper {
                    flex-direction: column;
                    align-items: stretch;
                }

                .controls {
                    justify-content: space-between;
                }

                .search-box-local {
                    flex: 1;
                }

                .search-box-local input {
                    width: 100%;
                }

                .modal-content {
                    width: 90%;
                    padding: 25px;
                }

                .content-container {
                    padding: 0 15px 15px 15px;
                }

                .section-card {
                    padding: 20px;
                }
            }
        </style>
    </head>

    <body>

        <!-- 분리된 사이드바 호출 -->
        <%@ include file="/views/common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">

                <!-- 탑 헤더 -->
                <header class="top-header">
                    <div class="header-left">
                        <button class="btn-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>
                        <form class="header-search" onsubmit="event.preventDefault();">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" placeholder="통합 검색...">
                        </form>
                    </div>
                    <div class="header-icons">
                        <i class="fa-regular fa-bell"></i>
                    </div>
                </header>

                <div class="content-container">

                    <div class="section-card">

                        <div class="section-title">
                            <span><i class="fa-solid fa-bullhorn" style="color: #d32f2f; margin-right: 8px;"></i> 게시글
                                목록</span>
                        </div>

                        <div class="toolbar-wrapper">
                            <!-- 말머리 필터 -->
                            <div class="tags" id="categoryTags">
                                <div class="tag active" data-tag="all">전체</div>
                                <div class="tag" data-tag="홍보">홍보</div>
                                <div class="tag" data-tag="모집중">모집중</div>
                                <div class="tag" data-tag="기타">기타</div>
                            </div>

                            <!-- 검색 및 글쓰기 버튼 -->
                            <div class="controls">
                                <div class="search-box-local">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                    <input id="searchInput" type="text" placeholder="제목/동아리 검색...">
                                </div>
                                <button class="btn-write" onclick="openWriteModal()">
                                    <i class="fa-solid fa-pen"></i> 글쓰기
                                </button>
                            </div>
                        </div>

                        <!-- SOS 리스트 -->
                        <div class="sos-list-wrap" id="sosList">

                            <!-- 게시물 1 -->
                            <div class="sos-item" data-tag="홍보" data-title="여름 정기공연 놀러오세요!" data-club="음표"
                                onclick="openViewModal('홍보', '음표', '2026.07.18', '여름 정기공연 놀러오세요!', '이번 주말 E동 대강당에서 음표 여름 정기공연이 열립니다!\n신나는 밴드 음악과 함께 스트레스 날려버리세요.\n재학생 누구나 무료 입장 가능합니다.')">
                                <div class="sos-item-header">
                                    <span class="sos-badge badge-promo">홍보</span>
                                    <span class="sos-club-name">음표</span>
                                    <span class="sos-date">2026.07.18</span>
                                </div>
                                <h3>여름 정기공연 놀러오세요!</h3>
                                <p>이번 주말 E동 대강당에서 음표 여름 정기공연이 열립니다! 신나는 밴드 음악과 함께 스트레스 날려버리세요. 재학생 누구나 무료 입장 가능합니다.</p>
                            </div>

                            <!-- 게시물 2 -->
                            <div class="sos-item" data-tag="모집중" data-title="2학기 프론트엔드 파트원 모집" data-club="Timo"
                                onclick="openViewModal('모집중', 'Timo', '2026.07.17', '2학기 프론트엔드 파트원 모집', '실력 무관! 열정만 있으면 선배들이 다 알려드립니다.\n기초 HTML/CSS부터 웹 프레임워크까지 차근차근 배워갈 학우분들을 찾습니다.\n매주 목요일 정기 스터디가 진행됩니다.')">
                                <div class="sos-item-header">
                                    <span class="sos-badge badge-recruit">모집중</span>
                                    <span class="sos-club-name">Timo</span>
                                    <span class="sos-date">2026.07.17</span>
                                </div>
                                <h3>2학기 프론트엔드 파트원 모집</h3>
                                <p>실력 무관! 열정만 있으면 선배들이 다 알려드립니다. 기초 HTML/CSS부터 웹 프레임워크까지 차근차근 배워갈 학우분들을 찾습니다.</p>
                            </div>

                            <!-- 게시물 3 -->
                            <div class="sos-item" data-tag="기타" data-title="체육관 농구공 분실하신 분 찾습니다" data-club="스매싱"
                                onclick="openViewModal('기타', '스매싱', '2026.07.15', '체육관 농구공 분실하신 분 찾습니다', '어제 오후 체육관 창고 쪽에 농구공 하나가 떨어져 있어서 동아리방에 임시로 보관 중입니다.\n이름이 적혀있지 않으니 본인 것 같다면 동아리방으로 연락 후 찾아가세요!')">
                                <div class="sos-item-header">
                                    <span class="sos-badge badge-etc">기타</span>
                                    <span class="sos-club-name">스매싱</span>
                                    <span class="sos-date">2026.07.15</span>
                                </div>
                                <h3>체육관 농구공 분실하신 분 찾습니다</h3>
                                <p>어제 오후 체육관 창고 쪽에 농구공 하나가 떨어져 있어서 동아리방에 임시로 보관 중입니다. 이름이 적혀있지 않으니 본인 것 같다면 찾아가세요!</p>
                            </div>

                        </div>

                        <!-- 페이지네이션 -->
                        <div class="pagination">
                            <button class="page-btn"><i class="fa-solid fa-chevron-left"></i></button>
                            <button class="page-btn active">1</button>
                            <button class="page-btn">2</button>
                            <button class="page-btn">3</button>
                            <button class="page-btn"><i class="fa-solid fa-chevron-right"></i></button>
                        </div>

                    </div>
                    <!-- section-card 닫기 -->

                </div>
            </div>

            <!-- ==============================================
         [모달 1] 글쓰기 팝업
    =============================================== -->
            <div class="modal-overlay" id="writeModal">
                <div class="modal-content">
                    <div class="modal-header">
                        글쓰기
                        <button class="btn-close" onclick="closeWriteModal()"><i class="fa-solid fa-xmark"></i></button>
                    </div>

                    <form onsubmit="submitPost(event)">
                        <div class="form-group">
                            <label>말머리</label>
                            <select required>
                                <option value="">말머리 선택</option>
                                <option value="홍보">홍보</option>
                                <option value="모집중">모집중</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>동아리명</label>
                            <input type="text" id="writeClubInput" placeholder="작성할 동아리명을 입력하세요 (예: Timo)" required>
                            <label class="anon-checkbox">
                                <input type="checkbox" id="anonCheckbox" onchange="toggleAnonymous()">
                                <span>익명으로 작성하기</span>
                            </label>
                        </div>
                        <div class="form-group">
                            <label>제목</label>
                            <input type="text" placeholder="제목을 입력하세요." required>
                        </div>
                        <div class="form-group">
                            <label>상세 내용</label>
                            <textarea placeholder="게시글 내용을 상세히 적어주세요." required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">게시글 등록</button>
                    </form>
                </div>
            </div>

            <!-- ==============================================
         [모달 2] 게시글 상세보기 팝업 (연락하기 버튼 없음)
    =============================================== -->
            <div class="modal-overlay" id="viewModal">
                <div class="modal-content">
                    <div class="modal-header">
                        게시글 상세
                        <button class="btn-close" onclick="closeViewModal()"><i class="fa-solid fa-xmark"></i></button>
                    </div>

                    <div class="view-header">
                        <span id="viewBadge" class="sos-badge">말머리</span>
                        <h2 id="viewTitle" class="view-title">제목이 표시됩니다.</h2>
                        <div class="view-meta">
                            <span id="viewClub" class="sos-club-name" style="border:none; padding:0;">동아리명</span>
                            <span>|</span>
                            <span id="viewDate">2026.00.00</span>
                        </div>
                    </div>

                    <div id="viewContent" class="view-body">
                        상세 내용이 여기에 표시됩니다.
                    </div>
                </div>
            </div>

            <!-- 스크립트 -->
            <script src="${pageContext.request.contextPath}/js/common.js"></script>
            <script>
                // 1. 카테고리 필터 및 검색 기능 연동
                const tags = document.querySelectorAll('#categoryTags .tag');
                const searchInput = document.getElementById('searchInput');
                let currentTag = 'all';

                function filterList() {
                    const keyword = searchInput.value.toLowerCase();
                    const listItems = document.querySelectorAll('#sosList .sos-item');

                    listItems.forEach(item => {
                        const tag = item.getAttribute('data-tag');
                        const title = item.getAttribute('data-title').toLowerCase();
                        const club = item.getAttribute('data-club').toLowerCase();

                        // 태그 일치 여부
                        const tagMatch = (currentTag === 'all' || tag === currentTag);
                        // 검색어 일치 여부 (제목 또는 동아리명)
                        const searchMatch = (title.includes(keyword) || club.includes(keyword));

                        if (tagMatch && searchMatch) {
                            item.style.display = 'block';
                        } else {
                            item.style.display = 'none';
                        }
                    });
                }

                tags.forEach(t => {
                    t.addEventListener('click', function () {
                        tags.forEach(x => x.classList.remove('active'));
                        this.classList.add('active');
                        currentTag = this.getAttribute('data-tag');
                        filterList();
                    });
                });

                searchInput.addEventListener('keyup', filterList);

                // 2. 글쓰기 팝업 제어
                function openWriteModal() { document.getElementById('writeModal').classList.add('show'); }
                function closeWriteModal() {
                    document.getElementById('writeModal').classList.remove('show');
                    document.querySelector('#writeModal form').reset();
                    resetAnonymousState();
                }

                // 익명 체크 시 동아리명 입력란 잠금 처리
                function toggleAnonymous() {
                    const isAnon = document.getElementById('anonCheckbox').checked;
                    const clubInput = document.getElementById('writeClubInput');

                    if (isAnon) {
                        clubInput.dataset.prevValue = clubInput.value;
                        clubInput.value = '익명';
                        clubInput.disabled = true;
                        clubInput.required = false;
                    } else {
                        clubInput.disabled = false;
                        clubInput.required = true;
                        clubInput.value = clubInput.dataset.prevValue || '';
                    }
                }

                function resetAnonymousState() {
                    const anonCheckbox = document.getElementById('anonCheckbox');
                    const clubInput = document.getElementById('writeClubInput');
                    anonCheckbox.checked = false;
                    clubInput.disabled = false;
                    clubInput.required = true;
                }

                function submitPost(e) {
                    e.preventDefault();

                    const form = e.target;
                    const badgeType = form.querySelector('select').value;
                    const isAnon = document.getElementById('anonCheckbox').checked;
                    const club = isAnon ? '익명' : document.getElementById('writeClubInput').value;
                    const title = form.querySelectorAll('input[type="text"]')[1].value;
                    const content = form.querySelector('textarea').value;
                    const today = new Date();
                    const date = today.getFullYear() + '.' +
                        String(today.getMonth() + 1).padStart(2, '0') + '.' +
                        String(today.getDate()).padStart(2, '0');

                    addPostToList(badgeType, club, date, title, content, isAnon);

                    alert('게시글이 성공적으로 등록되었습니다.');
                    closeWriteModal();
                }

                // 새 게시글을 목록 최상단에 추가
                function addPostToList(badgeType, club, date, title, content, isAnon) {
                    const list = document.getElementById('sosList');
                    const badgeClass = badgeType === '홍보' ? 'badge-promo'
                        : badgeType === '모집중' ? 'badge-recruit' : 'badge-etc';
                    const preview = content.length > 60 ? content.substring(0, 60) + '...' : content;
                    const anonIconHtml = isAnon ? '<i class="fa-solid fa-user-secret"></i>' : '';
                    const clubClass = 'sos-club-name' + (isAnon ? ' is-anonymous' : '');

                    const item = document.createElement('div');
                    item.className = 'sos-item';
                    item.setAttribute('data-tag', badgeType);
                    item.setAttribute('data-title', title);
                    item.setAttribute('data-club', club);

                    // 클릭 시 상세보기가 열리도록 이벤트를 직접 바인딩 (문자열 조립 대신 클로저 사용)
                    item.addEventListener('click', function () {
                        openViewModal(badgeType, club, date, title, content);
                    });

                    const headerDiv = document.createElement('div');
                    headerDiv.className = 'sos-item-header';
                    headerDiv.innerHTML =
                        '<span class="sos-badge ' + badgeClass + '">' + badgeType + '</span>' +
                        '<span class="' + clubClass + '">' + anonIconHtml + club + '</span>' +
                        '<span class="sos-date">' + date + '</span>';

                    const titleEl = document.createElement('h3');
                    titleEl.textContent = title;

                    const previewEl = document.createElement('p');
                    previewEl.textContent = preview;

                    item.appendChild(headerDiv);
                    item.appendChild(titleEl);
                    item.appendChild(previewEl);

                    list.insertBefore(item, list.firstChild);
                }

                // 3. 게시글 상세보기 팝업 제어
                function openViewModal(badgeType, club, date, title, content) {
                    const badgeSpan = document.getElementById('viewBadge');
                    badgeSpan.innerText = badgeType;

                    // 배지 색상 동적 변경
                    badgeSpan.className = 'sos-badge';
                    if (badgeType === '홍보') badgeSpan.classList.add('badge-promo');
                    else if (badgeType === '모집중') badgeSpan.classList.add('badge-recruit');
                    else if (badgeType === '기타') badgeSpan.classList.add('badge-etc');

                    const viewClubSpan = document.getElementById('viewClub');
                    const isAnon = (club === '익명');
                    viewClubSpan.innerHTML = isAnon ? '<i class="fa-solid fa-user-secret"></i> ' + club : club;
                    viewClubSpan.classList.toggle('is-anonymous', isAnon);
                    document.getElementById('viewDate').innerText = date;
                    document.getElementById('viewTitle').innerText = title;
                    document.getElementById('viewContent').innerText = content;

                    document.getElementById('viewModal').classList.add('show');
                }

                function closeViewModal() { document.getElementById('viewModal').classList.remove('show'); }

                // 모달 배경 클릭 시 닫기
                window.onclick = function (event) {
                    if (event.target == document.getElementById('writeModal')) closeWriteModal();
                    if (event.target == document.getElementById('viewModal')) closeViewModal();
                }
            </script>
    </body>

    </html>