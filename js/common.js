function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');

    if (window.innerWidth <= 768) {
        // 모바일일 때 active-mobile 클래스를 토글
        sidebar.classList.toggle('active-mobile');
    } else {
        // PC일 때 mini 클래스 토글
        sidebar.classList.toggle('mini');
    }
}

// js/common.js 파일에 추가
document.addEventListener('DOMContentLoaded', () => {
    // 현재 접속한 페이지의 파일명 가져오기 (예: board.jsp)
    const path = window.location.pathname;
    const pageName = path.split('/').pop();

    const menuItems = document.querySelectorAll('.sidebar-menu .menu-item');

    menuItems.forEach(item => {
        // 링크의 href 속성과 현재 페이지 주소가 같으면 active 추가
        if (item.getAttribute('href') === pageName) {
            item.classList.add('active');
        } else {
            item.classList.remove('active');
        }
    });
});