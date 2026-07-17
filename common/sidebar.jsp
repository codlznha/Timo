<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- sidebar.jsp -->
    <aside class="sidebar" id="sidebar">
        <!-- 🌟 헤더: 로고와 햄버거 버튼은 언제나 존재함 -->
        <div class="sidebar-header">
            <span class="logo-text">티모(Timo)</span>
            <button class="btn-toggle" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>

        <!-- 🌟 프로필 영역 -->
        <div class="sidebar-profile">
            <div class="profile-img"><i class="fa-solid fa-user"></i></div>
            <div class="profile-name">이한국 님</div>
        </div>

        <!-- 🌟 메뉴 리스트 -->
        <nav class="sidebar-menu">
            <div class="menu-title">MAIN MENU</div>
            <a href="index.jsp" class="menu-item"><i class="fa-solid fa-house"></i> <span class="menu-text">홈</span></a>
            <a href="club_main.jsp" class="menu-item active"><i class="fa-solid fa-shield-halved"></i> <span
                    class="menu-text">공식 동아리</span></a>
            <a href="meeting_list.jsp" class="menu-item"><i class="fa-solid fa-user-group"></i> <span
                    class="menu-text">자율 소모임</span></a>
            <a href="map.jsp" class="menu-item"><i class="fa-solid fa-map-location-dot"></i> <span
                    class="menu-text">지도</span></a>
            <a href="club_board.jsp" class="menu-item"><i class="fa-solid fa-clipboard-list"></i> <span
                    class="menu-text">게시판</span></a>
            <a href="mypage.jsp" class="menu-item"><i class="fa-solid fa-user"></i> <span
                    class="menu-text">MY</span></a>
        </nav>
    </aside>