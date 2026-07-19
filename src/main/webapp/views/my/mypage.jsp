<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 마이페이지</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- 공통 CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">

        <!-- 카카오맵 API 로드 -->
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8321f60fb50447223b56820ff2564ac0&libraries=services"></script>

        <style>
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
            }

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

            .content-container {
                padding: 30px;
            }

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
                overflow: hidden;
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
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
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
                cursor: pointer;
            }

            .stat-link:hover {
                background: var(--primary-blue);
                color: white;
            }

            /* 3. 공통 섹션 & 빈 화면 */
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

            /* 로그아웃 버튼 */
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

            /* 모달 공통 */
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
                z-index: 2000;
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
                max-width: 500px;
                border-radius: 16px;
                padding: 30px;
                box-shadow: var(--shadow-lg);
                transform: translateY(-20px);
                transition: transform 0.3s;
                max-height: 90vh;
                overflow-y: auto;
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

            /* 폼 그룹 및 버튼 */
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

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 12px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 0.95rem;
            }

            .form-group input:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                border-color: var(--primary-blue);
            }

            .form-group select:disabled {
                background-color: #f0f0f0;
                color: #888;
                cursor: not-allowed;
            }

            .form-group textarea {
                resize: none;
                font-family: inherit;
            }

            .btn-outline {
                width: 100%;
                padding: 12px;
                background: transparent;
                color: var(--primary-blue);
                border: 1px solid var(--primary-blue);
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-outline:hover {
                background: var(--primary-light);
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

            .notice-text {
                color: #d32f2f;
                font-size: 0.8rem;
                margin-top: 6px;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            /* 활동 현황 내역 리스트 팝업용 CSS */
            .list-modal-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid var(--border-color);
                cursor: pointer;
                transition: background 0.2s;
            }

            .list-modal-item:hover {
                background: #fdfdfd;
            }

            .list-modal-item:last-child {
                border-bottom: none;
            }

            .list-modal-info h5 {
                font-size: 1rem;
                color: var(--text-dark);
                margin-bottom: 5px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 320px;
            }

            .list-modal-info p {
                font-size: 0.85rem;
                color: var(--text-gray);
            }

            .btn-small-link {
                padding: 6px 12px;
                background: var(--primary-light);
                color: var(--primary-blue);
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.8rem;
                font-weight: bold;
                white-space: nowrap;
            }

            .btn-small-link:hover {
                background: var(--primary-blue);
                color: white;
            }

            /* 소모임 지도 전용 CSS */
            .map-search-wrap {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
            }

            .map-search-wrap input {
                flex: 1;
            }

            .map-search-wrap button {
                padding: 0 15px;
                background: var(--text-dark);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: bold;
                white-space: nowrap;
            }

            .map-container {
                width: 100%;
                height: 200px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                background: #eee;
                margin-bottom: 10px;
                position: relative;
                overflow: hidden;
            }

            #modalMap {
                width: 100%;
                height: 100%;
            }

            .search-results {
                max-height: 150px;
                overflow-y: auto;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                display: none;
                margin-bottom: 10px;
            }

            .search-item {
                padding: 10px 15px;
                border-bottom: 1px solid #f0f0f0;
                cursor: pointer;
                font-size: 0.9rem;
                transition: 0.2s;
            }

            .search-item:hover {
                background: var(--bg-color);
            }

            .search-item strong {
                display: block;
                color: var(--text-dark);
                margin-bottom: 3px;
            }

            .search-item span {
                font-size: 0.8rem;
                color: var(--text-gray);
            }

            .selected-loc-info {
                background: var(--bg-color);
                padding: 12px;
                border-radius: 8px;
                font-size: 0.9rem;
                color: var(--text-dark);
                display: none;
                margin-bottom: 10px;
            }

            .selected-loc-info span {
                font-weight: bold;
                color: var(--primary-blue);
            }

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

                .profile-meta,
                .profile-card-name {
                    justify-content: center;
                }

                .profile-meta {
                    flex-direction: column;
                    gap: 5px;
                }

                .stat-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .content-container {
                    padding: 15px;
                }

                .header-search {
                    width: 180px;
                }

                .list-modal-info h5 {
                    max-width: 200px;
                }
            }
        </style>
    </head>

    <body>

        <%@ include file="/views/common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">
                <!-- 상단 헤더 -->
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
                            <div class="profile-bio">안녕하세요! AI소프트웨어학과 2학년 이한국입니다. 웹 개발에 관심이 많습니다!</div>
                        </div>
                        <button class="btn-edit-profile" onclick="openProfileModal()"><i class="fa-solid fa-pen"></i>
                            프로필 수정</button>
                    </div>

                    <!-- 2. 활동 현황 통계 -->
                    <div class="stat-grid">
                        <div class="stat-box">
                            <div class="stat-title">가입한 동아리</div>
                            <div class="stat-num">2<span style="font-size:1rem;">개</span></div>
                            <a href="javascript:void(0);" class="stat-link" onclick="openStatModal('clubsModal')">내역 보기
                                ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">참여한 모임</div>
                            <div class="stat-num">8<span style="font-size:1rem;">회</span></div>
                            <a href="javascript:void(0);" class="stat-link" onclick="openStatModal('meetingsModal')">내역
                                보기 ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">작성한 게시글</div>
                            <div class="stat-num">15<span style="font-size:1rem;">개</span></div>
                            <a href="javascript:void(0);" class="stat-link" onclick="openStatModal('postsModal')">내역 보기
                                ></a>
                        </div>
                        <div class="stat-box">
                            <div class="stat-title">작성한 댓글</div>
                            <div class="stat-num">37<span style="font-size:1rem;">개</span></div>
                            <a href="javascript:void(0);" class="stat-link" onclick="openStatModal('commentsModal')">내역
                                보기 ></a>
                        </div>
                    </div>

                    <!-- 3. 소모임 활동 현황 -->
                    <div class="section-card" id="meetingSection">
                        <div class="section-header">
                            <span><i class="fa-solid fa-user-group"></i> 나의 소모임 활동</span>
                        </div>
                        <div class="tab-buttons">
                            <button class="tab-btn active" onclick="switchMeetingTab('joined')">현재 참여중인 소모임 (0)</button>
                            <button class="tab-btn" onclick="switchMeetingTab('created')">개설한 소모임 (0)</button>
                        </div>
                        <div id="tab-meeting-joined" class="tab-content active">
                            <div class="empty-state">
                                <i class="fa-solid fa-seedling"></i>
                                <p>현재 참여중인 소모임이 없습니다.<br>관심사가 맞는 학우들과 새로운 모임에 참여해보세요!</p>
                                <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/meet/list'">소모임 찾아보기</button>
                            </div>
                        </div>
                        <div id="tab-meeting-created" class="tab-content">
                            <div class="empty-state" style="background: #fafafa;">
                                <i class="fa-solid fa-crown"></i>
                                <p>직접 개설하여 운영 중인 소모임이 없습니다.</p>
                                <button class="btn-action" onclick="openCreateModal()">소모임 만들기</button>
                            </div>
                        </div>
                    </div>

                    <!-- 4. 가입한 동아리 & 신청 현황 -->
                    <div class="section-card" id="clubSection">
                        <div class="section-header">
                            <span><i class="fa-solid fa-shield-halved"></i> 나의 동아리 활동</span>
                        </div>
                        <div class="tab-buttons">
                            <button class="tab-btn active" onclick="switchClubTab('joined')">가입한 동아리 (0)</button>
                            <button class="tab-btn" onclick="switchClubTab('applied')">가입 신청 현황 (0)</button>
                        </div>
                        <div id="tab-club-joined" class="tab-content active">
                            <div class="empty-state">
                                <i class="fa-solid fa-ghost"></i>
                                <p>아직 가입한 공식 동아리가 없습니다.</p>
                                <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/club'">동아리 가입하러 가기</button>
                            </div>
                        </div>
                        <div id="tab-club-applied" class="tab-content">
                            <div class="empty-state" style="background: #fafafa;">
                                <i class="fa-solid fa-envelope-open-text"></i>
                                <p>현재 심사 대기 중인 가입 신청서가 없습니다.</p>
                            </div>
                        </div>
                    </div>

                    <!-- 5. 로그아웃 -->
                    <div class="logout-wrap">
                        <button class="btn-logout" onclick="alert('로그아웃 되었습니다.'); location.href='${pageContext.request.contextPath}/login';">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> 로그아웃
                        </button>
                    </div>
                </div>
            </div>

            <!-- ==========================================
         [모달] 프로필 수정 팝업 
    =========================================== -->
            <div class="modal-overlay" id="profileModal">
                <div class="modal-box">
                    <div class="modal-header">
                        프로필 수정
                        <button class="btn-close" onclick="closeModal('profileModal')"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>
                    <form onsubmit="saveProfile(event)">
                        <div class="form-group">
                            <label>소속 학과 재설정</label>
                            <select required disabled>
                                <option value="">AI소프트웨어학과 (현재 소속)</option>
                                <optgroup label="AI융합대학">
                                    <option value="게임공학과">게임공학과</option>
                                    <option value="소프트웨어전공">소프트웨어전공</option>
                                </optgroup>
                            </select>
                            <div class="notice-text">
                                <i class="fa-solid fa-circle-exclamation"></i> 현재는 학과 변경 기간이 아닙니다.
                            </div>
                        </div>
                        <div class="form-group">
                            <label>한 줄 자기소개</label>
                            <textarea rows="3" required>안녕하세요! AI소프트웨어학과 2학년 이한국입니다. 
웹 개발에 관심이 많습니다!</textarea>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn-outline" onclick="togglePwChange()"
                                style="margin-bottom: 10px;">비밀번호 변경하기</button>
                            <div id="pwChangeArea"
                                style="display:none; background:#f9f9f9; padding:20px; border-radius:8px; border:1px solid var(--border-color);">
                                <div class="form-group">
                                    <label>현재 비밀번호</label>
                                    <input type="password" placeholder="현재 비밀번호 입력">
                                </div>
                                <div class="form-group">
                                    <label>새 비밀번호</label>
                                    <input type="password" placeholder="새 비밀번호 입력">
                                </div>
                                <div class="form-group" style="margin-bottom: 0;">
                                    <label>새 비밀번호 확인</label>
                                    <input type="password" placeholder="새 비밀번호 다시 입력">
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn-save">저장하기</button>
                    </form>
                </div>
            </div>

            <!-- ==========================================
         [모달] 활동 현황 통계 팝업
    =========================================== -->

            <!-- 가입한 동아리 목록 팝업 -->
            <div class="modal-overlay" id="clubsModal">
                <div class="modal-box">
                    <div class="modal-header">가입한 동아리 내역<button class="btn-close" onclick="closeModal('clubsModal')"><i
                                class="fa-solid fa-xmark"></i></button></div>
                    <div>
                        <div class="list-modal-item">
                            <div class="list-modal-info">
                                <h5>Timo (웹개발)</h5>
                                <p>직책: 일반부원 | 가입일: 2025.03.10</p>
                            </div>
                            <button class="btn-small-link"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=1'">이동</button>
                        </div>
                        <div class="list-modal-item">
                            <div class="list-modal-info">
                                <h5>음표 (밴드)</h5>
                                <p>직책: 일반부원 | 가입일: 2025.03.15</p>
                            </div>
                            <button class="btn-small-link"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=2'">이동</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 참여한 모임 목록 팝업 -->
            <div class="modal-overlay" id="meetingsModal">
                <div class="modal-box">
                    <div class="modal-header" style="margin-bottom: 10px;">
                        참여한 모임 내역
                        <button class="btn-close" onclick="closeModal('meetingsModal')"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>
                    <div
                        style="margin-bottom: 15px; text-align: right; border-bottom: 1px solid var(--border-color); padding-bottom: 10px;">
                        <label style="font-size: 0.85rem; cursor: pointer; color: var(--text-gray);">
                            <input type="checkbox" id="hideClosedCheck" onchange="filterMeetings()"
                                style="margin-right: 5px;">종료된 모임 안보기
                        </label>
                    </div>
                    <div id="meetingListContainer">
                        <div class="list-modal-item meeting-item" data-status="진행중">
                            <div class="list-modal-info">
                                <h5>[게임] PC방 5인큐, 지금 당장!</h5>
                                <p>상태: <span style="color:var(--primary-blue); font-weight:bold;">진행중</span> | 날짜:
                                    2026.07.19</p>
                            </div>
                            <button class="btn-small-link"
                                onclick="openMeetingDetailModal('[게임] PC방 5인큐, 지금 당장!', '진행중', '2026.07.19 15:00', '시흥시 정왕동 스타 PC방', '빨리 오세요! 자리 잡아놨습니다.')">상세보기</button>
                        </div>
                        <div class="list-modal-item meeting-item" data-status="종료">
                            <div class="list-modal-info">
                                <h5>[식사] 정문 앞 점심 식사 파티구함</h5>
                                <p>상태: <span style="color:#888; font-weight:bold;">종료</span> | 날짜: 2026.07.18</p>
                            </div>
                            <button class="btn-small-link"
                                onclick="openMeetingDetailModal('[식사] 정문 앞 점심 식사 파티구함', '종료', '2026.07.18 12:00', '학교 정문 앞 마라탕', '점심 식사 맛있게 완료했습니다. 수고하셨어요!')">상세보기</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 참여한 모임 "상세보기" 팝업 -->
            <div class="modal-overlay" id="meetingDetailModal">
                <div class="modal-box">
                    <div class="modal-header">
                        소모임 상세 정보
                        <button class="btn-close" onclick="closeModal('meetingDetailModal')"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>
                    <div class="detail-content-wrap">
                        <h4 id="mdTitle" style="font-size: 1.2rem; color: var(--text-dark); margin-bottom: 10px;"></h4>
                        <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                            <span id="mdStatus"
                                style="padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: bold;"></span>
                            <span id="mdDate"
                                style="font-size: 0.9rem; color: var(--text-gray); display: flex; align-items: center;"></span>
                        </div>
                        <div class="form-group">
                            <label>장소</label>
                            <div id="mdLocation"
                                style="padding: 12px; background: var(--bg-color); border-radius: 8px; font-size: 0.95rem;">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>상세 내용</label>
                            <div id="mdDesc"
                                style="padding: 12px; background: var(--bg-color); border-radius: 8px; font-size: 0.95rem; min-height: 80px;">
                            </div>
                        </div>
                        <button class="btn-outline"
                            onclick="closeModal('meetingDetailModal'); openStatModal('meetingsModal');">목록으로
                            돌아가기</button>
                    </div>
                </div>
            </div>

            <!-- 작성한 게시글 팝업 -->
            <div class="modal-overlay" id="postsModal">
                <div class="modal-box">
                    <div class="modal-header">작성한 게시글 내역<button class="btn-close" onclick="closeModal('postsModal')"><i
                                class="fa-solid fa-xmark"></i></button></div>
                    <div>
                        <!-- board.jsp로 이동 (postId 파라미터 전달) -->
                        <div class="list-modal-item" onclick="location.href='${pageContext.request.contextPath}/board/detail?postId=101'">
                            <div class="list-modal-info">
                                <h5>기숙사 공용 냉장고 반찬 관련 질문합니다</h5>
                                <p>작성일: 2026.07.17 | 조회수: 128</p>
                            </div>
                        </div>
                        <div class="list-modal-item" onclick="location.href='${pageContext.request.contextPath}/board/detail?postId=102'">
                            <div class="list-modal-info">
                                <h5>스프링부트 vs JSP 서블릿 차이점 요약본</h5>
                                <p>작성일: 2026.07.10 | 조회수: 342</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 작성한 댓글 팝업 -->
            <div class="modal-overlay" id="commentsModal">
                <div class="modal-box">
                    <div class="modal-header">작성한 댓글 내역<button class="btn-close"
                            onclick="closeModal('commentsModal')"><i class="fa-solid fa-xmark"></i></button></div>
                    <div>
                        <!-- board.jsp로 이동 (postId 파라미터 전달) -->
                        <div class="list-modal-item" onclick="location.href='${pageContext.request.contextPath}/board/detail?postId=201'">
                            <div class="list-modal-info">
                                <p
                                    style="color:var(--primary-blue); font-weight:bold; margin-bottom:3px; font-size:0.8rem;">
                                    원본 글: UiPath Element 오류 해결법 아시는 분?</p>
                                <h5>저도 그 부분에서 막혔었는데, Selector 편집기 열어서...</h5>
                                <p>작성일: 2026.07.17</p>
                            </div>
                        </div>
                        <div class="list-modal-item" onclick="location.href='${pageContext.request.contextPath}/board/detail?postId=202'">
                            <div class="list-modal-info">
                                <p
                                    style="color:var(--primary-blue); font-weight:bold; margin-bottom:3px; font-size:0.8rem;">
                                    원본 글: 오늘 저녁 같이 순대국 드실 분?</p>
                                <h5>저요! 정문에서 6시에 뵐까요?</h5>
                                <p>작성일: 2026.07.16</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 소모임 생성 모달 (기존 코드와 동일하게 유지) -->
            <div class="modal-overlay" id="createModal">
                <div class="modal-box" style="max-width: 650px;">
                    <div class="modal-header">
                        소모임 생성하기
                        <button class="btn-close" onclick="closeCreateModal()"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>
                    <form onsubmit="submitCreate(event)">
                        <div class="form-group">
                            <label>카테고리</label>
                            <select required>
                                <option value="">선택해주세요</option>
                                <option value="식사">식사</option>
                                <option value="공부">공부</option>
                                <option value="게임">게임</option>
                                <option value="운동">운동</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>모임 제목</label>
                            <input type="text" placeholder="예: 정문 앞 마라탕 같이 드실 분!" required>
                        </div>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(130px, 1fr)); gap: 15px; margin-bottom: 20px;">
                            <div>
                                <label style="font-weight:bold; font-size:0.95rem; margin-bottom:8px; display:block;">모집
                                    인원</label>
                                <input type="number" min="2" max="20" placeholder="예: 4" required
                                    style="width:100%; padding:12px; border:1px solid #eaeaea; border-radius:8px;">
                            </div>
                            <div>
                                <label style="font-weight:bold; font-size:0.95rem; margin-bottom:8px; display:block;">모임
                                    날짜</label>
                                <input type="date" id="meetingDate" required
                                    style="width:100%; padding:12px; border:1px solid #eaeaea; border-radius:8px;">
                            </div>
                            <div>
                                <label style="font-weight:bold; font-size:0.95rem; margin-bottom:8px; display:block;">시작
                                    시간</label>
                                <input type="time" required
                                    style="width:100%; padding:12px; border:1px solid #eaeaea; border-radius:8px;">
                            </div>
                        </div>
                        <!-- 지도 스크립트 기능 부분 -->
                        <div class="form-group">
                            <label>장소 지정 (지도)</label>
                            <div class="map-search-wrap">
                                <input type="text" id="keyword" placeholder="장소를 검색하세요 (학교 반경 3km 내)">
                                <button type="button" onclick="searchPlaces()">검색</button>
                            </div>
                            <div id="placesList" class="search-results"></div>
                            <div class="map-container">
                                <div id="modalMap"></div>
                            </div>
                            <div id="selectedLocInfo" class="selected-loc-info">
                                선택된 장소: <span id="placeNameDisplay">-</span><br>
                                지번: <span id="placeAddressDisplay">-</span>
                            </div>
                            <input type="hidden" id="placeName" required>
                            <input type="hidden" id="placeAddress">
                            <input type="hidden" id="placeLat" required>
                            <input type="hidden" id="placeLng" required>
                        </div>
                        <div class="form-group">
                            <label>상세 내용</label>
                            <textarea placeholder="모임에 대한 자세한 설명을 적어주세요." rows="4" required></textarea>
                        </div>
                        <button type="submit" class="btn-save">모임 등록하기</button>
                    </form>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/js/common.js"></script>
            <script>
                // 모달 공통 함수
                function closeModal(id) { document.getElementById(id).classList.remove('show'); }
                function openStatModal(modalId) { document.getElementById(modalId).classList.add('show'); }

                // 소모임 내역 필터링 및 상세 팝업 제어
                function filterMeetings() {
                    const isChecked = document.getElementById('hideClosedCheck').checked;
                    const items = document.querySelectorAll('.meeting-item');

                    items.forEach(item => {
                        if (isChecked && item.getAttribute('data-status') === '종료') {
                            item.style.display = 'none';
                        } else {
                            item.style.display = 'flex';
                        }
                    });
                }

                function openMeetingDetailModal(title, status, date, location, desc) {
                    closeModal('meetingsModal');

                    document.getElementById('mdTitle').innerText = title;
                    document.getElementById('mdDate').innerHTML = `<i class="fa-regular fa-calendar" style="margin-right: 5px;"></i> \${date}`;
                    document.getElementById('mdLocation').innerText = location;
                    document.getElementById('mdDesc').innerText = desc;

                    const statusBadge = document.getElementById('mdStatus');
                    statusBadge.innerText = status;
                    if (status === '진행중') {
                        statusBadge.style.background = 'var(--primary-light)';
                        statusBadge.style.color = 'var(--primary-blue)';
                    } else {
                        statusBadge.style.background = '#f0f0f0';
                        statusBadge.style.color = '#888';
                    }

                    document.getElementById('meetingDetailModal').classList.add('show');
                }

                // 프로필 및 비밀번호 관련 함수
                function openProfileModal() { document.getElementById('profileModal').classList.add('show'); }
                function saveProfile(e) {
                    e.preventDefault();
                    alert('프로필 정보가 성공적으로 수정되었습니다.');
                    closeModal('profileModal');
                }
                function togglePwChange() {
                    const pwArea = document.getElementById('pwChangeArea');
                    pwArea.style.display = pwArea.style.display === 'none' ? 'block' : 'none';
                }

                // 탭 전환 로직
                function switchClubTab(tabName) {
                    const section = document.getElementById('clubSection');
                    section.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
                    section.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
                    if (tabName === 'joined') {
                        section.querySelectorAll('.tab-btn')[0].classList.add('active');
                        document.getElementById('tab-club-joined').classList.add('active');
                    } else if (tabName === 'applied') {
                        section.querySelectorAll('.tab-btn')[1].classList.add('active');
                        document.getElementById('tab-club-applied').classList.add('active');
                    }
                }

                function switchMeetingTab(tabName) {
                    const section = document.getElementById('meetingSection');
                    section.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
                    section.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
                    if (tabName === 'joined') {
                        section.querySelectorAll('.tab-btn')[0].classList.add('active');
                        document.getElementById('tab-meeting-joined').classList.add('active');
                    } else if (tabName === 'created') {
                        section.querySelectorAll('.tab-btn')[1].classList.add('active');
                        document.getElementById('tab-meeting-created').classList.add('active');
                    }
                }

                // 지도 (소모임 생성용) 관련 간소화 처리
                let map, marker, ps;
                const centerPos = new kakao.maps.LatLng(37.341496, 126.732014); // 학교 중앙 기준

                function openCreateModal() {
                    document.getElementById('createModal').classList.add('show');
                    document.getElementById('meetingDate').value = new Date().toISOString().split('T')[0];

                    if (!map) {
                        setTimeout(() => {
                            const mapContainer = document.getElementById('modalMap');
                            const mapOption = { center: centerPos, level: 3 };
                            map = new kakao.maps.Map(mapContainer, mapOption);
                            marker = new kakao.maps.Marker({ position: centerPos });
                            marker.setMap(map);
                            ps = new kakao.maps.services.Places();

                            kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
                                const latlng = mouseEvent.latLng;
                                marker.setPosition(latlng);
                                setPlaceInfo("사용자 지정 위치", "상세 주소 없음", latlng.getLat(), latlng.getLng());
                            });
                            map.relayout();
                        }, 300);
                    } else {
                        setTimeout(() => { map.relayout(); map.setCenter(centerPos); }, 100);
                    }
                }

                function closeCreateModal() { closeModal('createModal'); }

                function searchPlaces() {
                    const keyword = document.getElementById('keyword').value;
                    if (!keyword.replace(/^\s+|\s+$/g, '')) { alert('검색어를 입력해주세요!'); return false; }
                    ps.keywordSearch(keyword, placesSearchCB, { location: centerPos, radius: 3000 });
                }

                function placesSearchCB(data, status) {
                    const listEl = document.getElementById('placesList');
                    if (status === kakao.maps.services.Status.OK) {
                        listEl.innerHTML = '';
                        listEl.style.display = 'block';

                        data.forEach(place => {
                            const item = document.createElement('div');
                            item.className = 'search-item';
                            item.innerHTML = `<strong>\${place.place_name}</strong><span>\${place.address_name}</span>`;

                            item.onclick = function () {
                                const moveLatLon = new kakao.maps.LatLng(place.y, place.x);
                                map.setCenter(moveLatLon);
                                marker.setPosition(moveLatLon);
                                setPlaceInfo(place.place_name, place.address_name, place.y, place.x);
                                listEl.style.display = 'none';
                            };
                            listEl.appendChild(item);
                        });
                    } else {
                        alert('검색 결과가 존재하지 않거나 오류가 발생했습니다.');
                        listEl.style.display = 'none';
                    }
                }

                function setPlaceInfo(name, address, lat, lng) {
                    document.getElementById('selectedLocInfo').style.display = 'block';
                    document.getElementById('placeNameDisplay').innerText = name;
                    document.getElementById('placeAddressDisplay').innerText = address;
                    document.getElementById('placeName').value = name;
                    document.getElementById('placeAddress').value = address;
                    document.getElementById('placeLat').value = lat;
                    document.getElementById('placeLng').value = lng;
                }

                function submitCreate(e) {
                    e.preventDefault();
                    if (!document.getElementById('placeLat').value) {
                        alert("지도에서 모임 장소를 검색하거나 클릭하여 지정해주세요.");
                        return;
                    }
                    alert('새로운 모임이 성공적으로 생성되었습니다!');
                    closeCreateModal();
                }

                // 외부 클릭 시 모달 닫기
                window.onclick = function (e) {
                    if (e.target.classList.contains('modal-overlay')) {
                        e.target.classList.remove('show');
                    }
                }
            </script>
    </body>

    </html>