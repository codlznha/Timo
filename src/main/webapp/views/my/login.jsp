<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

            /* 반응형 폼 래퍼 (PC 확장 분할 화면) */
            .auth-wrapper {
                display: flex;
                width: 100%;
                max-width: 950px;
                background: var(--white);
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            /* 좌측 배너 영역 (PC에서만 표시) */
            .auth-banner {
                flex: 1;
                background: linear-gradient(135deg, var(--primary-blue), #003b7a);
                color: var(--white);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 40px;
                text-align: center;
            }

            .auth-banner .banner-icon {
                font-size: 5rem;
                margin-bottom: 20px;
            }

            .auth-banner h2 {
                font-size: 2.8rem;
                font-weight: 800;
                letter-spacing: -1px;
                margin-bottom: 10px;
            }

            .auth-banner p {
                font-size: 1.1rem;
                opacity: 0.9;
                line-height: 1.6;
            }

            /* 우측 폼 컨테이너 */
            .auth-form-container {
                flex: 1.2;
                padding: 50px 50px;
                background-color: var(--white);
            }

            /* 모바일 전용 로고 영역 */
            .mobile-logo-area {
                display: none;
                text-align: center;
                margin-bottom: 25px;
            }

            .mobile-logo-area .icon {
                font-size: 2.5rem;
                color: var(--primary-blue);
                margin-bottom: 5px;
            }

            .mobile-logo-area h1 {
                font-size: 1.8rem;
                font-weight: 800;
                color: var(--text-dark);
                letter-spacing: -0.5px;
            }

            /* 탭 토글 영역 */
            .tab-group {
                display: flex;
                background-color: var(--input-bg);
                border-radius: 8px;
                padding: 4px;
                margin-bottom: 30px;
            }

            .tab-btn {
                flex: 1;
                padding: 12px 0;
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
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
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
                from {
                    opacity: 0;
                    transform: translateY(5px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .input-group {
                margin-bottom: 18px;
                position: relative;
            }

            .input-group label {
                display: block;
                font-size: 0.85rem;
                font-weight: bold;
                color: var(--text-dark);
                margin-bottom: 8px;
            }

            .input-group label span {
                color: #d32f2f;
            }

            .input-control {
                width: 100%;
                padding: 14px 15px 14px 40px;
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
                top: 38px;
                color: #aaa;
                font-size: 1rem;
            }

            /* --- 커스텀 검색 드롭다운 (학과 선택) --- */
            .custom-select-group {
                position: relative;
            }

            .dropdown-list {
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: var(--white);
                border: 1px solid var(--primary-blue);
                border-radius: 8px;
                max-height: 220px;
                overflow-y: auto;
                z-index: 100;
                display: none;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                margin-top: 5px;
            }

            .dropdown-list.show {
                display: block;
            }

            .dropdown-list::-webkit-scrollbar {
                width: 6px;
            }

            .dropdown-list::-webkit-scrollbar-thumb {
                background: #ccc;
                border-radius: 4px;
            }

            .dropdown-group-label {
                padding: 8px 15px;
                font-size: 0.8rem;
                background: var(--bg-color);
                color: var(--text-gray);
                font-weight: bold;
                border-bottom: 1px solid var(--border-color);
                border-top: 1px solid var(--border-color);
            }

            .dropdown-group-label:first-child {
                border-top: none;
            }

            .dropdown-item {
                padding: 10px 15px;
                font-size: 0.9rem;
                cursor: pointer;
                transition: background 0.2s;
                color: var(--text-dark);
            }

            .dropdown-item:hover {
                background: var(--primary-light);
                color: var(--primary-blue);
                font-weight: bold;
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
                margin-top: 15px;
                transition: 0.3s;
            }

            .btn-submit:hover {
                background-color: #004588;
            }

            /* 링크 스타일 */
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
                padding-left: 15px;
                /* 이메일 창은 아이콘 뺐음 */
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

            /* --- 모바일 반응형 처리 --- */
            @media (max-width: 768px) {
                body {
                    padding: 0;
                    background-color: var(--white);
                }

                .auth-wrapper {
                    flex-direction: column;
                    max-width: 100%;
                    border-radius: 0;
                    box-shadow: none;
                    min-height: 100vh;
                }

                .auth-banner {
                    display: none;
                }

                .auth-form-container {
                    padding: 40px 25px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .mobile-logo-area {
                    display: block;
                }
            }
        </style>
    </head>

    <body>

        <div class="auth-wrapper">

            <!-- PC 전용 좌측 배너 -->
            <div class="auth-banner">
                <div class="banner-icon"><i class="fa-solid fa-graduation-cap"></i></div>
                <h2>Timo</h2>
                <p>한국공학대학교 학우들을 위한<br>동아리 & 소모임 통합 플랫폼</p>
            </div>

            <!-- 우측 입력 폼 컨테이너 -->
            <div class="auth-form-container">

                <!-- 모바일 전용 상단 로고 -->
                <div class="mobile-logo-area">
                    <div class="icon"><i class="fa-solid fa-graduation-cap"></i></div>
                    <h1>Timo</h1>
                </div>

                <div class="tab-group">
                    <div class="tab-btn active" onclick="switchTab('login')">로그인</div>
                    <div class="tab-btn" onclick="switchTab('signup')">회원가입</div>
                </div>

                <!-- 로그인 폼 -->
				<form id="loginForm" class="form-section active" 
				      action="${pageContext.request.contextPath}/member/login" 
				      method="post">
                    <div class="input-group">
                        <label>학교 이메일 (학번)</label>
                        <i class="fa-regular fa-envelope input-icon"></i>
                        <input type="text" class="input-control" name="id" placeholder="아이디(학번)">
                    </div>

                    <div class="input-group">
                        <label>비밀번호</label>
                        <i class="fa-solid fa-lock input-icon"></i>
						<input
						    type="password"
						    class="input-control"
						    name="pwd"
						    placeholder="비밀번호 입력"
						    required>
                    </div>

                    <button type="submit" class="btn-submit">로그인</button>

                    <div class="auth-links">
                        <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
                    </div>
                </form>

                <!-- 회원가입 폼 -->
				<form id="signupForm" class="form-section" 
				      action="${pageContext.request.contextPath}/member/signup" 
				      method="post"
				      onsubmit="return validateSignup();">
                    <div class="input-group">
                        <label>이름 <span>*</span></label>
                        <i class="fa-regular fa-user input-icon"></i>
                        <input type="text" class="input-control" name="name" placeholder="실명 입력" required>
                    </div>

                    <!-- 🌟 검색 가능한 드롭다운 (소속 학과) 🌟 -->
                    <div class="input-group custom-select-group">
                        <label>소속 학과 <span>*</span></label>
                        <i class="fa-solid fa-building-columns input-icon"></i>
                        <input type="text" id="deptSearchInput" class="input-control" placeholder="학과명을 검색하세요"
                            autocomplete="off" required>

                        <!-- 폼 전송 시 실제 데이터가 담길 Hidden Input -->
                        <input type="hidden" id="hiddenDeptValue">

                        <!-- 동적 그룹화 드롭다운 리스트 -->
                        <ul class="dropdown-list" id="deptDropdown"></ul>
                    </div>

                    <div class="input-group">
                        <label>학교 이메일 (학번) <span>*</span></label>
                        <div class="email-group">
							<input
							    type="text"
							    class="input-control"
							    name="id"
							    placeholder="학번 입력"
							    required>
                            <span class="email-domain">@tukorea.ac.kr</span>
                        </div>
                    </div>
					
					<div class="input-group">
					    <label>학교 이메일 <span>*</span></label>
					    <i class="fa-regular fa-envelope input-icon"></i>
					    <input
					        type="email"
					        class="input-control"
					        name="email"
					        placeholder="학교 이메일 입력"
					        required>
					</div>

                    <div class="input-group">
                        <label>비밀번호 <span>*</span></label>
                        <i class="fa-solid fa-lock input-icon"></i>
                        <input type="password" id="signupPw" class="input-control" name="pwd"
                            placeholder="8자 이상 영문, 숫자 조합" required>
                    </div>

                    <div class="input-group">
                        <label>비밀번호 확인 <span>*</span></label>
                        <i class="fa-solid fa-circle-check input-icon"></i>
                        <input
							type="password" 
							id="signupPwConfirm"
							class="input-control"
							placeholder="비밀번호 다시 입력">
                    </div>

                    <button type="submit" class="btn-submit">가입하기</button>
                </form>

            </div>
        </div>

        <script>
            // --- 1. 탭 전환 로직 ---
            function switchTab(tabId) {
                const tabs = document.querySelectorAll('.tab-btn');
                tabs.forEach(tab => tab.classList.remove('active'));

                if (tabId === 'login') tabs[0].classList.add('active');
                else tabs[1].classList.add('active');

                const forms = document.querySelectorAll('.form-section');
                forms.forEach(form => form.classList.remove('active'));

                if (tabId === 'login') document.getElementById('loginForm').classList.add('active');
                else document.getElementById('signupForm').classList.add('active');
            }

            // --- 2. 학과 데이터 및 검색 필터링 로직 ---
            const deptData = {
                "AI융합대학": ["게임공학과", "컴퓨터공학전공", "소프트웨어전공", "인공지능학과"],
                "IT반도체융합대학": ["자율전공", "전자공학전공", "임베디드시스템전공", "나노반도체공학전공", "반도체시스템전공"],
                "스마트기계융합대학": ["기계공학과", "기계설계전공", "지능모빌리티전공", "메카트로닉스전공", "AI로봇전공"],
                "첨단융합대학": ["신소재공학과", "생명화학공학과", "전력응용시스템전공", "미래에너지시스템전공"],
                "교양자율전공대학": ["교양학부", "자유전공학부", "교양전공설계선터", "커뮤니케이션교육센터"],
                "일반학과": ["경영학전공", "IT경영전공", "데이터사이언스경영전공", "산업디자인공학전공", "미디어디자인공학전공"],
                "조기취업형계약학과": ["스마트전자공학과", "AI소프트웨어학과", "IT융합디자인공학과", "스마트그린소재공학과"]
            };

            const searchInput = document.getElementById('deptSearchInput');
            const hiddenDept = document.getElementById('hiddenDeptValue');
            const dropdown = document.getElementById('deptDropdown');

            // 드롭다운 렌더링 함수
            function populateDropdown(filter = '') {
                dropdown.innerHTML = '';
                let hasVisibleItems = false;
                const filterText = filter.toLowerCase().replace(/\s+/g, '');

                for (const [college, majors] of Object.entries(deptData)) {
                    // 검색어에 맞는 학과 필터링
                    const filteredMajors = majors.filter(major =>
                        major.toLowerCase().replace(/\s+/g, '').includes(filterText)
                    );

                    if (filteredMajors.length > 0) {
                        hasVisibleItems = true;

                        // 단과대학 라벨 추가
                        const groupLabel = document.createElement('li');
                        groupLabel.className = 'dropdown-group-label';
                        groupLabel.textContent = college;
                        dropdown.appendChild(groupLabel);

                        // 학과 리스트 추가
                        filteredMajors.forEach(major => {
                            const item = document.createElement('li');
                            item.className = 'dropdown-item';
                            item.textContent = major;

                            // 학과 클릭 이벤트
                            item.onclick = () => {
                                searchInput.value = major;
                                hiddenDept.value = major;
                                dropdown.classList.remove('show');
                            };
                            dropdown.appendChild(item);
                        });
                    }
                }

                // 검색 결과가 없을 때 처리
                if (!hasVisibleItems) {
                    const noItem = document.createElement('li');
                    noItem.className = 'dropdown-item';
                    noItem.style.color = '#d32f2f';
                    noItem.style.pointerEvents = 'none';
                    noItem.textContent = '검색된 학과가 없습니다.';
                    dropdown.appendChild(noItem);
                }
            }

            // 인풋창 포커스 시 전체 리스트 보여주기
            searchInput.addEventListener('focus', () => {
                populateDropdown(searchInput.value);
                dropdown.classList.add('show');
            });

            // 타이핑 시 실시간 검색 필터링
            searchInput.addEventListener('input', (e) => {
                populateDropdown(e.target.value);
                hiddenDept.value = ''; // 직접 치는 도중에는 hidden 값을 초기화하여 강제 선택 유도
            });

            // 외부 클릭 시 드롭다운 닫기
            document.addEventListener('click', (e) => {
                if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
                    dropdown.classList.remove('show');
                }
            });


            // --- 3. 폼 제출 유효성 검사 ---
            function validateSignup() {
                const hiddenDeptVal = document.getElementById('hiddenDeptValue').value;
                const pw = document.getElementById('signupPw').value;
                const pwConfirm = document.getElementById('signupPwConfirm').value;

                // 비밀번호 일치 확인
                if (pw !== pwConfirm) {
                    alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                    return false;
                }

                return true;
            }
        </script>
    </body>

    </html>