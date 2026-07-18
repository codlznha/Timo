<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 지도 검색</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- 공통 CSS (절대 경로) -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">

        <style>
            /* --- 지도 페이지 전용 전체화면 레이아웃 --- */
            .main-wrapper {
                display: flex;
                flex-direction: column;
                height: 100vh;
                overflow: hidden;
            }

            .header-search {
                display: none !important;
            }

            .map-area-container {
                position: relative;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }

            #mapArea {
                width: 100%;
                flex-grow: 1;
                background-color: #E5E5E5;
            }

            /* --- 플로팅 필터 (탐색 반경 슬라이드바 설정) --- */
            .floating-filter {
                position: absolute;
                top: 20px;
                left: 20px;
                background: var(--white);
                padding: 15px 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
                z-index: 10;
                border: 1px solid var(--border-color);
                width: 300px;
            }

            .floating-filter h3 {
                font-size: 0.95rem;
                margin-bottom: 10px;
                color: var(--text-dark);
                display: flex;
                align-items: center;
                gap: 6px;
            }

            /* 슬라이드바 UI */
            .slider-container {
                width: 100%;
            }

            .slider-container input[type="range"] {
                width: 100%;
                accent-color: var(--primary-blue);
                cursor: pointer;
            }

            .slider-labels {
                display: flex;
                justify-content: space-between;
                font-size: 0.8rem;
                color: var(--text-gray);
                margin-top: 5px;
            }

            #radiusText {
                font-weight: bold;
                color: var(--primary-blue);
                font-size: 0.9rem;
            }

            /* --- 하단 모임 정보 카드 (Bottom Sheet) --- */
            .bottom-sheet {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                background: linear-gradient(to top, rgba(245, 246, 248, 1) 80%, rgba(245, 246, 248, 0.9) 100%);
                padding: 20px;
                box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.1);
                z-index: 20;
                transform: translateY(110%);
                transition: transform 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                display: flex;
                flex-direction: column;
                border-top-left-radius: 20px;
                border-top-right-radius: 20px;
            }

            .bottom-sheet.show {
                transform: translateY(0);
            }

            .sheet-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .sheet-header h3 {
                font-size: 1.1rem;
                color: var(--text-dark);
            }

            .btn-sheet-close {
                background: var(--white);
                border: 1px solid var(--border-color);
                border-radius: 50%;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                color: var(--text-gray);
            }

            .card-slider {
                display: flex;
                gap: 15px;
                overflow-x: auto;
                scroll-snap-type: x mandatory;
                padding-bottom: 10px;
                -webkit-overflow-scrolling: touch;
            }

            .card-slider::-webkit-scrollbar {
                height: 6px;
            }

            .card-slider::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 4px;
            }

            .mini-card {
                flex: 0 0 280px;
                scroll-snap-align: start;
                background: var(--white);
                border-radius: 12px;
                padding: 15px;
                border: 1px solid var(--border-color);
                box-shadow: var(--shadow-sm);
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .mini-card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
            }

            .cat-badge {
                font-size: 0.75rem;
                padding: 4px 8px;
                border-radius: 4px;
                font-weight: bold;
                background: var(--primary-light);
                color: var(--primary-blue);
            }

            .status-badge {
                font-size: 0.75rem;
                padding: 4px 8px;
                border-radius: 4px;
                font-weight: bold;
                background: #e0e0e0;
                color: #555;
            }

            .status-badge.active {
                background: #ffebee;
                color: #d32f2f;
            }

            .mini-card h4 {
                font-size: 1rem;
                color: var(--text-dark);
                margin: 5px 0;
                line-height: 1.3;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .mini-card-info {
                font-size: 0.85rem;
                color: var(--text-gray);
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .btn-detail {
                margin-top: 10px;
                width: 100%;
                padding: 8px;
                background: var(--primary-blue);
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 0.9rem;
                font-weight: bold;
                cursor: pointer;
                transition: 0.2s;
            }

            .btn-detail:hover {
                background: var(--sidebar-hover);
            }

            /* --- 모달 공통 (상세보기 팝업용) --- */
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
                z-index: 3000;
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

            /* 댓글 (채팅방) 스타일 */
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

            .comment-item {
                padding: 12px 0;
                border-bottom: 1px dashed var(--border-color);
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

            /* 모바일 대응 */
            @media (max-width: 768px) {
                .floating-filter {
                    top: 10px;
                    left: 10px;
                    right: 10px;
                    padding: 10px 15px;
                    width: auto;
                }

                .mini-card {
                    flex: 0 0 85vw;
                }

                .bottom-sheet {
                    padding: 15px 15px 25px 15px;
                }

                .view-meta-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>

        <!-- 🌟 카카오맵 API 동기 로드 (clusterer 라이브러리 추가!) 🌟 -->
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8321f60fb50447223b56820ff2564ac0&libraries=clusterer"></script>
    </head>

    <body>

        <!-- 사이드바 -->
        <%@ include file="/common/sidebar.jsp" %>

            <div class="main-wrapper" id="mainWrapper">
                <!-- 헤더 -->
                <%@ include file="/common/header.jsp" %>

                    <div class="map-area-container">
                        <!-- 플로팅 필터 (슬라이드바) 영역 -->
                        <div class="floating-filter">
                            <h3><i class="fa-solid fa-location-crosshairs" style="color: var(--primary-blue);"></i> 탐색
                                반경 설정</h3>
                            <div class="slider-container">
                                <input type="range" id="radiusSlider" min="500" max="3000" step="100" value="500"
                                    oninput="updateRadiusText()" onchange="updateRadius()">
                                <div class="slider-labels">
                                    <span>500m</span>
                                    <span id="radiusText">500m</span>
                                    <span>3km</span>
                                </div>
                            </div>
                        </div>

                        <!-- 지도 영역 -->
                        <div id="mapArea"></div>

                        <!-- 하단 모임 슬라이드 카드 -->
                        <div class="bottom-sheet" id="bottomSheet">
                            <div class="sheet-header">
                                <h3 id="sheetTitle">이 위치의 모임 (0개)</h3>
                                <button class="btn-sheet-close" onclick="closeBottomSheet()"><i
                                        class="fa-solid fa-xmark"></i></button>
                            </div>
                            <div class="card-slider" id="cardSlider">
                                <!-- 자바스크립트로 카드가 생성되어 들어갑니다. -->
                            </div>
                        </div>
                    </div>
            </div>

            <!-- ==============================================
         [모달] 모임 참여하기 (상세보기) 팝업
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

                    <h2 class="view-title" id="joinTitle">모임 제목</h2>
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
                    <div class="view-desc" id="joinDesc">내용</div>
                    <button class="btn-join" id="btnJoinAction" onclick="toggleJoin()">참여하기</button>

                    <!-- 참여 시 나타나는 소통(댓글) 영역 -->
                    <div class="comment-section" id="commentSection">
                        <div style="font-weight: bold; margin-bottom: 15px; font-size: 0.95rem;">모임 소통 <span
                                style="color: var(--primary-blue);">2</span></div>
                        <div class="comment-list">
                            <div class="comment-item">
                                <div class="comment-author">방장</div>
                                <div class="comment-text">안녕하세요! 참여해주셔서 감사합니다.</div>
                            </div>
                            <div class="comment-item">
                                <div class="comment-author">익명1</div>
                                <div class="comment-text">도착하면 다시 댓글 남길게요!</div>
                            </div>
                        </div>
                        <div class="comment-input-wrap">
                            <input type="text" placeholder="참여자들과 소통할 댓글을 남겨보세요...">
                            <button onclick="alert('댓글이 등록되었습니다.')">등록</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/js/common.js"></script>
            <script>
                // --- 1. 가상의 모임 데이터 ---
                const dummyMeetings = [
                    { id: 1, title: "[식사] 정문 앞 점심 식사 파티구함", cat: "식사", curP: 2, maxP: 4, time: "2026-07-18 11:00", status: "모집중", lat: 37.341496, lng: 126.732014, material: "지갑", loc: "정문 앞 맘스터치", desc: "혼밥하기 싫어서 올립니다. 같이 햄버거 드실 분!" },
                    { id: 2, title: "[택시] 정왕역으로 같이 가실 분", cat: "택시", curP: 1, maxP: 4, time: "2026-07-19 15:30", status: "모집중", lat: 37.341496, lng: 126.732014, material: "택시비 N빵", loc: "정문 대리석 앞", desc: "비와서 버스 타기 힘드네요. 택시비 N빵 하실 분 구해요." },
                    { id: 3, title: "[게임] PC방 5인큐, 지금 당장!", cat: "게임", curP: 4, maxP: 5, time: "2026-07-18 13:00", status: "마감임박", lat: 37.342500, lng: 126.733000, material: "피시방비", loc: "E동 앞 제우스 PC방", desc: "롤 5인큐 하실 분! 현재 4명 대기중입니다." },
                    { id: 4, title: "[공부] 정왕역 앞 카페 스터디", cat: "공부", curP: 3, maxP: 4, time: "2026-07-20 14:00", status: "모집중", lat: 37.344000, lng: 126.739000, material: "노트북, 필기도구", loc: "정왕역 앞 이디야", desc: "기말고사 대비 스터디 구합니다." },
                    { id: 5, title: "[운동] 오이도 자전거 라이딩", cat: "운동", curP: 2, maxP: 8, time: "2026-07-25 10:00", status: "모집중", lat: 37.362000, lng: 126.730000, material: "자전거, 물", loc: "오이도 빨간등대", desc: "주말 아침 상쾌하게 라이딩 하실 분!" }
                ];

                // 좌표를 Key로 모임 데이터를 그룹화
                const groupedMeetings = {};
                dummyMeetings.forEach(m => {
                    const key = m.lat + "_" + m.lng;
                    if (!groupedMeetings[key]) groupedMeetings[key] = [];
                    groupedMeetings[key].push(m);
                });

                // --- 2. 카카오맵 및 클러스터러 변수 ---
                let map, circle, clusterer;
                let markers = [];
                const centerPos = new kakao.maps.LatLng(37.341496, 126.732014); // 학교 중앙

                // --- 3. 지도 및 클러스터러 초기화 ---
                window.onload = function () {
                    const mapContainer = document.getElementById('mapArea');
                    const mapOptions = { center: centerPos, level: 4 };

                    map = new kakao.maps.Map(mapContainer, mapOptions);

                    // 반경 범위를 나타내는 원 객체
                    circle = new kakao.maps.Circle({
                        center: centerPos,
                        radius: 500,
                        strokeWeight: 2,
                        strokeColor: '#005baa',
                        strokeOpacity: 0.8,
                        fillColor: '#005baa',
                        fillOpacity: 0.1
                    });
                    circle.setMap(map);

                    // 🌟 마커 클러스터러 초기화 🌟
                    clusterer = new kakao.maps.MarkerClusterer({
                        map: map, // 마커들을 클러스터로 관리할 지도 객체
                        averageCenter: true, // 클러스터 마커 위치를 평균 좌표로
                        minLevel: 5, // 클러스터 할 최소 지도 레벨 (5레벨 이상 축소될 때 뭉쳐짐)
                        styles: [{ // 클러스터 마커 커스텀 스타일
                            width: '40px', height: '40px', background: 'rgba(0, 91, 170, 0.8)',
                            borderRadius: '50%', color: '#fff', textAlign: 'center', fontWeight: 'bold', lineHeight: '40px'
                        }]
                    });

                    updateRadius(); // 초기 마커 렌더링
                };

                // --- 4. 슬라이드바 조작 시 반경 텍스트 변경 ---
                function updateRadiusText() {
                    const val = document.getElementById('radiusSlider').value;
                    const text = val >= 1000 ? (val / 1000).toFixed(1) + 'km' : val + 'm';
                    document.getElementById('radiusText').innerText = text;
                }

                // --- 5. 반경에 따른 마커/클러스터러 업데이트 ---
                function updateRadius() {
                    const selectedRadius = parseInt(document.getElementById('radiusSlider').value);

                    circle.setRadius(selectedRadius);

                    // 반경에 따라 지도 줌 레벨 조정
                    if (selectedRadius <= 500) map.setLevel(4);
                    else if (selectedRadius <= 1500) map.setLevel(5);
                    else map.setLevel(6);

                    map.setCenter(centerPos);

                    // 기존 마커 및 클러스터 삭제
                    clusterer.clear();
                    markers = [];
                    closeBottomSheet();

                    // 반경 내 그룹별로 마커 생성
                    for (let key in groupedMeetings) {
                        const group = groupedMeetings[key];
                        const targetLat = group[0].lat;
                        const targetLng = group[0].lng;

                        // 중심점과의 거리 계산
                        const line = new kakao.maps.Polyline({ path: [centerPos, new kakao.maps.LatLng(targetLat, targetLng)] });
                        const distance = line.getLength();

                        if (distance <= selectedRadius) {
                            const markerPos = new kakao.maps.LatLng(targetLat, targetLng);
                            const marker = new kakao.maps.Marker({ position: markerPos, clickable: true });

                            // 마커 클릭 시 해당 위치의 '모임 그룹' 바텀 시트 열기
                            kakao.maps.event.addListener(marker, 'click', function () {
                                openBottomSheet(group);
                            });

                            markers.push(marker);
                        }
                    }

                    // 생성된 마커들을 클러스터러에 추가
                    clusterer.addMarkers(markers);
                }

                // --- 6. 하단 시트 열기/닫기 ---
                function openBottomSheet(meetingsArray) {
                    const sheet = document.getElementById('bottomSheet');
                    const title = document.getElementById('sheetTitle');
                    const slider = document.getElementById('cardSlider');

                    title.innerText = `이 위치의 모임 (\${meetingsArray.length}개)`;
                    slider.innerHTML = '';

                    meetingsArray.forEach(m => {
                        const statusClass = m.status === '마감임박' ? 'active' : '';

                        // 모달 연동을 위해 onclick 이벤트에 모임 고유 ID 전달
                        const cardHTML = `
                    <div class="mini-card">
                        <div class="mini-card-header">
                            <span class="cat-badge">\${m.cat}</span>
                            <span class="status-badge \${statusClass}">\${m.status}</span>
                        </div>
                        <h4>\${m.title}</h4>
                        <div class="mini-card-info">
                            <span><i class="fa-regular fa-clock"></i> \${m.time}</span>
                            <span><i class="fa-solid fa-users"></i> 인원: \${m.curP} / \${m.maxP}명</span>
                        </div>
                        <button class="btn-detail" onclick="openJoinModalFromData(\${m.id})">상세보기 이동</button>
                    </div>
                `;
                        slider.innerHTML += cardHTML;
                    });
                    sheet.classList.add('show');
                }

                function closeBottomSheet() {
                    document.getElementById('bottomSheet').classList.remove('show');
                }

                // --- 7. 모임 참여(상세보기) 모달 제어 ---
                let currentJoinPeople = 0; let maxJoinPeople = 0;

                // ID를 받아와서 모임 데이터를 찾은 뒤 팝업 띄우기
                function openJoinModalFromData(meetingId) {
                    const m = dummyMeetings.find(item => item.id === meetingId);
                    if (m) openJoinModal(m.cat, m.title, m.curP, m.maxP, m.time, m.material, m.loc, m.desc);
                }

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
                    document.getElementById('commentSection').style.display = "none";
                    document.getElementById('joinModal').classList.add('show');
                }

                function closeJoinModal() { document.getElementById('joinModal').classList.remove('show'); }

                function toggleJoin() {
                    const joinBtn = document.getElementById('btnJoinAction');
                    const commentSection = document.getElementById('commentSection');

                    if (joinBtn.innerText === "참여하기") {
                        joinBtn.innerText = "참여 취소하기"; joinBtn.classList.add('cancel');
                        commentSection.style.display = "block"; // 댓글 영역 오픈
                        currentJoinPeople++;
                    } else {
                        if (confirm("참여를 취소하시겠습니까?")) {
                            joinBtn.innerText = "참여하기"; joinBtn.classList.remove('cancel');
                            commentSection.style.display = "none"; // 댓글 영역 숨김
                            currentJoinPeople--;
                        }
                    }
                    document.getElementById('joinPeople').innerText = `${currentJoinPeople}/${maxJoinPeople}`;
                }

                window.onclick = function (e) {
                    if (e.target == document.getElementById('joinModal')) closeJoinModal();
                }
            </script>
    </body>

    </html>