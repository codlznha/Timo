<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 동아리 가입 신청</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Variables - 기존 테마 유지 */
        :root {
            --primary-blue: #005baa;
            --primary-light: #e6f0fa;
            --bg-color: #f5f6f8;
            --white: #ffffff;
            --text-dark: #333333;
            --text-gray: #777777;
            --border-color: #eaeaea;
            --input-bg: #f9f9fb;
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
            /* 하단바가 없는 집중형 페이지이므로 padding-bottom을 줄임 */
            padding-bottom: 40px; 
        }

        /* --- 상단 앱바 (App Bar) --- */
        .app-bar {
            background-color: var(--white);
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: sticky;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid var(--border-color);
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        }

        .btn-back {
            position: absolute;
            left: 20px;
            background: none;
            border: none;
            font-size: 1.2rem;
            color: var(--text-dark);
            cursor: pointer;
        }

        .app-bar h1 {
            font-size: 1.1rem;
            font-weight: bold;
        }

        .top-nav {
            display: flex;
            align-items: center;
            justify-content: space-around;
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 60px;
            z-index: 90;
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

        /* --- 폼 컨테이너 --- */
        .form-container {
            max-width: 600px; /* 신청 폼은 넓이를 제한하는 것이 가독성에 좋음 */
            margin: 30px auto;
            padding: 0 20px;
        }

        /* 동아리 요약 카드 */
        .club-summary {
            background-color: var(--primary-light);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .club-summary-icon {
            width: 50px;
            height: 50px;
            background-color: var(--white);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-blue);
            font-size: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .club-summary-text p {
            font-size: 0.85rem;
            color: var(--primary-blue);
            font-weight: bold;
            margin-bottom: 3px;
        }

        .club-summary-text h2 {
            font-size: 1.2rem;
            color: var(--text-dark);
        }

        /* 폼 카드 영역 */
        .apply-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 25px 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.1rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: bold;
            font-size: 0.95rem;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .form-label .required {
            color: #d32f2f;
            margin-left: 3px;
        }

        .form-desc {
            font-size: 0.8rem;
            color: var(--text-gray);
            margin-bottom: 8px;
            display: block;
        }

        /* 입력 폼 공통 스타일 */
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--input-bg);
            font-size: 0.95rem;
            color: var(--text-dark);
            transition: 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-blue);
            background-color: var(--white);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        /* 읽기 전용 입력창 (자동 입력 데이터) */
        .form-control[readonly] {
            background-color: #f0f0f0;
            color: var(--text-gray);
            cursor: not-allowed;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        /* 라디오/체크박스 옵션 스타일 */
        .option-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .option-label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
            cursor: pointer;
        }

        .option-label input[type="radio"] {
            accent-color: var(--primary-blue);
            width: 16px;
            height: 16px;
        }

        /* 제출 버튼 */
        .submit-btn {
            width: 100%;
            padding: 16px;
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background-color: #004588;
        }

    </style>
</head>
<body>

    <header class="app-bar">
        <button class="btn-back" onclick="history.back()"><i class="fa-solid fa-arrow-left"></i></button>
        <h1>동아리 가입 신청</h1>
    </header>

    <nav class="top-nav">
        <a href="club_main.jsp" class="nav-item">동아리</a>
        <a href="meeting_list.jsp" class="nav-item">모임</a>
        <a href="club_board.jsp" class="nav-item">작성</a>
        <a href="map.jsp" class="nav-item">지도</a>
        <a href="club_apply.jsp" class="nav-item active">가입</a>
    </nav>

    <main class="form-container">
        <div class="club-summary">
            <div class="club-summary-icon">
                <i class="fa-solid fa-code"></i>
            </div>
            <div class="club-summary-text">
                <p>공식 동아리</p>
                <h2>웹 개발 연합회 (Timo)</h2>
            </div>
        </div>

        <form class="apply-card" action="applyProcess.jsp" method="post" onsubmit="alert('가입 신청이 완료되었습니다!');">
            
            <div class="section-title">
                <i class="fa-regular fa-id-card"></i> 기본 정보
            </div>
            
            <div class="form-group">
                <label class="form-label">이름 <span class="required">*</span></label>
                <input type="text" class="form-control" name="userName" value="임채이" readonly>
            </div>

            <div class="form-group">
                <label class="form-label">학과 <span class="required">*</span></label>
                <input type="text" class="form-control" name="userDept" value="AI소프트웨어학과" readonly>
            </div>

            <div class="form-group">
                <label class="form-label">학번 <span class="required">*</span></label>
                <input type="text" class="form-control" name="studentId" value="20251234" readonly>
            </div>

            <div class="section-title" style="margin-top: 40px;">
                <i class="fa-regular fa-pen-to-square"></i> 가입 질문
            </div>

            <div class="form-group">
                <label class="form-label">1. 우리 동아리에 지원하게 된 동기를 작성해주세요. <span class="required">*</span></label>
                <textarea class="form-control" name="q1_answer" placeholder="지원 동기를 자유롭게 작성해주세요. (최소 50자 이상)" required></textarea>
            </div>

            <div class="form-group">
                <label class="form-label">2. 웹/앱 개발 관련 경험이나 사용할 줄 아는 기술 스택이 있다면 적어주세요.</label>
                <span class="form-desc">경험이 없다면 '없음'이라고 적어주셔도 무방합니다.</span>
                <textarea class="form-control" name="q2_answer" placeholder="예: HTML/CSS 기초 수강, 자바스크립트 개인 프로젝트 경험 등"></textarea>
            </div>

            <div class="form-group">
                <label class="form-label">3. 면접이 가능한 날짜를 선택해주세요. <span class="required">*</span></label>
                <div class="option-group">
                    <label class="option-label">
                        <input type="radio" name="interview_date" value="5월 12일" required> 5월 12일 (수) 오후 6시
                    </label>
                    <label class="option-label">
                        <input type="radio" name="interview_date" value="5월 13일"> 5월 13일 (목) 오후 6시
                    </label>
                    <label class="option-label">
                        <input type="radio" name="interview_date" value="불가능"> 해당 일정 모두 불가능 (별도 연락 요망)
                    </label>
                </div>
            </div>

            <button type="submit" class="submit-btn">가입 신청서 제출하기</button>

        </form>
    </main>

</body>
</html>