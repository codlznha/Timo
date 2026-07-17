<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 통합 메인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Variables - 원래 티모(학교) 테마 */
        :root {
            --sidebar-bg: #1a254f; 
            --sidebar-hover: #29386f;
            --primary-blue: #005baa; 
            --bg-color: #f4f6f9; 
            --white: #ffffff;
            --text-dark: #333333;
            --text-gray: #666666;
            --border-color: #e5e8eb;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', 'Noto Sans KR', sans-serif; }
        body { background-color: var(--bg-color); display: flex; min-height: 100vh; overflow-x: hidden; }

        /* --- 사이드바 --- */
        .sidebar {
            width: 250px; background-color: var(--sidebar-bg); color: var(--white);
            display: flex; flex-direction: column; position: fixed; height: 100vh; z-index: 100; transition: 0.3s;
        }
        .sidebar.collapsed { transform: translateX(-250px); }
        .sidebar-logo { padding: 25px 20px; font-size: 1.4rem; font-weight: 800; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-profile { padding: 25px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .profile-img { width: 70px; height: 70px; background-color: var(--white); border-radius: 50%; margin: 0 auto 10px; display: flex; align-items: center; justify-content: center; color: var(--sidebar-bg); font-size: 2rem; }
        .profile-name { font-weight: bold; font-size: 1.1rem; margin-bottom: 5px; }

        .sidebar-menu { padding: 20px 0; flex-grow: 1; overflow-y: auto; }
        .menu-title { font-size: 0.75rem; color: #8a96b8; padding: 0 20px; margin-bottom: 10px; font-weight: bold; }
        .menu-item { padding: 12px 20px; display: flex; align-items: center; gap: 15px; color: #d0d7e8; text-decoration: none; font-size: 0.95rem; transition: 0.2s; }
        .menu-item:hover, .menu-item.active { background-color: var(--sidebar-hover); color: var(--white); border-left: 4px solid var(--primary-blue); }
        .menu-item i { width: 20px; text-align: center; font-size: 1.1rem; }

        /* --- 메인 영역 --- */
        .main-wrapper { margin-left: 250px; flex-grow: 1; display: flex; flex-direction: column; transition: 0.3s; min-height: 100vh; }
        .main-wrapper.expanded { margin-left: 0; }

        /* 상단 헤더 */
        .top-header { height: 70px; background-color: var(--white); display: flex; justify-content: space-between; align-items: center; padding: 0 30px; border-bottom: 1px solid var(--border-color); position: sticky; top: 0; z-index: 90; }
        .header-left { display: flex; align-items: center; gap: 20px; }
        .btn-toggle { background: none; border: none; font-size: 1.5rem; color: var(--text-dark); cursor: pointer; }
        
        .header-search { display: flex; align-items: center; background: var(--bg-color); border-radius: 20px; padding: 8px 15px; width: 300px; transition: 0.3s; }
        .header-search input { border: none; background: transparent; outline: none; margin-left: 10px; width: 100%; font-size: 0.9rem; }
        .header-search button { background: none; border: none; cursor: pointer; color: var(--text-gray); }

        .header-icons { display: flex; align-items: center; gap: 20px; color: var(--text-gray); font-size: 1.2rem; cursor: pointer; }

        /* 대시보드 그리드 */
        .dashboard-content { padding: 30px; display: grid; grid-template-columns: 2fr 1fr; gap: 25px; align-items: start; }
        
        /* 공통 카드 & 타이틀 */
        .card { background: var(--white); border-radius: 12px; padding: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.03); margin-bottom: 25px; }
        .card-title { font-size: 1.1rem; font-weight: bold; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid var(--border-color); padding-bottom: 10px; }
        .card-title a, .card-title button { font-size: 0.85rem; color: var(--text-gray); text-decoration: none; font-weight: normal; background: none; border: none; cursor: pointer; }

        /* 공지사항 (전체 너비) */
        .full-width { grid-column: 1 / -1; margin-bottom: 0; }
        .notice-list { list-style: none; display: flex; flex-direction: column; gap: 10px; }
        .notice-list li { display: flex; justify-content: space-between; font-size: 0.95rem; padding: 5px 0; }
        .notice-label { color: #d32f2f; font-weight: bold; margin-right: 10px; }

        /* 내 동아리 (가로 스크롤) */
        .my-clubs-wrap { display: flex; gap: 20px; overflow-x: auto; padding-bottom: 15px; white-space: nowrap; }
        .my-clubs-wrap::-webkit-scrollbar { height: 6px; }
        .my-clubs-wrap::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
        .club-item { text-align: center; cursor: pointer; min-width: 90px; text-decoration: none; color: var(--text-dark); display: inline-block; }
        .club-item img { width: 70px; height: 70px; border-radius: 16px; margin-bottom: 10px; object-fit: cover; box-shadow: 0 2px 5px rgba(0,0,0,0.1); transition: 0.2s; }
        .club-item:hover img { transform: translateY(-5px); }
        .club-item h4 { font-size: 0.9rem; }
        .empty-club { padding: 20px; text-align: center; color: var(--text-gray); font-size: 0.95rem; width: 100%; }

        /* SOS 홍보 게시판 */
        .sos-list { display: flex; flex-direction: column; gap: 15px; }
        .sos-item { border: 1px solid var(--border-color); border-radius: 8px; padding: 15px; }
        .sos-badge { display: inline-block; background: #fff0e6; color: #ff8c00; font-size: 0.75rem; font-weight: bold; padding: 3px 8px; border-radius: 4px; margin-bottom: 8px; }
        .sos-item h4 { font-size: 1rem; margin-bottom: 5px; }
        .sos-item p { font-size: 0.85rem; color: var(--text-gray); }

        /* 캘린더 */
        .cal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; font-weight: bold; }
        .cal-header button { background: none; border: none; cursor: pointer; color: var(--text-gray); }
        .cal-grid { display: grid; grid-template-columns: repeat(7, 1fr); gap: 5px; text-align: center; font-size: 0.85rem; }
        .cal-day-name { color: var(--text-gray); font-size: 0.75rem; font-weight: bold; margin-bottom: 5px; }
        .cal-date { padding: 6px 0; border-radius: 50%; cursor: pointer; color: var(--text-dark); }
        .cal-date:hover { background-color: var(--bg-color); }
        .cal-date.today { background-color: var(--primary-blue); color: var(--white); font-weight: bold; }
        .cal-date.has-event { border-bottom: 2px solid #ff8c00; border-radius: 0; font-weight: bold; }

        /* 투두 리스트 (세로 크기 고정 및 스크롤) */
        .todo-container { height: 260px; overflow-y: auto; padding-right: 5px; }
        .todo-container::-webkit-scrollbar { width: 5px; }
        .todo-container::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
        .todo-item { display: flex; align-items: center; gap: 10px; padding: 12px 0; border-bottom: 1px solid var(--border-color); }
        .todo-item input[type="checkbox"] { accent-color: var(--primary-blue); width: 16px; height: 16px; cursor: pointer; }
        .todo-text { font-size: 0.9rem; }
        .todo-item input[type="checkbox"]:checked + .todo-text { text-decoration: line-through; color: var(--text-gray); }
        .add-todo { display: flex; gap: 10px; margin-top: 15px; }
        .add-todo input { flex: 1; padding: 8px 12px; border: 1px solid var(--border-color); border-radius: 6px; outline: none; }
        .add-todo button { padding: 8px 15px; background: var(--primary-blue); color: white; border: none; border-radius: 6px; cursor: pointer; }

        /* 팝업 모달 공통 */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); display: none; justify-content: center; align-items: center; z-index: 1000; }
        .modal-overlay.show { display: flex; }
        .modal-content { background: var(--white); padding: 30px; border-radius: 12px; width: 400px; box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .modal-header { display: flex; justify-content: space-between; align-items: center; font-size: 1.2rem; font-weight: bold; margin-bottom: 20px; }
        .btn-close { background: none; border: none; font-size: 1.2rem; cursor: pointer; color: var(--text-gray); }

        /* 하단 네비게이션 바 (모바일) */
        .bottom-nav { display: none; position: fixed; bottom: 0; left: 0; right: 0; height: 65px; background: var(--white); justify-content: space-around; align-items: center; border-top: 1px solid var(--border-color); z-index: 100; }
        .bottom-nav .nav-item { display: flex; flex-direction: column; align-items: center; justify-content: center; font-size: 0.75rem; color: var(--text-gray); text-decoration: none; width: 20%; gap: 4px; }
        .bottom-nav .nav-item i { font-size: 1.4rem; }
        .bottom-nav .nav-item.active { color: var(--primary-blue); }

        @media (max-width: 1024px) {
            .dashboard-content { grid-template-columns: 1fr; }
        }
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-250px); }
            .sidebar.active-mobile { transform: translateX(0); }
            .main-wrapper { margin-left: 0; padding-bottom: 70px; }
            .bottom-nav { display: flex; }
            .dashboard-content { padding: 15px; gap: 15px; }
            .header-search { width: 180px; }
        }
    </style>
</head>
<body>

    <aside class="sidebar" id="sidebar">
        <div class="sidebar-logo"><i class="fa-solid fa-graduation-cap"></i> 티모(Timo)</div>
        <div class="sidebar-profile">
            <div class="profile-img"><i class="fa-solid fa-user"></i></div>
            <div class="profile-name">이한국 님</div>
        </div>
        <nav class="sidebar-menu">
            <div class="menu-title">MAIN MENU</div>
            <a href="index.jsp" class="menu-item active"><i class="fa-solid fa-house"></i> 홈</a>
            <a href="club_main.jsp" class="menu-item"><i class="fa-solid fa-shield-halved"></i> 공식 동아리</a>
            <a href="meeting_list.jsp" class="menu-item"><i class="fa-solid fa-user-group"></i> 자율 소모임</a>
            <a href="map.jsp" class="menu-item"><i class="fa-solid fa-map-location-dot"></i> 지도</a>
            <a href="club_board.jsp" class="menu-item"><i class="fa-solid fa-clipboard-list"></i> 게시판</a>
            <a href="mypage.jsp" class="menu-item"><i class="fa-solid fa-user"></i> MY</a>
        </nav>
    </aside>

    <div class="main-wrapper" id="mainWrapper">
        
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

        <div class="dashboard-content">
            
            <div class="card full-width">
                <div class="card-title">
                    <span style="color: #d32f2f;"><i class="fa-solid fa-bullhorn"></i> 공지사항</span> 
                    <button onclick="openNoticeModal()">더보기 ></button>
                </div>
                <ul class="notice-list">
                    <li>
                        <span><span class="notice-label">[필독]</span>2026학년도 2학기 동아리 등록 기간 안내</span>
                        <span style="color: var(--text-gray); font-size: 0.8rem;">07.16</span>
                    </li>
                    <li>
                        <span><span class="notice-label">[점검]</span>서버 안정화 작업 공지 (이번주 일요일 02:00)</span>
                        <span style="color: var(--text-gray); font-size: 0.8rem;">07.15</span>
                    </li>
                </ul>
            </div>

            <div class="left-col">
                <div class="card">
                    <div class="card-title">내 동아리</div>
                    <div class="my-clubs-wrap" id="myClubsList">
                        <a href="club_main.jsp" class="club-item">
                            <img src="https://via.placeholder.com/70/005baa/ffffff?text=Timo" alt="Timo">
                            <h4>웹개발 Timo</h4>
                        </a>
                        <a href="club_main.jsp" class="club-item">
                            <img src="https://via.placeholder.com/70/ff8c00/ffffff?text=Robo" alt="ROBOTIS">
                            <h4>ROBOTIS</h4>
                        </a>
                        <a href="club_main.jsp" class="club-item">
                            <img src="https://via.placeholder.com/70/4CAF50/ffffff?text=Bad" alt="Smash">
                            <h4>스매싱</h4>
                        </a>
                        <a href="club_main.jsp" class="club-item">
                            <img src="https://via.placeholder.com/70/9C27B0/ffffff?text=Band" alt="Band">
                            <h4>음표</h4>
                        </a>
                        </div>
                    </div>

                <div class="card">
                    <div class="card-title">
                        SOS 홍보 게시판
                        <a href="club_board.jsp">더보기 ></a>
                    </div>
                    <div class="sos-list">
                        <div class="sos-item">
                            <span class="sos-badge">인원급구</span>
                            <h4>[음표] 여름 정기공연 베이스 대타 구해요!</h4>
                            <p>공연이 2주 남았는데 베이스가 다쳤어요ㅠㅠ 악보 다 드릴테니 연락주세요!</p>
                        </div>
                        <div class="sos-item">
                            <span class="sos-badge">모집중</span>
                            <h4>[Timo] 2학기 프론트엔드 파트원 모집</h4>
                            <p>실력 무관! 열정만 있으면 선배들이 다 알려드립니다. 신청 고고!</p>
                        </div>
                        <div class="sos-item">
                            <span class="sos-badge">홍보</span>
                            <h4>[스매싱] 정기 교류전 구경오세요 🏸</h4>
                            <p>이번주 금요일 체육관에서 교류전 합니다. 구경 자유!</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="right-col">
                <div class="card">
                    <div class="cal-header">
                        <button><i class="fa-solid fa-chevron-left"></i></button>
                        <span>2026. 07</span>
                        <button><i class="fa-solid fa-chevron-right"></i></button>
                    </div>
                    <div class="cal-grid">
                        <div class="cal-day-name" style="color: #ff5252;">일</div><div class="cal-day-name">월</div><div class="cal-day-name">화</div><div class="cal-day-name">수</div><div class="cal-day-name">목</div><div class="cal-day-name">금</div><div class="cal-day-name" style="color: var(--primary-blue);">토</div>
                        <div></div><div></div><div></div><div class="cal-date" onclick="openCalModal('1일')">1</div><div class="cal-date" onclick="openCalModal('2일')">2</div><div class="cal-date" onclick="openCalModal('3일')">3</div><div class="cal-date" onclick="openCalModal('4일')">4</div>
                        <div class="cal-date" onclick="openCalModal('5일')">5</div><div class="cal-date" onclick="openCalModal('6일')">6</div><div class="cal-date" onclick="openCalModal('7일')">7</div><div class="cal-date" onclick="openCalModal('8일')">8</div><div class="cal-date" onclick="openCalModal('9일')">9</div><div class="cal-date has-event" onclick="openCalModal('10일')">10</div><div class="cal-date" onclick="openCalModal('11일')">11</div>
                        <div class="cal-date" onclick="openCalModal('12일')">12</div><div class="cal-date" onclick="openCalModal('13일')">13</div><div class="cal-date" onclick="openCalModal('14일')">14</div><div class="cal-date" onclick="openCalModal('15일')">15</div><div class="cal-date today" onclick="openCalModal('16일')">16</div><div class="cal-date" onclick="openCalModal('17일')">17</div><div class="cal-date" onclick="openCalModal('18일')">18</div>
                        <div class="cal-date" onclick="openCalModal('19일')">19</div><div class="cal-date" onclick="openCalModal('20일')">20</div><div class="cal-date" onclick="openCalModal('21일')">21</div><div class="cal-date" onclick="openCalModal('22일')">22</div><div class="cal-date has-event" onclick="openCalModal('23일')">23</div><div class="cal-date" onclick="openCalModal('24일')">24</div><div class="cal-date" onclick="openCalModal('25일')">25</div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-title">투두리스트</div>
                    <div class="todo-container">
                        <label class="todo-item">
                            <input type="checkbox"> <span class="todo-text">데이터베이스 모델링 과제</span>
                        </label>
                        <label class="todo-item">
                            <input type="checkbox" checked> <span class="todo-text">UI 디자인 수정하기</span>
                        </label>
                        <label class="todo-item">
                            <input type="checkbox"> <span class="todo-text">동아리 회비 입금 (23일)</span>
                        </label>
                        <label class="todo-item">
                            <input type="checkbox"> <span class="todo-text">자바 프로그래밍 복습</span>
                        </label>
                        <label class="todo-item">
                            <input type="checkbox"> <span class="todo-text">Timo 프로젝트 회의 준비</span>
                        </label>
                    </div>
                    <div class="add-todo">
                        <input type="text" placeholder="할 일 입력...">
                        <button><i class="fa-solid fa-plus"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <nav class="bottom-nav">
        <a href="index.jsp" class="nav-item active"><i class="fa-solid fa-house"></i><span>홈</span></a>
        <a href="club_main.jsp" class="nav-item"><i class="fa-solid fa-shield-halved"></i><span>동아리</span></a>
        <a href="map.jsp" class="nav-item"><i class="fa-solid fa-map-location-dot"></i><span>지도</span></a>
        <a href="club_board.jsp" class="nav-item"><i class="fa-solid fa-clipboard-list"></i><span>게시판</span></a>
        <a href="mypage.jsp" class="nav-item"><i class="fa-solid fa-user"></i><span>MY</span></a>
    </nav>

    <div class="modal-overlay" id="noticeModal">
        <div class="modal-content" style="width: 500px;">
            <div class="modal-header">
                전체 공지사항
                <button class="btn-close" onclick="closeNoticeModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <ul class="notice-list" style="margin-bottom: 20px;">
                <li style="border-bottom: 1px solid var(--border-color); padding: 10px 0;"><span><span class="notice-label">[필독]</span>2학기 동아리 등록 안내</span></li>
                <li style="border-bottom: 1px solid var(--border-color); padding: 10px 0;"><span><span class="notice-label">[점검]</span>서버 안정화 작업 공지</span></li>
                <li style="border-bottom: 1px solid var(--border-color); padding: 10px 0;"><span><span class="notice-label">[행사]</span>교내 해커톤 대회 개최</span></li>
                <li style="border-bottom: 1px solid var(--border-color); padding: 10px 0;"><span><span class="notice-label">[일반]</span>여름방학 에어컨 가동 시간 안내</span></li>
            </ul>
        </div>
    </div>

    <div class="modal-overlay" id="calModal">
        <div class="modal-content">
            <div class="modal-header">
                <span id="calModalTitle">2026. 07. 16 일정</span>
                <button class="btn-close" onclick="closeCalModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div style="margin-bottom: 20px;">
                <p style="font-size: 0.9rem; color: var(--text-gray); margin-bottom: 10px;">등록된 일정이 없습니다.</p>
                <input type="text" placeholder="새로운 일정 추가..." style="width: 100%; padding: 10px; border: 1px solid var(--border-color); border-radius: 6px; outline: none;">
            </div>
            <button style="width: 100%; padding: 12px; background: var(--primary-blue); color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold;" onclick="closeCalModal()">저장하기</button>
        </div>
    </div>

    <script>
        // 사이드바 토글 (PC/모바일 대응)
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainWrapper = document.getElementById('mainWrapper');
            if (window.innerWidth <= 768) {
                sidebar.classList.toggle('active-mobile');
            } else {
                sidebar.classList.toggle('collapsed');
                mainWrapper.classList.toggle('expanded');
            }
        }

        // 검색창 엔터 이벤트
        function searchClub(event) {
            event.preventDefault(); // 폼 새로고침 방지
            const keyword = document.getElementById('searchInput').value;
            if(keyword.trim() === '') {
                alert('검색어를 입력해주세요.');
            } else {
                alert("'" + keyword + "' 동아리를 검색합니다. (검색결과 페이지로 이동)");
                // location.href = "search_result.jsp?keyword=" + keyword;
            }
        }

        // 공지사항 모달
        function openNoticeModal() { document.getElementById('noticeModal').classList.add('show'); }
        function closeNoticeModal() { document.getElementById('noticeModal').classList.remove('show'); }

        // 캘린더 모달
        function openCalModal(dateStr) { 
            document.getElementById('calModalTitle').innerText = '2026. 07. ' + dateStr + ' 일정';
            document.getElementById('calModal').classList.add('show'); 
        }
        function closeCalModal() { document.getElementById('calModal').classList.remove('show'); }

        // 모달 바깥 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target == document.getElementById('noticeModal')) closeNoticeModal();
            if (event.target == document.getElementById('calModal')) closeCalModal();
        }
    </script>
</body>
</html>