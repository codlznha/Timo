<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- 🔥 sidebar.jsp는 완전한 독립 모듈이므로, 아이콘 폰트도 스스로 불러옵니다. -->
    <!-- (main.jsp 등 이 파일을 include하는 페이지에서 이미 로드했더라도, -->
    <!--  브라우저가 동일 URL 요청을 캐시/중복 제거하므로 성능상 문제 없습니다.) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 사이드바 전용 변수 */
        :root {
            --sidebar-bg: #1a254f;
            --sidebar-hover: #29386f;
            --primary-blue: #005baa;
            --white: #ffffff;
        }

        /* --- 사이드바 본체 CSS --- */
        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            color: var(--white);
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            z-index: 100;
            transition: 0.3s;
        }

        .sidebar.collapsed {
            transform: translateX(-250px);
        }

        .sidebar-logo {
            padding: 25px 20px;
            font-size: 1.4rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-profile {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .profile-img {
            width: 70px;
            height: 70px;
            background-color: var(--white);
            border-radius: 50%;
            margin: 0 auto 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--sidebar-bg);
            font-size: 2rem;
        }

        .profile-name {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .sidebar-menu {
            padding: 20px 0;
            flex-grow: 1;
            overflow-y: auto;
        }

        .menu-title {
            font-size: 0.75rem;
            color: #8a96b8;
            padding: 0 20px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: #d0d7e8;
            text-decoration: none;
            font-size: 0.95rem;
            transition: 0.2s;
        }

        .menu-item:hover,
        .menu-item.active {
            background-color: var(--sidebar-hover);
            color: var(--white);
            border-left: 4px solid var(--primary-blue);
        }

        .menu-item i {
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        /* 🔥 핵심: 사이드바가 불러와졌을 때 메인 영역(main-wrapper)을 자동으로 밀어내는 CSS */
        .main-wrapper {
            margin-left: 250px;
            transition: 0.3s;
        }

        .main-wrapper.expanded {
            margin-left: 0;
        }

        /* 모바일 반응형 처리 */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-250px);
            }

            .sidebar.active-mobile {
                transform: translateX(0);
            }

            .main-wrapper {
                margin-left: 0;
            }

            /* 모바일에서는 여백 제거 */
        }
    </style>

    <!-- --- 사이드바 HTML --- -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-logo"><i class="fa-solid fa-graduation-cap"></i> 티모(Timo)</div>
        <div class="sidebar-profile">
            <div class="profile-img"><i class="fa-solid fa-user"></i></div>
            <div class="profile-name">이한국 님</div>
        </div>
        <nav class="sidebar-menu">
            <div class="menu-title">MAIN MENU</div>
            <a href="main.jsp" class="menu-item active"><i class="fa-solid fa-house"></i> 홈</a>
            <a href="club_main.jsp" class="menu-item"><i class="fa-solid fa-shield-halved"></i> 공식 동아리</a>
            <a href="meeting_list.jsp" class="menu-item"><i class="fa-solid fa-user-group"></i> 자율 소모임</a>
            <a href="map.jsp" class="menu-item"><i class="fa-solid fa-map-location-dot"></i> 지도</a>
            <a href="club_board.jsp" class="menu-item"><i class="fa-solid fa-clipboard-list"></i> 게시판</a>
            <a href="mypage.jsp" class="menu-item"><i class="fa-solid fa-user"></i> MY</a>
        </nav>
    </aside>

    <!-- --- 사이드바 동작 자바스크립트 --- -->
    <script>
        // 이 함수는 메인 페이지의 토글 버튼 클릭 시 정상 작동합니다.
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainWrapper = document.getElementById('mainWrapper');

            if (window.innerWidth <= 768) {
                sidebar.classList.toggle('active-mobile');
            } else {
                sidebar.classList.toggle('collapsed');
                if (mainWrapper) mainWrapper.classList.toggle('expanded');
            }
        }
    </script>