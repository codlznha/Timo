<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 현재 요청된 페이지의 파일명 추출 (예: /club_main.jsp -> club_main.jsp)
    String uri = request.getRequestURI();
    String currentPage = uri.substring(uri.lastIndexOf("/") + 1);
%>
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

    .main-wrapper {
        margin-left: 250px;
        transition: 0.3s;
    }

    .main-wrapper.expanded {
        margin-left: 0;
    }

    @media (max-width: 768px) {
        .sidebar { transform: translateX(-250px); }
        .sidebar.active-mobile { transform: translateX(0); }
        .main-wrapper { margin-left: 0; }
    }
</style>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-logo"><i class="fa-solid fa-graduation-cap"></i> 티모(Timo)</div>
    <div class="sidebar-profile">
        <div class="profile-img"><i class="fa-solid fa-user"></i></div>
        <div class="profile-name">관리자 님</div>
    </div>
    <nav class="sidebar-menu">
        <div class="menu-title">MAIN MENU</div>
		<a href="${pageContext.request.contextPath}/club/addClubCheck"
		   class="menu-item <%= currentPage.equals("add_club_check.jsp") ? "active" : "" %>"><i class="fa-solid fa-shield-halved"></i> 동아리 승인</a>
		   <a href="${pageContext.request.contextPath}/club/noticeWrite"
		      class="menu-item <%= currentPage.equals("notice_write.jsp") ? "active" : "" %>"><i class="fa-solid fa-pen-to-square"></i> 공지 작성</a>
    </nav>
</aside>

<script>
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
