<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 동아리 상세페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Variables - 학교 메인 컬러 및 테마 */
        :root {
            --primary-blue: #005baa; /* 파랑 */
            --primary-light: #e6f0fa;
            --bg-color: #f5f6f8;
            --white: #ffffff;
            --text-dark: #333333;
            --text-gray: #777777;
            --border-color: #eaeaea;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-dark);
            padding-bottom: 20px;
        }

        /* --- 상단 영역 (커버 및 정보) --- */
        .club-header {
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 20px;
        }

        .cover-image {
            width: 100%;
            height: 250px;
            background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://via.placeholder.com/1200x300/005baa/ffffff?text=Club+Cover+Image') center/cover;
            position: relative;
        }

        .club-info-wrap {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: flex-end;
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }

        .club-logo {
            width: 120px;
            height: 120px;
            background-color: var(--white);
            border-radius: 12px;
            border: 3px solid var(--white);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-blue);
        }

        .club-title-area {
            margin-left: 20px;
            margin-bottom: 10px;
            flex-grow: 1;
        }

        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .badge.official {
            background-color: var(--primary-light);
            color: var(--primary-blue);
        }

        .club-title-area h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .club-desc {
            color: var(--text-gray);
            font-size: 0.95rem;
        }

        .btn-join {
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-bottom: 10px;
        }

        .btn-join:hover {
            background-color: #004588;
        }

        /* --- 레이아웃 (사이드바 + 메인) --- */
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 25px;
        }

        .card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }

        .card h3 {
            font-size: 1.1rem;
            margin-bottom: 15px;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* --- 사이드바 --- */
        .sidebar .sns-links {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .sidebar .sns-links a {
            color: var(--text-gray);
            font-size: 1.2rem;
        }

        .schedule-list, .poll-list {
            list-style: none;
        }

        .schedule-list li, .poll-list li {
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.9rem;
        }


        .tab-btn {
            background: none;
            border: none;
            padding: 10px 15px;
            font-size: 1.05rem;
            font-weight: bold;
            color: var(--text-gray);
            cursor: pointer;
            position: relative;
        }

        .tab-btn.active {
            color: var(--primary-blue);
        }

        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--primary-blue);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 게시글 리스트 UI */
        .post-item {
            padding: 15px 0;
            border-bottom: 1px solid var(--border-color);
        }
        
        .post-item:last-child {
            border-bottom: none;
        }

        .post-title {
            font-weight: bold;
            margin-bottom: 8px;
            cursor: pointer;
        }

        .post-meta {
            font-size: 0.8rem;
            color: var(--text-gray);
            display: flex;
            gap: 15px;
        }

        /* --- 동아리원(멤버) 탭 UI --- */
        .member-section-title {
            font-size: 1.1rem;
            margin-bottom: 15px;
            padding-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* 임원진 그리드 */
        .executives-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
            border-bottom: 1px dashed var(--border-color);
            padding-bottom: 20px;
        }

        /* 일반 멤버 그리드 */
        .members-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 10px;
        }

        .member-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 15px 10px;
            text-align: center;
            background-color: #fafafa;
            transition: transform 0.2s;
        }

        .member-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .member-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: var(--border-color);
            margin: 0 auto 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
            font-size: 1.5rem;
            overflow: hidden;
        }
        
        .member-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .member-role {
            font-size: 0.75rem;
            color: var(--primary-blue);
            font-weight: bold;
            margin-bottom: 3px;
        }

        .member-name {
            font-size: 0.9rem;
            font-weight: bold;
            color: var(--text-dark);
            margin-bottom: 3px;
        }

        .member-dept {
            font-size: 0.75rem;
            color: var(--text-gray);
        }

        /* 임원진 강조 스타일 */
        .executive-card {
            border-color: var(--primary-light);
            background-color: var(--white);
            box-shadow: 0 2px 5px rgba(0,91,170,0.08);
        }
        .executive-card .member-avatar {
            width: 60px;
            height: 60px;
        }

        /* --- 상단 네비게이션 바 --- */
        .top-nav {
            display: flex;
            align-items: center;
            justify-content: space-around;
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .top-nav .nav-item {
            flex: 1;
            text-align: center;
            padding: 12px 6px;
            color: var(--text-gray);
            text-decoration: none;
            font-size: 0.92rem;
            font-weight: 600;
        }

        .top-nav .nav-item.active {
            color: var(--primary-blue);
            background-color: var(--primary-light);
        }

        /* 반응형 모바일 처리 */
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
            .club-info-wrap {
                flex-direction: column;
                align-items: center;
                text-align: center;
                margin-top: -60px;
            }
            .club-title-area {
                margin-left: 0;
                margin-top: 10px;
            }
            .btn-join {
                width: 100%;
            }
            .tabs::-webkit-scrollbar {
                display: none; /* 모바일에서 탭 스크롤바 숨김 */
            }
        }
    </style>
</head>
<body>

    <header class="club-header">
        <div class="cover-image"></div>
        <div class="club-info-wrap">
            <div class="club-logo">
                <i class="fa-solid fa-code"></i>
            </div>
            <div class="club-title-area">
                <span class="badge official">공식 동아리</span>
                <h1>웹 개발 연합회 (Timo)</h1>
                <p class="club-desc">한국공학대학교 공식 웹/앱 서비스 개발 동아리입니다. 함께 성장할 학우들을 모집합니다!</p>
            </div>
            <button class="btn-join" onclick="location.href='club_apply.jsp'">가입 신청하기</button>
        </div>
    </header>

    <div class="container">
        
        <aside class="sidebar">
            <div class="card">
                <h3><i class="fa-solid fa-circle-info"></i> 동아리 정보</h3>
                <p style="font-size: 0.9rem; margin-bottom:10px;">카테고리: 학술 / 개발</p>
                <div class="sns-links">
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-solid fa-globe"></i></a>
                </div>
            </div>

            <div class="card">
                <h3><i class="fa-solid fa-calendar-check"></i> 다가오는 일정</h3>
                <ul class="schedule-list">
                    <li>5월 10일 - 정기 총회 및 프로젝트 발표</li>
                    <li>5월 15일 - 신입 기수 환영회</li>
                </ul>
            </div>

            <div class="card">
                <h3><i class="fa-solid fa-check-to-slot"></i> 진행 중인 투표</h3>
                <ul class="poll-list">
                    <li>1학기 종강 파티 장소 선정 (진행중)</li>
                </ul>
            </div>
        </aside>

        <main class="content">
            <div class="tabs">
                <button class="tab-btn active" onclick="openTab(event, 'notice')">공지게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'free')">자유게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'review')">후기게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'members')">동아리원</button>
            </div>

            <div id="notice" class="tab-content active card">
                <div class="post-item">
                    <div class="post-title">[필독] 2026학년도 1학기 신입 부원 모집 안내</div>
                    <div class="post-meta">
                        <span><i class="fa-solid fa-user"></i> 회장</span>
                        <span><i class="fa-regular fa-clock"></i> 2시간 전</span>
                        <span><i class="fa-regular fa-heart"></i> 12</span>
                    </div>
                </div>
            </div>

            <div id="free" class="tab-content card">
                <div class="post-item">
                    <div class="post-title">오늘 학식 메뉴 뭐였나요?</div>
                    <div class="post-meta">
                        <span>익명</span>
                        <span>10분 전</span>
                        <span>댓글 3</span>
                    </div>
                </div>
            </div>

            <div id="review" class="tab-content card">
                <div class="post-item">
                    <div class="post-title">MT 다녀와서 남기는 후기</div>
                    <div class="post-meta">
                        <span>개발부원</span>
                        <span>3일 전</span>
                        <span>좋아요 25</span>
                    </div>
                </div>
            </div>

            <div id="members" class="tab-content card">
                
                <h3 class="member-section-title"><i class="fa-solid fa-crown" style="color: #f1c40f;"></i> 임원진</h3>
                <div class="executives-grid">
                    <div class="member-card executive-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">회장</div>
                        <div class="member-name">이호성</div>
                        <div class="member-dept">소프트웨어학과</div>
                    </div>
                    <div class="member-card executive-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">부회장</div>
                        <div class="member-name">임채이</div>
                        <div class="member-dept">소프트웨어학과</div>
                    </div>
                    <div class="member-card executive-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">기획부장</div>
                        <div class="member-name">우동훈</div>
                        <div class="member-dept">소프트웨어학과</div>
                    </div>
                </div>

                <h3 class="member-section-title"><i class="fa-solid fa-users" style="color: var(--primary-blue);"></i> 일반 동아리원 (32명)</h3>
                <div class="members-grid">
                    <div class="member-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">최프론트</div>
                        <div class="member-dept">컴퓨터공학과</div>
                    </div>
                    <div class="member-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">정백엔드</div>
                        <div class="member-dept">인공지능소프트웨어학과</div>
                    </div>
                    <div class="member-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">강디자인</div>
                        <div class="member-dept">산업디자인공학</div>
                    </div>
                    <div class="member-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">유서버</div>
                        <div class="member-dept">인공지능소프트웨어학과</div>
                    </div>
                     <div class="member-card">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">조데이터</div>
                        <div class="member-dept">데이터사이언스</div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        function openTab(evt, tabName) {
            // 모든 탭 콘텐츠 숨기기
            var tabContents = document.getElementsByClassName("tab-content");
            for (var i = 0; i < tabContents.length; i++) {
                tabContents[i].classList.remove("active");
            }
            
            // 모든 탭 버튼 비활성화
            var tabBtns = document.getElementsByClassName("tab-btn");
            for (var i = 0; i < tabBtns.length; i++) {
                tabBtns[i].classList.remove("active");
            }
            
            // 선택된 탭 활성화
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");
        }
    </script>
</body>
</html>