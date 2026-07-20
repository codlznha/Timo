<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String uri = request.getRequestURI();
%>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
    --sidebar-bg: #1a254f;
    --sidebar-hover: #29386f;
    --primary-blue: #005baa;
    --white: #ffffff;
}

.sidebar{
    width:250px;
    background:var(--sidebar-bg);
    color:#fff;
    position:fixed;
    top:0;
    left:0;
    height:100vh;
    display:flex;
    flex-direction:column;
    transition:.3s;
    z-index:100;
}

.sidebar.collapsed{
    transform:translateX(-250px);
}

.sidebar-logo{
    padding:25px 20px;
    font-size:1.4rem;
    font-weight:bold;
    border-bottom:1px solid rgba(255,255,255,.1);
}

.sidebar-profile{
    padding:25px 20px;
    text-align:center;
    border-bottom:1px solid rgba(255,255,255,.1);
}

.profile-img{
    width:70px;
    height:70px;
    margin:auto;
    border-radius:50%;
    background:#fff;
    display:flex;
    justify-content:center;
    align-items:center;
    color:var(--sidebar-bg);
    font-size:2rem;
}

.profile-name{
    margin-top:10px;
    font-weight:bold;
}

.sidebar-menu{
    flex:1;
    padding:20px 0;
}

.menu-title{
    color:#8a96b8;
    padding:0 20px;
    margin-bottom:10px;
    font-size:.75rem;
    font-weight:bold;
}

.menu-item{
    display:flex;
    align-items:center;
    gap:15px;
    padding:12px 20px;
    color:#d0d7e8;
    text-decoration:none;
    transition:.2s;
}

.menu-item:hover,
.menu-item.active{
    background:var(--sidebar-hover);
    border-left:4px solid var(--primary-blue);
    color:#fff;
}

.menu-item i{
    width:20px;
}

.main-wrapper{
    margin-left:250px;
    transition:.3s;
}

.main-wrapper.expanded{
    margin-left:0;
}

@media(max-width:768px){

    .sidebar{
        transform:translateX(-250px);
    }

    .sidebar.active-mobile{
        transform:translateX(0);
    }

    .main-wrapper{
        margin-left:0;
    }

}
</style>

<aside class="sidebar" id="sidebar">

    <div class="sidebar-logo">
        <i class="fa-solid fa-graduation-cap"></i>
        티모(Timo)
    </div>

    <div class="sidebar-profile">
        <div class="profile-img">
            <i class="fa-solid fa-user"></i>
        </div>
        <div class="profile-name">
            이한국 님
        </div>
    </div>

    <nav class="sidebar-menu">

        <div class="menu-title">
            MAIN MENU
        </div>

		<!-- 홈 -->
		<a href="${pageContext.request.contextPath}/main"
		   class="menu-item <%= uri.equals(request.getContextPath()+"/main") ? "active" : "" %>">
		    <i class="fa-solid fa-house"></i>
		    홈
		</a>

		<!-- 공식 동아리 -->
		<a href="${pageContext.request.contextPath}/club/main"
		   class="menu-item <%= uri.contains("/club") ? "active" : "" %>">
		    <i class="fa-solid fa-shield-halved"></i>
		    공식 동아리
		</a>

		<!-- 자율 소모임 -->
		<a href="${pageContext.request.contextPath}/meet/list"
		   class="menu-item <%= uri.contains("/meet") && !uri.contains("/meet/map") ? "active" : "" %>">
		    <i class="fa-solid fa-user-group"></i>
		    자율 소모임
		</a>

		<!-- 지도 -->
		<a href="${pageContext.request.contextPath}/meet/map"
		   class="menu-item <%= uri.contains("/meet/map") ? "active" : "" %>">
		    <i class="fa-solid fa-map-location-dot"></i>
		    지도
		</a>

		<!-- 게시판 -->
		<a href="${pageContext.request.contextPath}/main/board"
		   class="menu-item <%= uri.contains("/main/board") ? "active" : "" %>">
		    <i class="fa-solid fa-clipboard-list"></i>
		    게시판
		</a>

		<!-- 마이페이지 -->
		<a href="${pageContext.request.contextPath}/my/mypage"
		   class="menu-item <%= uri.contains("/my") ? "active" : "" %>">
		    <i class="fa-solid fa-user"></i>
		    MY
		</a>

    </nav>

</aside>

<script>

function toggleSidebar(){

    const sidebar=document.getElementById("sidebar");
    const main=document.getElementById("mainWrapper");

    if(window.innerWidth<=768){

        sidebar.classList.toggle("active-mobile");

    }else{

        sidebar.classList.toggle("collapsed");

        if(main){
            main.classList.toggle("expanded");
        }

    }

}

</script>