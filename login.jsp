<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 로그인</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Variables - 티모 공통 테마 */
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* 폼 컨테이너 */
        .auth-container {
            width: 100%;
            max-width: 420px;
            background-color: var(--white);
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.05);
            padding: 40px 30px;
            overflow: hidden;
        }

        /* 로고 영역 */
        .logo-area {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-area .icon {
            font-size: 2.5rem;
            color: var(--primary-blue);
            margin-bottom: 10px;
        }

        .logo-area h1 {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text-dark);
            letter-spacing: -0.5px;
        }

        .logo-area p {
            font-size: 0.9rem;
            color: var(--text-gray);
            margin-top: 5px;
        }

        /* 탭 토글 영역 */
        .tab-group {
            display: flex;
            background-color: var(--input-bg);
            border-radius: 8px;
            padding: 4px;
            margin-bottom: 25px;
        }

        .tab-btn {
            flex: 1;
            padding: 10px 0;
            text-align: center;
            font-weight: bold;
            font-size: 0.95rem;
            color: var(--text-gray);
            cursor: pointer;
            border-radius: 6px;
            transition: 0.3s;
        }

        .tab-btn.active {
            background-color: var(--white);
            color: var(--primary-blue);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        /* 폼 공통 스타일 */
        .form-section {
            display: none;
            animation: fadeIn 0.4s ease;
        }

        .form-section.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .input-group {
            margin-bottom: 15px;
            position: relative;
        }

        .input-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: bold;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .input-group label span {
            color: #d32f2f;
        }

        .input-control {
            width: 100%;
            padding: 14px 15px 14px 40px; /* 아이콘 공간 확보 */
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--input-bg);
            font-size: 0.95rem;
            color: var(--text-dark);
            outline: none;
            transition: 0.2s;
        }

        .input-control:focus {
            border-color: var(--primary-blue);
            background-color: var(--white);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 36px;
            color: #aaa;
            font-size: 1rem;
        }

        /* 버튼 스타일 */
        .btn-submit {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: #004588;
        }

        /* 링크 스타일 (비밀번호 찾기 등) */
        .auth-links {
            text-align: center;
            margin-top: 20px;
            font-size: 0.85rem;
        }

        .auth-links a {
            color: var(--text-gray);
            text-decoration: none;
            margin: 0 10px;
        }

        .auth-links a:hover {
            color: var(--primary-blue);
            text-decoration: underline;
        }

        /* 학교 이메일 입력 그룹 */
        .email-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .email-group .input-control {
            padding-left: 15px; /* 이메일 창은 아이콘 뺐음 */
        }

        .email-domain {
            font-size: 0.95rem;
            color: var(--text-dark);
            background-color: #f0f0f0;
            padding: 13px 15px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            white-space: nowrap;
        }
    </style>
</head>
<body>

    <div class="auth-container">
        
        <div class="logo-area">
            <div class="icon"><i class="fa-solid fa-graduation-cap"></i></div>
            <h1>Timo</h1>
            <p>한국공학대학교 동아리 & 모임 통합 플랫폼</p>
        </div>

        <div class="tab-group">
            <div class="tab-btn active" onclick="switchTab('login')">로그인</div>
            <div class="tab-btn" onclick="switchTab('signup')">회원가입</div>
        </div>

        <form id="loginForm" class="form-section active" action="loginProcess.jsp" method="post">
            <div class="input-group">
                <label>학교 이메일</label>
                <i class="fa-regular fa-envelope input-icon"></i>
                <input type="text" class="input-control" name="studentId" placeholder="학번 입력" required>
            </div>
            
            <div class="input-group">
                <label>비밀번호</label>
                <i class="fa-solid fa-lock input-icon"></i>
                <input type="password" class="input-control" name="userPw" placeholder="비밀번호 입력" required>
            </div>

            <button type="submit" class="btn-submit">로그인</button>

            <div class="auth-links">
                <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
            </div>
        </form>

        <form id="signupForm" class="form-section" action="signupProcess.jsp" method="post" onsubmit="return validateSignup();">
            <div class="input-group">
                <label>이름 <span>*</span></label>
                <i class="fa-regular fa-user input-icon"></i>
                <input type="text" class="input-control" name="userName" placeholder="실명 입력" required>
            </div>

            <div class="input-group">
                <label>소속 학과 <span>*</span></label>
                <i class="fa-solid fa-building-columns input-icon"></i>
                <input type="text" class="input-control" name="userDept" placeholder="예: 인공지능소프트웨어학과" required>
            </div>

            <div class="input-group">
                <label>학교 이메일 (학번) <span>*</span></label>
                <div class="email-group">
                    <input type="text" class="input-control" name="studentId" placeholder="학번 입력" required>
                    <span class="email-domain">@tukorea.ac.kr</span>
                </div>
            </div>

            <div class="input-group">
                <label>비밀번호 <span>*</span></label>
                <i class="fa-solid fa-lock input-icon"></i>
                <input type="password" id="signupPw" class="input-control" name="userPw" placeholder="8자 이상 영문, 숫자 조합" required>
            </div>

            <div class="input-group">
                <label>비밀번호 확인 <span>*</span></label>
                <i class="fa-solid fa-circle-check input-icon"></i>
                <input type="password" id="signupPwConfirm" class="input-control" placeholder="비밀번호 다시 입력" required>
            </div>

            <button type="submit" class="btn-submit">가입하기</button>
        </form>

    </div>

    <script>
        function switchTab(tabId) {
            // 탭 버튼 UI 변경
            const tabs = document.querySelectorAll('.tab-btn');
            tabs.forEach(tab => tab.classList.remove('active'));
            
            if(tabId === 'login') {
                tabs[0].classList.add('active');
            } else {
                tabs[1].classList.add('active');
            }

            // 폼 화면 변경
            const forms = document.querySelectorAll('.form-section');
            forms.forEach(form => form.classList.remove('active'));
            
            if(tabId === 'login') {
                document.getElementById('loginForm').classList.add('active');
            } else {
                document.getElementById('signupForm').classList.add('active');
            }
        }

        // 회원가입 전 비밀번호 일치 확인 (JS 유효성 검사)
        function validateSignup() {
            const pw = document.getElementById('signupPw').value;
            const pwConfirm = document.getElementById('signupPwConfirm').value;

            if (pw !== pwConfirm) {
                alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                return false; // 폼 전송 막기
            }
            return true; // 폼 전송 허용
        }
    </script>
</body>
</html>