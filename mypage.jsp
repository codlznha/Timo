<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 마이페이지</title>
        <!-- 아이콘 폰트는 sidebar.jsp에서 자체적으로 불러오므로 여기서는 생략 -->

        <!-- 프로젝트 루트 기준 경로 유지 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">

        <style>
            /* --- main.jsp 구조 연동 및 상단 헤더 스타일 --- */
            body {
                background-color: var(--bg-color);
                display: flex;
                min-height: 100vh;
                overflow-x: hidden;
            }

            /* margin-left는 sidebar.jsp에서 자동으로 제어합니다 */
            .main-wrapper {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* 상단 헤더 (main.jsp 스타일 완벽 통일) */
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

            /* 내부 콘텐츠 배치용 레이아웃 간격 조정 */
            .page-header {
                padding: 30px 30px 0 30px;
            }

            .content-container {
                padding: 30px;
            }

            /* --- 마이페이지 전용 고유 스타일 --- */
            /* 1. 프로필 카드 */
            .profile-card {
                display: flex;
                align-items: center;
                gap: 30px;
                background: var(--white);
                padding: 40px;
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                margin-bottom: 30px;
                position: relative;
            }

            .profile-avatar {
                width: 100px;
                height: 100px;
                background: var(--primary-light);
                color: var(--primary-blue);
                font-size: 3rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .profile-info {
                flex-grow: 1;
            }

            .profile-card-name {
                font-size: 1.5rem;
                font-weight: 800;
                margin-bottom: 8px;
                color: var(--text-dark);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .profile-badge {
                font-size: 0.8rem;
                background: var(--primary-blue);
                color: white;
                padding: 4px 10px;
                border-radius: 20px;
                font-weight: normal;
            }

            .profile-meta {
                font-size: 0.95rem;
                color: var(--text-gray);
                margin-bottom: 15px;
                display: flex;
                gap: 15px;
            }

            .profile-bio {
                font-size: 1rem;
                color: var(--text-dark);
                background: var(--bg-color);
                padding: 12px 20px;
                border-radius: 8px;
                border-left: 4px solid var(--primary-blue);
            }

            .btn-edit-profile {
                position: absolute;
                top: 40px;
                right: 40px;
                padding: 10px 20px;
                background: var(--bg-color);
                color: var(--text-dark);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                transition: 0.2s;
            }

            .btn-edit-profile:hover {
                background: #e5e8eb;
            }

            /* 2. 활동 현황 통계 그리드 */
            .stat-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-box {
                background: var(--white);
                padding: 25px 20px;
                border-radius: 16px;
                box-shadow: var(--shadow-sm);
                text-align: center;
                border: 1px solid var(--border-color);
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .stat-title {
                font-size: 0.95rem;
                color: var(--text-gray);
                margin-bottom: 10px;
            }

            .stat-num {
                font-size: 2rem;
                font-weight: 800;
                color: var(--primary-blue);
                margin-bottom: 15px;
            }

            .stat-link {
                font-size: 0.85rem;
                color: var(--text-gray);
                text-decoration: none;
                display: inline-block;
                padding: 5px 15px;
                background: var(--bg-color);
                border-radius: 20px;
                transition: 0.2s;
            }

            .stat-link:hover {
                background: var(--primary-blue);
                color: white;
            }

            /* 3. 공통 섹션 & 빈 화면(Empty State) */
            .section-card {
                background: var(--white);
                border-radius: 16px;
                padding: 30px;
                box-shadow: var(--shadow-sm);
                margin-bottom: 30px;
            }

            .section-header {
                font-size: 1.2rem;
                font-weight: bold;
                margin-bottom: 20px;
                border-bottom: 2px solid var(--border-color);
                padding-bottom: 15px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .empty-state {
                text-align: center;
                padding: 50px 20px;
                background: var(--bg-color);
                border-radius: 12px;
                border: 1px dashed #ccc;
            }

            .empty-state i {
                font-size: 3rem;
                color: #b4b4bd;
                margin-bottom: 15px;
            }

            .empty-state p {
                color: var(--text-gray);
                margin-bottom: 20px;
                font-size: 0.95rem;
            }

            .btn-action {
                padding: 10px 24px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                font-size: 0.95rem;
                transition: 0.2s;
            }

            .btn-action:hover {
                background: var(--sidebar-hover);
            }

            /* 4. 탭 (가입한 동아리 / 신청 현황) */
            .tab-buttons {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .tab-btn {
                padding: 10px 20px;
                border: 1px solid var(--border-color);
                background: var(--white);
                border-radius: 30px;
                cursor: pointer;
                font-weight: bold;
                color: var(--text-gray);
                transition: 0.2s;
            }

            .tab-btn.active {
                background: var(--primary-blue);
                color: white;
                border-color: var(--primary-blue);
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
                animation: fadeIn 0.3s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(5px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* 5. 로그아웃 버튼 */
            .logout-wrap {
                text-align: right;
                margin-top: 20px;
                margin-bottom: 50px;
            }

            .btn-logout {
                padding: 12px 30px;
                background: transparent;
                color: #d32f2f;
                border: 1px solid #d32f2f;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                transition: 0.2s;
            }

            .btn-logout:hover {
                background: #ffebee;
            }

            /* 6. 모달 (프로필 수정) */
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
                opacity: 0;
                transition: opacity 0.3s;
            }

            .modal-overlay.show {
                display: flex;
                opacity: 1;
            }

            .modal-box {
                background: white;
                width: 100%;
                max-width: 450px;
                border-radius: 16px;
                padding: 30px;
                box-shadow: var(--shadow-lg);
                transform: translateY(-20px);
                transition: transform 0.3s;
            }

            .modal-overlay.show .modal-box {
                transform: translateY(0);
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                font-size: 1.2rem;
                font-weight: bold;
            }

            .btn-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: var(--text-gray);
                cursor: pointer;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                font-size: 0.95rem;
                color: var(--text-dark);
            }

            .form-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 0.95rem;
            }

            .form-group input:focus {
                border-color: var(--primary-blue);
            }

            /* 토글 스위치 (알림 설정) */
            .toggle-wrap {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                background: var(--bg-color);
                border-radius: 8px;
                margin-bottom: 25px;
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 26px;
            }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked+.slider {
                background-color: var(--primary-blue);
            }

            input:checked+.slider:before {
                transform: translateX(24px);
            }

            .btn-save {
                width: 100%;
                padding: 14px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-save:hover {
                background: var(--sidebar-hover);
            }

            /* 반응형 */
            @media (max-width: 768px) {
                .profile-card {
                    flex-direction: column;
                    text-align: center;
                    padding: 30px 20px;
                }

                .btn-edit-profile {
                    position: static;
                    margin-top: 20px;
                    width: 100%;
                }

                .profile-meta {
                    justify-content: center;
                    flex-direction: column;
                    gap: 5px;
                }

                .profile-card-name {
                    justify-content: center;
                }

                .stat-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .page-header {
                    padding: 15px 15px 0 15px;
                }

                .content-container {
                    padding: 15px;
                }

                .header-search {
                    width: 180px;
                }
            }
        </style>
    </head>

    <body>

        <!-- 분리된 공통 사이드바 연동 -->
        <%@ include file="common/sidebar.jsp" %>

            <!-- main.jsp 처럼 전체 페이지를 감싸 밀어내기 효과 적용 -->
            <div class="main-wrapper" id="mainWrapper">

                <!-- main.jsp와 일치하는 상단 헤더 직접 탑재 (사이드바 토글 및 동아리 검색 정상 작동) -->
                <header class="top-header">
                    <div class="header-left">
                        <button class="btn-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>

                        <form class="header-search" onsubmit="searchClub(event)">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" id="searchInput" placeholder="동아리명 검색..." required>
                            <button type="submit" style="display: none;"></button>
                        </form>
                    </div>
                    <div class="header-icons">
                        <i class="fa-regular fa-bell"></i>
                    </div>
                </header>

                <!-- 마이페이지 콘텐츠 영역 시작 -->
                <div class="page-header">
                    <h1>마이페이지</h1>
                    <p>내 활동 내역과 계정 정보를 관리하세요.</p>
                </div>

                <div class="content-container">

                    <!-- 1. 계정 정보 (프로필 카드) -->
                    <div class="profile-card">
                        <div class="profile-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="profile-info">
                            <div class="profile-card-name">
                                이한국 <span class="profile-badge">AI소프트웨어학과</span>
                            </div>
                            <div class="profile-meta">
                                <span><i class="fa-regular fa-envelope"></i> hk.lee@tukorea.ac.kr</span>
                                <span><i class="fa-regular fa-calendar-check"></i> 가입일: 2025.03.02</span>
                            </div>
                            <div class="profile-bio">
                                "안녕하세요! AI소프트웨어학과 2학년 이한국입니다. 웹 개발에 관심이 많습니다!"
                            </div>
                        </div>
                        <button class="btn-edit-profile" onclick="openProfileModal()"><i class="fa-solid fa-pen"></i>
                            프로필 수정</button>
                    </div>

                    <!-- 2. 활동 현황 통계 -->
                    <div class="stat-grid">
                        <div class="stat-box">
                            <div class="stat-title">가입한 동아리</div>
                            <div class="stat-num">2<span style="font-size:1rem;">개</span></div>
                            <a href="#clubSection" class="stat-link">내역 보기 ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">참여한 모임</div>
                            <div class="stat-num">8<span style="font-size:1rem;">회</span></div>
                            <a href="#" class="stat-link">내역 보기 ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">작성한 게시글</div>
                            <div class="stat-num">15<span style="font-size:1rem;">개</span></div>
                            <a href="#" class="stat-link">내역 보기 ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">작성한 댓글</div>
                            <div class="stat-num">37<span style="font-size:1rem;">개</span></div>
                            <a href="#" class="stat-link">내역 보기 ></a>
                        </div>
                    </div>

                    <!-- 3. 내가 만든 소모임 -->
                    <div class="section-card">
                        <div class="section-header">
                            <span><i class="fa-solid fa-user-group"></i> 내가 만든 소모임</span>
                        </div>

                        <!-- 빈 화면 (Empty State) -->
                        <div class="empty-state">
                            <i class="fa-solid fa-seedling"></i>
                            <p>게시한 소모임이 없습니다.<br>관심사가 맞는 학우들과 새로운 모임을 만들어보세요!</p>
                            <button class="btn-action" onclick="location.href='meeting_create.jsp'"><i
                                    class="fa-solid fa-plus"></i> 소모임 만들기</button>
                        </div>
                    </div>

                    <!-- 4. 가입한 동아리 & 신청 현황 (탭 기능) -->
                    <div class="section-card" id="clubSection">
                        <div class="section-header">
                            <span><i class="fa-solid fa-shield-halved"></i> 나의 동아리 활동</span>
                        </div>

                        <div class="tab-buttons">
                            <button class="tab-btn active" onclick="switchTab('joined')">가입한 동아리 (0)</button>
                            <button class="tab-btn" onclick="switchTab('applied')">가입 신청 현황 (0)</button>
                        </div>

                        <!-- 탭 1: 가입한 동아리 내용 -->
                        <div id="tab-joined" class="tab-content active">
                            <div class="empty-state">
                                <i class="fa-solid fa-ghost"></i>
                                <p>아직 가입한 공식 동아리가 없습니다.</p>
                                <button class="btn-action" onclick="location.href='club_main.jsp'">동아리 가입하러 가기</button>
                            </div>
                        </div>

                        <!-- 탭 2: 신청 현황 내용 -->
                        <div id="tab-applied" class="tab-content">
                            <div class="empty-state" style="background: #fafafa;">
                                <i class="fa-solid fa-envelope-open-text"></i>
                                <p>현재 심사 대기 중인 가입 신청서가 없습니다.</p>
                            </div>
                        </div>
                    </div>

                    <!-- 5. 맨 하단 로그아웃 -->
                    <div class="logout-wrap">
                        <button class="btn-logout" onclick="alert('로그아웃 되었습니다.'); location.href='login.jsp';">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> 로그아웃
                        </button>
                    </div>

                </div>
            </div>

            <!-- 6. 프로필 수정 팝업 (모달) -->
            <div class="modal-overlay" id="profileModal">
                <div class="modal-box">
                    <div class="modal-header">
                        프로필 수정
                        <button class="btn-close" onclick="closeProfileModal()"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>

                    <form onsubmit="saveProfile(event)">
                        <div class="form-group">
                            <label>한 줄 자기소개</label>
                            <input type="text" value="안녕하세요! AI소프트웨어학과 2학년 이한국입니다. 웹 개발에 관심이 많습니다!" required>
                        </div>

                        <div class="form-group">
                            <label>새 비밀번호 변경 (선택)</label>
                            <input type="password" placeholder="변경할 비밀번호를 입력하세요">
                        </div>

                        <div class="form-group">
                            <label>새 비밀번호 확인</label>
                            <input type="password" placeholder="비밀번호를 한 번 더 입력하세요">
                        </div>

                        <div class="toggle-wrap">
                            <div>
                                <div style="font-weight: bold; margin-bottom: 4px; color: var(--text-dark);">푸시 알림 설정
                                </div>
                                <div style="font-size: 0.85rem; color: var(--text-gray);">동아리 공지 및 모임 알림 받기</div>
                            </div>
                            <label class="switch">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </div>

                        <button type="submit" class="btn-save">저장하기</button>
                    </form>
                </div>
            </div>

            <!-- 마이페이지 전용 비즈니스 로직 및 통합 이벤트 스크립트 -->
            <script>
                // 헤더 연동형 검색 처리 스크립트 (main.jsp와 동일)
                function searchClub(event) {
                    event.preventDefault();
                    const keyword = document.getElementById('searchInput').value;
                    if (keyword.trim() === '') {
                        alert('검색어를 입력해주세요.');
                    } else {
                        alert("'" + keyword + "' 동아리를 검색합니다. (검색결과 페이지로 이동)");
                    }
                }

                // 1. 프로필 모달 열고 닫기
                const modal = document.getElementById('profileModal');
                function openProfileModal() { modal.classList.add('show'); }
                function closeProfileModal() { modal.classList.remove('show'); }

                // 모달 바깥 배경 클릭 시 닫기
                window.onclick = function (event) {
                    if (event.target == modal) { closeProfileModal(); }
                }

                // 프로필 저장 버튼 클릭 시
                function saveProfile(e) {
                    e.preventDefault();
                    alert('프로필 정보가 성공적으로 수정되었습니다.');
                    closeProfileModal();
                }

                // 2. 탭 전환 로직 (가입한 동아리 / 신청 현황)
                function switchTab(tabName) {
                    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
                    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

                    if (tabName === 'joined') {
                        document.querySelectorAll('.tab-btn')[0].classList.add('active');
                        document.getElementById('tab-joined').classList.add('active');
                    } else if (tabName === 'applied') {
                        document.querySelectorAll('.tab-btn')[1].classList.add('active');
                        document.getElementById('tab-applied').classList.add('active');
                    }
                }
            </script>
    </body>

    </html>