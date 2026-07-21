<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 동아리 상세페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
	
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
            background-image: url('/img/tino_bg.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
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

        .header-btn-group {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }

        .btn-write {
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

        .btn-write:hover {
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

        .qna-list li {
            cursor: pointer;
            transition: color 0.2s;
        }

        .qna-list li:hover {
            color: var(--primary-blue);
            font-weight: bold;
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
            /* 학과명 길이가 제각각이라도(데이터사이언스, 인공지능소프트웨어학과 등)
               카드를 세로 flex로 만들고 액션 영역을 margin-top:auto로 항상 하단에 고정 */
            display: flex;
            flex-direction: column;
            height: 100%;
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
            /* 학과명이 길어 줄바꿈되어도 아래 액션 버튼 위치가 카드마다 달라지지 않도록
               남는 세로 공간을 이 영역이 흡수하게 함 */
            flex-grow: 1;
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

        /* --- 회원관리 탭 UI --- */
        .manage-notice {
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: var(--primary-light);
            color: var(--primary-blue);
            font-size: 0.85rem;
            font-weight: bold;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .member-actions {
            /* 학과명 줄바꿈으로 카드 높이가 달라져도, 액션 영역은 항상 카드 맨 아래에 붙도록 고정 */
            margin-top: auto;
            padding-top: 8px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .btn-rank, .btn-kick {
            width: 100%;
            padding: 5px 0;
            font-size: 0.7rem;
            font-weight: bold;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            background-color: var(--white);
            color: var(--text-gray);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            transition: 0.2s;
        }

        .btn-rank.promote:hover {
            border-color: #2e7d32;
            color: #2e7d32;
            background-color: #eaf5ea;
        }

        .btn-rank.demote:hover {
            border-color: #d32f2f;
            color: #d32f2f;
            background-color: #fbeaea;
        }

        /* 강퇴 버튼: 등급 변경(승급/강등)과 명확히 구분되도록 위험 액션 스타일 적용 */
        .btn-kick {
            border-color: #f3c1c1;
            color: #d32f2f;
        }

        .btn-kick:hover {
            border-color: #d32f2f;
            color: #ffffff;
            background-color: #d32f2f;
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

        /* --- 가입 신청 관리 탭 UI --- */
        .applicant-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .applicant-item {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 18px 20px;
            background-color: #fafafa;
            transition: 0.2s;
        }

        .applicant-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            gap: 10px;
        }

        .applicant-name-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .applicant-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background-color: var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ccc;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .applicant-name {
            font-weight: bold;
            font-size: 0.95rem;
            color: var(--text-dark);
        }

        .applicant-meta {
            font-size: 0.8rem;
            color: var(--text-gray);
            margin-top: 2px;
        }

        .applicant-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .applicant-status {
            font-size: 0.75rem;
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 20px;
            white-space: nowrap;
        }

        .status-waiting {
            background-color: #fff4d6;
            color: #b8860b;
        }

        .status-pass {
            background-color: #e3f5e6;
            color: #1e8e4a;
        }

        .status-fail {
            background-color: #fbe1e1;
            color: #c0392b;
        }

        .applicant-toggle-icon {
            color: var(--text-gray);
            transition: 0.2s;
        }

        .applicant-item.open .applicant-toggle-icon {
            transform: rotate(180deg);
        }

        .applicant-detail {
            display: none;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px dashed var(--border-color);
            font-size: 0.9rem;
        }

        .applicant-item.open .applicant-detail {
            display: block;
        }

        .applicant-detail-row {
            margin-bottom: 14px;
        }

        .applicant-detail-label {
            font-weight: bold;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .applicant-detail-value {
            color: var(--text-gray);
            line-height: 1.6;
            white-space: pre-line;
        }

        .applicant-actions {
            display: flex;
            gap: 10px;
            margin-top: 18px;
        }

        .btn-pass,
        .btn-fail {
            flex: 1;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .btn-pass {
            background-color: #1e8e4a;
            color: #fff;
        }

        .btn-pass:hover {
            background-color: #167339;
        }

        .btn-fail {
            background-color: #c0392b;
            color: #fff;
        }

        .btn-fail:hover {
            background-color: #a1301f;
        }

        .btn-pass:disabled,
        .btn-fail:disabled {
            background-color: #e0e0e0;
            color: #a0a0a0;
            cursor: not-allowed;
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
            .header-btn-group {
                width: 100%;
                flex-direction: column;
            }
            .btn-join,
            .btn-write {
                width: 100%;
                justify-content: center;
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
            <div class="header-btn-group">
				<button class="btn-write" onclick="location.href='/club/add_writing?clubId=1&board=notice'">
				글쓰기
				</button>
                <button class="btn-join" onclick="location.href='/club/apply'">가입 신청하기</button>
            </div>
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
                <h3><i class="fa-solid fa-circle-question"></i> Q&amp;A</h3>
                <ul class="poll-list qna-list">
                    <li onclick="location.href='/club/club_QA'">궁금한점 물어보기</li>
                </ul>
            </div>
        </aside>

        <main class="content">
            <div class="tabs">
                <button class="tab-btn active" onclick="openTab(event, 'notice')">공지게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'free')">자유게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'review')">후기게시판</button>
                <button class="tab-btn" onclick="openTab(event, 'members')">동아리원</button>
                <button class="tab-btn" onclick="openTab(event, 'manage')">회원관리</button>
                <button class="tab-btn" onclick="openTab(event, 'apply')">가입 신청<span id="applyPendingBadge"></span></button>
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

            <div id="manage" class="tab-content card">

                <div class="manage-notice">
                    <i class="fa-solid fa-circle-info"></i> 회장만 부원의 등급을 승급·강등하거나 동아리에서 강퇴할 수 있습니다.
                </div>

                <h3 class="member-section-title"><i class="fa-solid fa-crown" style="color: #f1c40f;"></i> 회장</h3>
                <div class="executives-grid" id="presidentGrid">
                    <div class="member-card executive-card" data-name="이호성" data-dept="소프트웨어학과" data-role="회장">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">회장</div>
                        <div class="member-name">이호성</div>
                        <div class="member-dept">소프트웨어학과</div>
                    </div>
                </div>

                <h3 class="member-section-title">
                    <i class="fa-solid fa-star" style="color: var(--primary-blue);"></i> 임원 <span id="officerCount">(2명)</span>
                </h3>
                <div class="executives-grid" id="officerGrid">
                    <div class="member-card executive-card" data-name="임채이" data-dept="소프트웨어학과" data-role="임원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">임원</div>
                        <div class="member-name">임채이</div>
                        <div class="member-dept">소프트웨어학과</div>
                        <div class="member-actions">
                            <button class="btn-rank demote" onclick="demoteMember(this)"><i class="fa-solid fa-arrow-down"></i> 강등</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                    <div class="member-card executive-card" data-name="우동훈" data-dept="소프트웨어학과" data-role="임원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-role">임원</div>
                        <div class="member-name">우동훈</div>
                        <div class="member-dept">소프트웨어학과</div>
                        <div class="member-actions">
                            <button class="btn-rank demote" onclick="demoteMember(this)"><i class="fa-solid fa-arrow-down"></i> 강등</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                </div>

                <h3 class="member-section-title">
                    <i class="fa-solid fa-users" style="color: var(--text-gray);"></i> 회원 <span id="memberCount">(5명)</span>
                </h3>
                <div class="members-grid" id="memberGrid">
                    <div class="member-card" data-name="최프론트" data-dept="컴퓨터공학과" data-role="회원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">최프론트</div>
                        <div class="member-dept">컴퓨터공학과</div>
                        <div class="member-actions">
                            <button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                    <div class="member-card" data-name="정백엔드" data-dept="인공지능소프트웨어학과" data-role="회원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">정백엔드</div>
                        <div class="member-dept">인공지능소프트웨어학과</div>
                        <div class="member-actions">
                            <button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                    <div class="member-card" data-name="강디자인" data-dept="산업디자인공학" data-role="회원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">강디자인</div>
                        <div class="member-dept">산업디자인공학</div>
                        <div class="member-actions">
                            <button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                    <div class="member-card" data-name="유서버" data-dept="인공지능소프트웨어학과" data-role="회원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">유서버</div>
                        <div class="member-dept">인공지능소프트웨어학과</div>
                        <div class="member-actions">
                            <button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                    <div class="member-card" data-name="조데이터" data-dept="데이터사이언스" data-role="회원">
                        <div class="member-avatar"><i class="fa-solid fa-user"></i></div>
                        <div class="member-name">조데이터</div>
                        <div class="member-dept">데이터사이언스</div>
                        <div class="member-actions">
                            <button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>
                            <button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="apply" class="tab-content card">

                <div class="manage-notice">
                    <i class="fa-solid fa-circle-info"></i> 회장만 가입 신청을 합격·불합격 처리할 수 있습니다.
                </div>

                <h3 class="member-section-title"><i class="fa-solid fa-clipboard-list" style="color: var(--primary-blue);"></i>
                    가입 신청자 목록 <span id="applicantCount"></span></h3>

                <div class="applicant-list" id="applicantList"></div>

            </div>
        </main>
    </div>

    <script>
        // 데모용: 실제 서비스에서는 로그인한 사용자의 역할을 서버에서 받아와 판단해야 합니다.
        const isPresident = true;

        // add_writing.jsp에서 글쓰기를 완료하고 돌아왔을 때(club_detail.jsp?tab=notice 등)
        // 해당 게시판 탭이 자동으로 선택되도록 처리
        function openTabByName(tabName) {
            const btn = Array.from(document.getElementsByClassName('tab-btn'))
                .find(b => b.getAttribute('onclick') && b.getAttribute('onclick').includes("'" + tabName + "'"));
            if (btn) {
                openTab({ currentTarget: btn }, tabName);
            }
        }

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

        // --- 회원관리: 승급 / 강등 ---
        function buildMemberCard(name, dept, role) {
            const isExecutive = (role !== '회원');
            const roleHtml = isExecutive ? '<div class="member-role">' + role + '</div>' : '';
            const cardClass = 'member-card' + (isExecutive ? ' executive-card' : '');

            let actionHtml = '';
            if (isPresident) {
                const rankBtnHtml = (role === '회원')
                    ? '<button class="btn-rank promote" onclick="promoteMember(this)"><i class="fa-solid fa-arrow-up"></i> 승급</button>'
                    : '<button class="btn-rank demote" onclick="demoteMember(this)"><i class="fa-solid fa-arrow-down"></i> 강등</button>';
                const kickBtnHtml = '<button class="btn-kick" onclick="kickMember(this)"><i class="fa-solid fa-user-slash"></i> 강퇴</button>';
                actionHtml = '<div class="member-actions">' + rankBtnHtml + kickBtnHtml + '</div>';
            }

            return '<div class="' + cardClass + '" data-name="' + name + '" data-dept="' + dept + '" data-role="' + role + '">' +
                '<div class="member-avatar"><i class="fa-solid fa-user"></i></div>' +
                roleHtml +
                '<div class="member-name">' + name + '</div>' +
                '<div class="member-dept">' + dept + '</div>' +
                actionHtml +
                '</div>';
        }

        function updateRankCounts() {
            document.getElementById('officerCount').textContent = '(' + document.querySelectorAll('#officerGrid .member-card').length + '명)';
            document.getElementById('memberCount').textContent = '(' + document.querySelectorAll('#memberGrid .member-card').length + '명)';
        }

        // 회원 -> 임원 승급 (회장만 가능)
        function promoteMember(button) {
            if (!isPresident) return;
            const card = button.closest('.member-card');
            const name = card.dataset.name, dept = card.dataset.dept;

            if (!confirm("'" + name + "' 님을 임원으로 승급하시겠습니까?")) return;

            card.remove();
            document.getElementById('officerGrid').insertAdjacentHTML('beforeend', buildMemberCard(name, dept, '임원'));
            updateRankCounts();
            alert(name + " 님이 임원으로 승급되었습니다.");
        }

        // 임원 -> 회원 강등 (회장만 가능)
        function demoteMember(button) {
            if (!isPresident) return;
            const card = button.closest('.member-card');
            const name = card.dataset.name, dept = card.dataset.dept;

            if (!confirm("'" + name + "' 님을 회원으로 강등하시겠습니까?")) return;

            card.remove();
            document.getElementById('memberGrid').insertAdjacentHTML('beforeend', buildMemberCard(name, dept, '회원'));
            updateRankCounts();
            alert(name + " 님이 회원으로 강등되었습니다.");
        }

        // 동아리원 강퇴 (회장만 가능, 임원/회원 모두 대상)
        function kickMember(button) {
            if (!isPresident) return;
            const card = button.closest('.member-card');
            const name = card.dataset.name;

            if (!confirm("'" + name + "' 님을 동아리에서 강퇴하시겠습니까?\n이 작업은 되돌릴 수 없습니다.")) return;

            card.remove();
            updateRankCounts();
            alert(name + " 님이 동아리에서 강퇴되었습니다.");
        }

        // --- 가입 신청 관리: 신청자 목록 / 합격 / 불합격 ---
        // 실제 서비스에서는 club_apply.jsp를 통해 제출된 신청서를 서버에서 조회해와야 합니다. (예시 목데이터)
        let applicants = [
            {
                id: 1,
                name: "임채이",
                dept: "AI소프트웨어학과",
                studentId: "20251234",
                motivation: "평소 웹/앱 서비스를 직접 만들어보고 싶었고, 팀 프로젝트 경험을 쌓고 싶어 지원하게 되었습니다.",
                techStack: "HTML/CSS 기초 수강, 자바스크립트 개인 프로젝트 경험",
                interviewDate: "5월 12일 (수) 오후 6시",
                status: "waiting"
            },
            {
                id: 2,
                name: "박서준",
                dept: "컴퓨터공학과",
                studentId: "20241102",
                motivation: "개발 동아리 활동을 통해 실무 감각을 익히고, 선배들과 네트워킹하고 싶어 지원합니다.",
                techStack: "없음",
                interviewDate: "5월 13일 (목) 오후 6시",
                status: "waiting"
            },
            {
                id: 3,
                name: "한소희",
                dept: "산업디자인공학",
                studentId: "20250789",
                motivation: "UI/UX 디자인에 관심이 많아 개발자분들과 함께 서비스를 기획해보고 싶습니다.",
                techStack: "Figma 활용 가능, HTML/CSS 기초",
                interviewDate: "해당 일정 모두 불가능 (별도 연락 요망)",
                status: "pass"
            }
        ];

        const applicantStatusInfo = {
            waiting: { label: "심사중", cls: "status-waiting" },
            pass: { label: "합격", cls: "status-pass" },
            fail: { label: "불합격", cls: "status-fail" }
        };

        function renderApplicants() {
            const listEl = document.getElementById('applicantList');
            const countEl = document.getElementById('applicantCount');
            const badgeEl = document.getElementById('applyPendingBadge');
            listEl.innerHTML = '';

            const waitingCount = applicants.filter(a => a.status === 'waiting').length;
            countEl.textContent = '(' + applicants.length + '명)';
            badgeEl.textContent = waitingCount > 0 ? ' (' + waitingCount + ')' : '';

            applicants.forEach(app => {
                const s = applicantStatusInfo[app.status];
                const isWaiting = app.status === 'waiting';

                const item = document.createElement('div');
                item.className = 'applicant-item';
                item.id = 'applicant-' + app.id;
                item.innerHTML = `
                    <div class="applicant-top" onclick="toggleApplicantDetail(${app.id})">
                        <div class="applicant-name-wrap">
                            <div class="applicant-avatar"><i class="fa-solid fa-user"></i></div>
                            <div>
                                <div class="applicant-name">${app.name}</div>
                                <div class="applicant-meta">${app.dept} · ${app.studentId}</div>
                            </div>
                        </div>
                        <div class="applicant-right">
                            <span class="applicant-status ${s.cls}">${s.label}</span>
                            <i class="fa-solid fa-chevron-down applicant-toggle-icon"></i>
                        </div>
                    </div>
                    <div class="applicant-detail">
                        <div class="applicant-detail-row">
                            <div class="applicant-detail-label">지원 동기</div>
                            <div class="applicant-detail-value">${app.motivation}</div>
                        </div>
                        <div class="applicant-detail-row">
                            <div class="applicant-detail-label">기술 스택 / 경험</div>
                            <div class="applicant-detail-value">${app.techStack}</div>
                        </div>
                        <div class="applicant-detail-row">
                            <div class="applicant-detail-label">면접 희망 일정</div>
                            <div class="applicant-detail-value">${app.interviewDate}</div>
                        </div>
                        ${isPresident ? `
                        <div class="applicant-actions">
                            <button class="btn-fail" ${isWaiting ? '' : 'disabled'} onclick="decideApplicant(event, ${app.id}, 'fail')">
                                <i class="fa-solid fa-xmark"></i> 불합격
                            </button>
                            <button class="btn-pass" ${isWaiting ? '' : 'disabled'} onclick="decideApplicant(event, ${app.id}, 'pass')">
                                <i class="fa-solid fa-check"></i> 합격
                            </button>
                        </div>` : ''}
                    </div>
                `;
                listEl.appendChild(item);
            });
        }

        function toggleApplicantDetail(id) {
            document.getElementById('applicant-' + id).classList.toggle('open');
        }

        function decideApplicant(evt, id, decision) {
            evt.stopPropagation(); // 상세보기 토글과 겹치지 않도록 이벤트 전파 차단

            if (!isPresident) return;
            const app = applicants.find(a => a.id === id);
            if (!app) return;

            const label = decision === 'pass' ? '합격' : '불합격';
            if (!confirm("'" + app.name + "' 님의 가입 신청을 " + label + " 처리하시겠습니까?")) return;

            // 실제 서비스에서는 이 부분에서 서버로 합격/불합격 결과를 전송합니다.
            app.status = decision;
            renderApplicants();

            const item = document.getElementById('applicant-' + id);
            if (item) item.classList.add('open');

            alert(app.name + " 님이 " + label + " 처리되었습니다.");
        }

        renderApplicants();

        // URL에 ?tab=notice / free / review 파라미터가 있으면 해당 게시판 탭을 열어줌
        (function () {
            const params = new URLSearchParams(window.location.search);
            const tab = params.get('tab');
            if (tab === 'notice' || tab === 'free' || tab === 'review') {
                openTabByName(tab);
            }
        })();
    </script>
</body>
</html>