<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 자율 소모임</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- 공통 CSS (절대 경로) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">

        <!-- 카카오맵 API 로드 -->
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8321f60fb50447223b56820ff2564ac0&libraries=services"></script>

        <style>
            /* --- 기본 레이아웃 강제 정렬 --- */
            .main-wrapper {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                min-width: 0;
            }

            .page-header {
                padding: 30px 30px 0 30px;
                margin-bottom: -10px;
            }

            .content-container {
                padding: 20px 30px;
                width: 100%;
                box-sizing: border-box;
                min-width: 0;
                flex-grow: 1;
            }

            .header-search {
                display: none !important;
            }

            /* --- 모임 컨트롤 바 (카테고리, 검색, 버튼) --- */
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
                padding-bottom: 5px;
            }

            .cat-btn {
                padding: 8px 18px;
                border: 1px solid var(--border-color);
                background: var(--white);
                border-radius: 20px;
                font-size: 0.9rem;
                cursor: pointer;
                color: var(--text-gray);
                transition: 0.2s;
                white-space: nowrap;
                font-weight: 500;
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

            .sort-select {
                padding: 8px 12px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
                font-size: 0.9rem;
                color: var(--text-dark);
                cursor: pointer;
            }

            .board-search-box {
                display: flex;
                align-items: center;
                background: var(--white);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 6px 12px;
            }

            .board-search-box input {
                border: none;
                outline: none;
                padding: 4px;
                font-size: 0.9rem;
                width: 130px;
            }

            .board-search-box button {
                background: none;
                border: none;
                color: var(--primary-blue);
                cursor: pointer;
            }

            .btn-outline {
                padding: 9px 16px;
                border: 1px solid var(--primary-blue);
                background: var(--white);
                color: var(--primary-blue);
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
                white-space: nowrap;
            }

            .btn-outline:hover {
                background: #eef6ff;
            }

            .btn-primary {
                padding: 10px 18px;
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
                transition: 0.2s;
            }

            .btn-primary:hover {
                background: var(--sidebar-hover);
            }

            /* --- 모임 카드 그리드 --- */
            .meeting-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }

            .meeting-card {
                background: var(--white);
                border-radius: 16px;
                border: 1px solid var(--border-color);
                overflow: hidden;
                box-shadow: var(--shadow-sm);
                cursor: pointer;
                transition: 0.2s;
                display: flex;
                flex-direction: column;
            }

            .meeting-card:hover {
                transform: translateY(-5px);
                border-color: var(--primary-blue);
                box-shadow: 0 8px 20px rgba(0, 91, 170, 0.1);
            }

            .card-img {
                height: 110px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: white;
                font-weight: bold;
                position: relative;
            }

            .bg-meal {
                background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            }

            .bg-study {
                background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
            }

            .bg-game {
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            }

            .bg-sports {
                background: linear-gradient(135deg, #fccb90 0%, #d57eeb 100%);
            }

            .bg-taxi {
                background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
            }

            .status-badge {
                position: absolute;
                top: 12px;
                left: 12px;
                background: rgba(0, 0, 0, 0.6);
                color: white;
                font-size: 0.75rem;
                padding: 4px 8px;
                border-radius: 6px;
                font-weight: bold;
            }

            .status-urgent {
                background: #d32f2f;
            }

            .card-content {
                padding: 20px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }

            .card-title {
                font-size: 1.05rem;
                font-weight: bold;
                color: var(--text-dark);
                margin-bottom: 15px;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .card-info {
                font-size: 0.85rem;
                color: var(--text-gray);
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .card-info span {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .card-info i {
                width: 14px;
                text-align: center;
                color: var(--primary-blue);
            }

            .card-footer {
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #f0f0f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.85rem;
                color: var(--text-gray);
            }

            .people-count {
                font-weight: bold;
                color: var(--primary-blue);
            }

            /* --- 모달 공통 --- */
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
            }

            .modal-overlay.show {
                display: flex;
            }

            .modal-box {
                background: white;
                width: 100%;
                max-width: 650px;
                border-radius: 16px;
                padding: 30px;
                box-shadow: var(--shadow-lg);
                max-height: 90vh;
                overflow-y: auto;
                position: relative;
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

            /* 폼 공통 */
            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                font-size: 0.9rem;
                font-weight: bold;
                margin-bottom: 8px;
                color: var(--text-dark);
            }

            .form-group input,
            .form-group select,
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
                height: 100px;
                resize: none;
            }

            /* 모달 내 지도/검색 전용 CSS */
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
                height: 250px;
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

            .search-item:last-child {
                border-bottom: none;
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
            }

            .selected-loc-info span {
                font-weight: bold;
                color: var(--primary-blue);
            }

            /* 참여 모달 (상세 보기) */
            .view-title {
                font-size: 1.3rem;
                font-weight: bold;
                color: var(--text-dark);
                margin-bottom: 10px;
                line-height: 1.4;
            }

            .view-meta-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                background: var(--bg-color);
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            .view-meta-item {
                font-size: 0.9rem;
                color: var(--text-dark);
                display: flex;
                align-items: center;
            }

            .view-meta-item i {
                color: var(--primary-blue);
                width: 20px;
            }

            .view-desc {
                font-size: 0.95rem;
                line-height: 1.6;
                color: var(--text-dark);
                margin-bottom: 25px;
                padding: 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                min-height: 100px;
            }

            .btn-join {
                width: 100%;
                padding: 14px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1.05rem;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-join.cancel {
                background: #d32f2f;
            }

            .btn-report {
                position: absolute;
                top: 35px;
                right: 60px;
                font-size: 0.8rem;
                color: #d32f2f;
                text-decoration: none;
                font-weight: bold;
            }

            .btn-report:hover {
                text-decoration: underline;
            }

            /* --- 댓글 영역 스타일 (채팅방 대체) --- */
            .comment-section {
                margin-top: 20px;
                border-top: 1px solid var(--border-color);
                padding-top: 20px;
                display: none;
            }

            .comment-list {
                max-height: 200px;
                overflow-y: auto;
                margin-bottom: 15px;
                padding-right: 5px;
            }

            .comment-list::-webkit-scrollbar {
                width: 5px;
            }

            .comment-list::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 4px;
            }

            .comment-item {
                padding: 12px 0;
                border-bottom: 1px dashed var(--border-color);
            }

            .comment-item:last-child {
                border-bottom: none;
            }

            .comment-author {
                font-weight: bold;
                font-size: 0.9rem;
                margin-bottom: 4px;
                color: var(--text-dark);
            }

            .comment-text {
                font-size: 0.95rem;
                color: var(--text-dark);
                line-height: 1.4;
            }

            .comment-input-wrap {
                display: flex;
                gap: 10px;
            }

            .comment-input-wrap input {
                flex: 1;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                outline: none;
            }

            .comment-input-wrap button {
                padding: 10px 15px;
                background: var(--text-dark);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                white-space: nowrap;
                font-weight: bold;
            }

            /* 내 모임 리스트 스타일 */
            .my-meeting-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid var(--border-color);
            }

            .my-meeting-info h5 {
                font-size: 1rem;
                margin-bottom: 5px;
                color: var(--text-dark);
            }

            .my-meeting-info p {
                font-size: 0.85rem;
                color: var(--text-gray);
            }

            .btn-small-cancel {
                padding: 6px 12px;
                background: #ffebee;
                color: #d32f2f;
                border: 1px solid #d32f2f;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.8rem;
                font-weight: bold;
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

                .view-meta-grid {
                    grid-template-columns: 1fr;
                }

                .btn-primary {
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

                .btn-primary span {
                    display: none;
                }
            }
        </style>
    </head>

    <body>

        <%@ include file="/views/common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">
                <%@ include file="/views/common/header.jsp" %>

                    <div class="content-container">
                        <!-- 상단 컨트롤 영역 -->
                        <div class="board-controls">
                            <div class="category-tabs">
                                <button class="cat-btn active">전체</button>
                                <button class="cat-btn">식사</button>
                                <button class="cat-btn">공부</button>
                                <button class="cat-btn">게임</button>
                                <button class="cat-btn">운동</button>
                                <button class="cat-btn">택시</button>
                                <button class="cat-btn">기타</button>
                            </div>

                            <div class="action-group">
                                <select class="sort-select">
                                    <option value="latest">최신순</option>
                                    <option value="oldest">오래된순</option>
                                    <option value="urgent">마감임박순</option>
                                </select>

                                <div class="board-search-box">
                                    <input type="text" placeholder="모임 검색...">
                                    <button><i class="fa-solid fa-magnifying-glass"></i></button>
                                </div>

                                <button class="btn-outline" onclick="openMyMeetingsModal()">내 모임 보기</button>

                                <button class="btn-primary" onclick="openCreateModal()">
                                    <i class="fa-solid fa-plus"></i> <span>모임 만들기</span>
                                </button>
                            </div>
                        </div>

                        <!-- 모임 카드 그리드 -->
                        <div class="meeting-grid">
                            <div class="meeting-card"
                                onclick="openJoinModal('식사', '정문 앞 점심 식사 파티구함', '2', '4', '2026-07-18 11:00', '지갑', '정문 앞 맘스터치', '혼밥하기 싫어서 올립니다. 같이 햄버거 세트 드실 분 구해요!')">
                                <div class="card-img bg-meal"><span class="status-badge">모집중</span><i
                                        class="fa-solid fa-utensils"></i></div>
                                <div class="card-content">
                                    <div class="card-title">[식사] 정문 앞 점심 식사 파티구함</div>
                                    <div class="card-info"><span><i class="fa-solid fa-location-dot"></i> 정문 앞
                                            맘스터치</span><span><i class="fa-regular fa-clock"></i> 2026-07-18 11:00</span>
                                    </div>
                                    <div class="card-footer"><span><i class="fa-solid fa-box-open"></i> 지갑</span><span
                                            class="people-count">2 / 4명</span></div>
                                </div>
                            </div>

                            <div class="meeting-card"
                                onclick="openJoinModal('게임', 'PC방 5인큐, 지금 당장!', '4', '5', '2026-07-18 13:00', '피시방비', 'E동 앞 제우스 PC방', '롤 5인큐 하실 분! 현재 4명 대기중입니다. 즐겜 유저 환영해요.')">
                                <div class="card-img bg-game"><span class="status-badge status-urgent">마감임박</span><i
                                        class="fa-solid fa-gamepad"></i></div>
                                <div class="card-content">
                                    <div class="card-title">[게임] PC방 5인큐, 지금 당장!</div>
                                    <div class="card-info"><span><i class="fa-solid fa-location-dot"></i> E동 앞 제우스
                                            PC방</span><span><i class="fa-regular fa-clock"></i> 2026-07-18 13:00</span>
                                    </div>
                                    <div class="card-footer"><span><i class="fa-solid fa-box-open"></i> 피시방비</span><span
                                            class="people-count">4 / 5명</span></div>
                                </div>
                            </div>

                            <div class="meeting-card"
                                onclick="openJoinModal('운동', 'TU 체육관 농구 한 판 할 사람', '3', '5', '2026-07-18 18:00', '운동화, 물', 'TU 체육관 야외 코트', '다들 오랜만에 농구 어떠세요? 공은 제가 챙길게요!')">
                                <div class="card-img bg-sports"><span class="status-badge">모집중</span><i
                                        class="fa-solid fa-basketball"></i></div>
                                <div class="card-content">
                                    <div class="card-title">[운동] TU 체육관 농구 한 판 할 사람</div>
                                    <div class="card-info"><span><i class="fa-solid fa-location-dot"></i> TU 체육관 야외
                                            코트</span><span><i class="fa-regular fa-clock"></i> 2026-07-18 18:00</span>
                                    </div>
                                    <div class="card-footer"><span><i class="fa-solid fa-box-open"></i> 운동화,
                                            물</span><span class="people-count">3 / 5명</span></div>
                                </div>
                            </div>

                            <div class="meeting-card"
                                onclick="openJoinModal('택시', '정왕역으로 택시 같이 타실 분', '1', '4', '2026-07-19 15:30', '택시비 N빵', '정문 대리석 앞', '비와서 버스 타기 힘드네요. 택시비 N빵 하실 분 3분 구합니다.')">
                                <div class="card-img bg-taxi"><span class="status-badge">모집중</span><i
                                        class="fa-solid fa-taxi"></i></div>
                                <div class="card-content">
                                    <div class="card-title">[택시] 정왕역으로 택시 같이 타실 분</div>
                                    <div class="card-info"><span><i class="fa-solid fa-location-dot"></i> 정문 대리석
                                            앞</span><span><i class="fa-regular fa-clock"></i> 2026-07-19 15:30</span>
                                    </div>
                                    <div class="card-footer"><span><i class="fa-solid fa-box-open"></i> 택시비
                                            N빵</span><span class="people-count">1 / 4명</span></div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>

            <!-- ==============================================
         [모달 1] 모임 만들기 팝업 (날짜/시간 UI 및 지도 통합)
    =============================================== -->
            <div class="modal-overlay" id="createModal">
                <div class="modal-box">
                    <div class="modal-header">
                        모임 생성하기
                        <button class="btn-close" onclick="closeCreateModal()"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>

                    <form id="createForm" onsubmit="submitCreate(event)">
                        <div class="form-group">
                            <label>카테고리</label>
                            <select required>
                                <option value="">선택해주세요</option>
                                <option value="식사">식사</option>
                                <option value="공부">공부</option>
                                <option value="게임">게임</option>
                                <option value="운동">운동</option>
                                <option value="택시">택시</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>모임 제목</label>
                            <input type="text" placeholder="예: 정문 앞 마라탕 같이 드실 분!" required>
                        </div>

                        <!-- 🌟 날짜 및 시간 입력 (Date & Time Picker) 🌟 -->
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(130px, 1fr)); gap: 15px;">
                            <div class="form-group">
                                <label>모집 인원 (본인 포함)</label>
                                <input type="number" min="2" max="20" placeholder="예: 4" required>
                            </div>
                            <div class="form-group">
                                <label>모임 날짜</label>
                                <input type="date" id="meetingDate" required>
                            </div>
                            <div class="form-group">
                                <label>시작 시간</label>
                                <input type="time" id="meetingTime" required>
                            </div>
                        </div>

                        <!-- 🌟 카카오맵 장소 검색 영역 🌟 -->
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
                            <label>준비물</label>
                            <input type="text" placeholder="예: 식비 (더치페이)">
                        </div>
                        <div class="form-group">
                            <label>상세 내용</label>
                            <textarea placeholder="모임에 대한 자세한 설명을 적어주세요." required></textarea>
                        </div>

                        <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">모임
                            등록하기</button>
                    </form>
                </div>
            </div>

            <!-- ==============================================
         [모달 2] 모임 참여하기 (상세보기) 팝업 (댓글 영역 포함)
    =============================================== -->
            <div class="modal-overlay" id="joinModal">
                <div class="modal-box">
                    <div class="modal-header">
                        <span id="joinCategory"
                            style="color: var(--primary-blue); font-weight: bold; font-size: 1rem;">[카테고리]</span>
                        <a href="#" class="btn-report" onclick="alert('신고가 접수되었습니다.')"><i
                                class="fa-solid fa-triangle-exclamation"></i> 신고하기</a>
                        <button class="btn-close" onclick="closeJoinModal()"><i class="fa-solid fa-xmark"></i></button>
                    </div>

                    <h2 class="view-title" id="joinTitle">모임 제목이 들어갑니다</h2>
                    <div class="view-meta-grid">
                        <div class="view-meta-item"><i class="fa-solid fa-users"></i> 인원: <span
                                id="joinPeople">0/0</span>명</div>
                        <div class="view-meta-item"><i class="fa-regular fa-clock"></i> 시간: <span
                                id="joinTime">시간</span></div>
                        <div class="view-meta-item"><i class="fa-solid fa-location-dot"></i> 장소: <span
                                id="joinLocation">장소</span></div>
                        <div class="view-meta-item"><i class="fa-solid fa-box-open"></i> 준비물: <span
                                id="joinMaterial">없음</span></div>
                    </div>

                    <div style="font-weight: bold; margin-bottom: 8px; font-size: 0.95rem;">상세 내용</div>
                    <div class="view-desc" id="joinDesc">모임 상세 내용이 여기에 표시됩니다.</div>
                    <button class="btn-join" id="btnJoinAction" onclick="toggleJoin()">참여하기</button>

                    <!-- 🌟 참여 시 나타나는 댓글 게시판 영역 🌟 -->
                    <div class="comment-section" id="commentSection">
                        <div style="font-weight: bold; margin-bottom: 15px; font-size: 0.95rem;">모임 소통 <span
                                style="color: var(--primary-blue);">2</span></div>

                        <div class="comment-list">
                            <div class="comment-item">
                                <div class="comment-author">방장</div>
                                <div class="comment-text">안녕하세요! 참여해주셔서 감사합니다. 궁금한 점 편하게 남겨주세요.</div>
                            </div>
                            <div class="comment-item">
                                <div class="comment-author">익명1</div>
                                <div class="comment-text">네! 장소 도착하면 다시 댓글 남기겠습니다 ㅎㅎ</div>
                            </div>
                        </div>

                        <div class="comment-input-wrap">
                            <input type="text" placeholder="참여자들과 소통할 댓글을 남겨보세요...">
                            <button onclick="alert('댓글이 등록되었습니다.')">등록</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==============================================
         [모달 3] 내 모임 보기 팝업
    =============================================== -->
            <div class="modal-overlay" id="myMeetingsModal">
                <div class="modal-box">
                    <div class="modal-header">
                        내가 참여한 모임
                        <button class="btn-close" onclick="closeMyMeetingsModal()"><i
                                class="fa-solid fa-xmark"></i></button>
                    </div>
                    <div>
                        <div class="my-meeting-item">
                            <div class="my-meeting-info">
                                <h5>[식사] 정문 앞 점심 식사 파티구함</h5>
                                <p>2026-07-18 11:00 | 정문 앞 맘스터치</p>
                            </div>
                            <button class="btn-small-cancel" onclick="alert('참여가 취소되었습니다.')">취소</button>
                        </div>
                    </div>
                    <button class="btn-outline" style="width: 100%; margin-top: 20px; justify-content: center;"
                        onclick="closeMyMeetingsModal()">닫기</button>
                </div>
            </div>

            <!-- 공통 스크립트 및 페이지 제어 -->
            <script src="${pageContext.request.contextPath}/js/common.js"></script>
            <script>
                // --- 1. 모달 제어 로직 ---
                function openMyMeetingsModal() { document.getElementById('myMeetingsModal').classList.add('show'); }
                function closeMyMeetingsModal() { document.getElementById('myMeetingsModal').classList.remove('show'); }

                let currentJoinPeople = 0; let maxJoinPeople = 0;

                function openJoinModal(cat, title, currentP, maxP, time, material, loc, desc) {
                    document.getElementById('joinCategory').innerText = `[${cat}]`;
                    document.getElementById('joinTitle').innerText = title;
                    document.getElementById('joinPeople').innerText = `${currentP}/${maxP}`;
                    document.getElementById('joinTime').innerText = time;
                    document.getElementById('joinMaterial').innerText = material;
                    document.getElementById('joinLocation').innerText = loc;
                    document.getElementById('joinDesc').innerText = desc;

                    currentJoinPeople = parseInt(currentP); maxJoinPeople = parseInt(maxP);
                    const joinBtn = document.getElementById('btnJoinAction');
                    joinBtn.innerText = "참여하기"; joinBtn.classList.remove('cancel');

                    // 초기 열었을 때는 댓글 영역 숨김 처리
                    document.getElementById('commentSection').style.display = "none";
                    document.getElementById('joinModal').classList.add('show');
                }

                function closeJoinModal() { document.getElementById('joinModal').classList.remove('show'); }

                function toggleJoin() {
                    const joinBtn = document.getElementById('btnJoinAction');
                    const commentSection = document.getElementById('commentSection');

                    if (joinBtn.innerText === "참여하기") {
                        joinBtn.innerText = "참여 취소하기";
                        joinBtn.classList.add('cancel');
                        commentSection.style.display = "block"; // 댓글 영역 오픈
                        currentJoinPeople++;
                    } else {
                        if (confirm("참여를 취소하시겠습니까?")) {
                            joinBtn.innerText = "참여하기";
                            joinBtn.classList.remove('cancel');
                            commentSection.style.display = "none"; // 댓글 영역 숨김
                            currentJoinPeople--;
                        }
                    }
                    document.getElementById('joinPeople').innerText = `${currentJoinPeople}/${maxJoinPeople}`;
                }

                window.onclick = function (e) {
                    if (e.target == document.getElementById('createModal')) closeCreateModal();
                    if (e.target == document.getElementById('joinModal')) closeJoinModal();
                    if (e.target == document.getElementById('myMeetingsModal')) closeMyMeetingsModal();
                }

                // --- 2. 카카오맵 연동: 장소 검색 및 좌표 설정 ---
                let map, marker, ps;
                const centerPos = new kakao.maps.LatLng(37.341496, 126.732014); // 학교 중앙 좌표

                function openCreateModal() {
                    document.getElementById('createModal').classList.add('show');

                    // 🌟 모달 오픈 시 오늘 날짜 자동 설정 🌟
                    const today = new Date().toISOString().split('T')[0];
                    document.getElementById('meetingDate').value = today;

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

                function closeCreateModal() {
                    document.getElementById('createModal').classList.remove('show');
                }

                function searchPlaces() {
                    const keyword = document.getElementById('keyword').value;
                    if (!keyword.replace(/^\s+|\s+$/g, '')) {
                        alert('검색어를 입력해주세요!');
                        return false;
                    }

                    ps.keywordSearch(keyword, placesSearchCB, {
                        location: centerPos,
                        radius: 3000 // 반경 3km 제한
                    });
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
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        alert('학교 반경 3km 내에 검색 결과가 존재하지 않습니다.');
                        listEl.style.display = 'none';
                    } else {
                        alert('검색 중 오류가 발생했습니다.');
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

                    // 날짜 및 시간 값도 함께 전송 가능함을 확인
                    const mDate = document.getElementById('meetingDate').value;
                    const mTime = document.getElementById('meetingTime').value;

                    if (!document.getElementById('placeLat').value) {
                        alert("지도에서 모임 장소를 검색하거나 클릭하여 지정해주세요.");
                        return;
                    }

                    alert(`모임이 성공적으로 생성되었습니다!\n- 일정: \${mDate} \${mTime}\n- 저장된 좌표: \${document.getElementById('placeLat').value}`);
                    closeCreateModal();
                }
            </script>
    </body>

    </html>