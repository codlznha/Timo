<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 글쓰기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Variables */
        :root {
            --primary-blue: #005baa;
            --primary-light: #e6f0fa;
            --white: #ffffff;
            --text-dark: #333333;
            --text-gray: #999999;
            --border-color: #eeeeee;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: var(--white); 
            color: var(--text-dark);
        }

        /* --- 상단 앱바 --- */
        .app-bar {
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            position: sticky;
            top: 0;
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            z-index: 100;
        }

        .btn-back {
            background: none;
            border: none;
            font-size: 1.4rem;
            color: var(--text-dark);
            cursor: pointer;
            padding: 10px 0;
        }

        .app-bar h1 {
            font-size: 1.1rem;
            font-weight: bold;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
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

        .btn-submit {
            background: none;
            border: none;
            font-size: 1rem;
            font-weight: bold;
            color: var(--primary-blue);
            cursor: pointer;
            padding: 10px 0;
        }

        /* --- 글쓰기 폼 영역 --- */
        .write-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            padding-bottom: 100px; /* 툴바 공간 */
        }

        .board-select {
            width: auto;
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            background-color: #fafafa;
            color: var(--text-dark);
            font-size: 0.9rem;
            margin-bottom: 15px;
            outline: none;
            cursor: pointer;
        }

        .title-input {
            width: 100%;
            font-size: 1.4rem;
            font-weight: bold;
            color: var(--text-dark);
            border: none;
            border-bottom: 1px solid var(--border-color);
            padding: 15px 0;
            margin-bottom: 20px;
            outline: none;
        }

        .title-input::placeholder {
            color: #cccccc;
        }

        .content-textarea {
            width: 100%;
            min-height: 250px; /* 투표창이 들어갈 수 있도록 높이 조절 */
            font-size: 1rem;
            line-height: 1.6;
            color: var(--text-dark);
            border: none;
            resize: none;
            outline: none;
            margin-bottom: 10px;
        }

        /* 🌟 투표 생성 박스 (기본은 숨김 처리) 🌟 */
        .poll-box {
            display: none; /* JS로 토글 */
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px;
            background-color: #fcfcfc;
            margin-bottom: 20px;
            position: relative;
        }

        .poll-box.active {
            display: block;
        }

        .poll-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .poll-header h3 {
            font-size: 1rem;
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-close-poll {
            background: none;
            border: none;
            color: var(--text-gray);
            cursor: pointer;
            font-size: 1.2rem;
        }

        .poll-title-input {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.95rem;
            outline: none;
        }

        .poll-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 15px;
        }

        .poll-option-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .poll-option-input {
            flex-grow: 1;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            outline: none;
        }

        .poll-option-input:focus {
            border-color: var(--primary-blue);
        }

        .btn-remove-option {
            background: none;
            border: none;
            color: #ff5252;
            cursor: pointer;
            font-size: 1.1rem;
            padding: 5px;
        }

        .btn-add-option {
            width: 100%;
            padding: 12px;
            background-color: var(--white);
            border: 1px dashed #ccc;
            border-radius: 8px;
            color: var(--text-gray);
            cursor: pointer;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        .btn-add-option:hover {
            border-color: var(--primary-blue);
            color: var(--primary-blue);
        }

        .poll-settings {
            display: flex;
            gap: 20px;
            font-size: 0.9rem;
            color: var(--text-dark);
            border-top: 1px solid var(--border-color);
            padding-top: 15px;
        }

        .poll-settings label {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }

        /* --- 하단 고정 툴바 --- */
        .bottom-toolbar {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 55px;
            background-color: var(--white);
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            z-index: 100;
        }

        /* 🌟 좌측 액션 아이콘들 (사진, 투표 나란히 배치) 🌟 */
        .toolbar-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .toolbar-icon-btn {
            background: none;
            border: none;
            font-size: 1.3rem;
            color: #666666;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s;
        }

        .toolbar-icon-btn span {
            font-size: 0.85rem;
            font-weight: bold;
        }

        .toolbar-icon-btn:hover {
            color: var(--primary-blue);
        }

        /* 우측 익명 토글 */
        .toolbar-right {
            display: flex;
            align-items: center;
        }

        .anonymous-toggle {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.95rem;
            font-weight: bold;
            color: var(--text-gray);
            cursor: pointer;
        }

        .anonymous-toggle input[type="checkbox"] {
            accent-color: #d32f2f;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .anonymous-toggle.is-checked {
            color: #d32f2f;
        }

    </style>
</head>
<body>

    <form action="${pageContext.request.contextPath}/club/board" method="post" id="writeForm" enctype="multipart/form-data">
		        
        <header class="app-bar">
            <button type="button" class="btn-back" onclick="history.back()"><i class="fa-solid fa-xmark"></i></button>
            <h1>글쓰기</h1>
            <button type="button" class="btn-submit" onclick="submitPost()">등록</button>
        </header>

		<nav class="top-nav">
		    <a href="${pageContext.request.contextPath}/club/main" class="nav-item">동아리</a>
		    <a href="${pageContext.request.contextPath}/meet/list" class="nav-item">모임</a>
		    <a href="${pageContext.request.contextPath}/club/board" class="nav-item active">작성</a>
		    <a href="${pageContext.request.contextPath}/meet/map" class="nav-item">지도</a>
		    <a href="${pageContext.request.contextPath}/club/apply" class="nav-item">가입</a>
		</nav>

        <main class="write-container">
            
            <select class="board-select" name="boardType">
                <option value="free" selected>자유게시판</option>
                <option value="review">후기게시판</option>
            </select>

            <input type="text" class="title-input" name="title" placeholder="제목을 입력하세요" required>
            <textarea class="content-textarea" name="content" placeholder="동아리원들과 나누고 싶은 이야기를 적어보세요!" required></textarea>
            
            <div id="poll-box" class="poll-box">
                <div class="poll-header">
                    <h3><i class="fa-solid fa-square-poll-horizontal"></i> 투표 만들기</h3>
                    <button type="button" class="btn-close-poll" onclick="togglePoll()"><i class="fa-solid fa-xmark"></i></button>
                </div>
                
                <input type="text" class="poll-title-input" name="pollTitle" placeholder="투표 제목을 입력하세요 (예: 종강 파티 메뉴 추천)">
                
                <div id="poll-options-container" class="poll-options">
                    <div class="poll-option-item">
                        <input type="text" class="poll-option-input" name="pollOption" placeholder="항목 1">
                        <button type="button" class="btn-remove-option" onclick="removeOption(this)" style="visibility: hidden;"><i class="fa-solid fa-circle-minus"></i></button>
                    </div>
                    <div class="poll-option-item">
                        <input type="text" class="poll-option-input" name="pollOption" placeholder="항목 2">
                        <button type="button" class="btn-remove-option" onclick="removeOption(this)" style="visibility: hidden;"><i class="fa-solid fa-circle-minus"></i></button>
                    </div>
                </div>

                <button type="button" class="btn-add-option" onclick="addOption()"><i class="fa-solid fa-plus"></i> 항목 추가</button>

                <div class="poll-settings">
                    <label><input type="checkbox" name="allowMulti"> 복수 선택 허용</label>
                    <label><input type="checkbox" name="isSecretPoll"> 익명 투표</label>
                </div>
            </div>

        </main>

        <div class="bottom-toolbar">
            <div class="toolbar-left">
                <input type="file" id="file-upload" name="uploadImage" accept="image/*" style="display: none;">
                <button type="button" class="toolbar-icon-btn" onclick="document.getElementById('file-upload').click();">
                    <i class="fa-regular fa-image"></i>
                    <span>사진</span>
                </button>
                
                <button type="button" class="toolbar-icon-btn" onclick="togglePoll()">
                    <i class="fa-solid fa-square-poll-horizontal"></i>
                    <span>투표</span>
                </button>
            </div>
            
            <div class="toolbar-right">
                <label class="anonymous-toggle" id="anon-label">
                    <input type="checkbox" id="anon-check" name="isAnonymous" onchange="toggleAnonymous()">
                    익명
                </label>
            </div>
        </div>

    </form> <script>
        // 익명 체크박스 색상 변경
        function toggleAnonymous() {
            const label = document.getElementById('anon-label');
            label.classList.toggle('is-checked');
        }

        // 투표 창 열기/닫기
        function togglePoll() {
            const pollBox = document.getElementById('poll-box');
            pollBox.classList.toggle('active');
            
            // 투표창이 열릴 때 스크롤을 맨 아래로 내려줌 (모바일 UX 개선)
            if (pollBox.classList.contains('active')) {
                window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
            }
        }

        // 투표 항목 추가 로직
        let optionCount = 2; // 기본 항목이 2개이므로 2부터 시작
        
        function addOption() {
            optionCount++;
            const container = document.getElementById('poll-options-container');
            const newOption = document.createElement('div');
            newOption.className = 'poll-option-item';
            newOption.innerHTML = `
                <input type="text" class="poll-option-input" name="pollOption" placeholder="항목 \${optionCount}">
                <button type="button" class="btn-remove-option" onclick="removeOption(this)"><i class="fa-solid fa-circle-minus"></i></button>
            `;
            container.appendChild(newOption);
            
            updateRemoveButtons(); // 항목이 추가되면 삭제 버튼 상태 업데이트
        }

        // 투표 항목 삭제 로직
        function removeOption(button) {
            const container = document.getElementById('poll-options-container');
            // 최소 2개의 항목은 유지해야 함
            if (container.children.length > 2) {
                button.parentElement.remove();
                updateRemoveButtons(); // 삭제 후 삭제 버튼 상태 업데이트
            } else {
                alert("투표 항목은 최소 2개가 필요합니다.");
            }
        }

        // 항목이 2개일 때는 삭제 버튼을 숨기는 로직
        function updateRemoveButtons() {
            const container = document.getElementById('poll-options-container');
            const removeBtns = container.querySelectorAll('.btn-remove-option');
            
            if (container.children.length <= 2) {
                removeBtns.forEach(btn => btn.style.visibility = 'hidden');
            } else {
                removeBtns.forEach(btn => btn.style.visibility = 'visible');
            }
        }

        // 등록 시 실제 form 전송
        function submitPost() {
            // 유효성 검사 (제목, 내용)
            const title = document.querySelector('input[name="title"]').value;
            const content = document.querySelector('textarea[name="content"]').value;
            
            if(!title.trim() || !content.trim()) {
                alert("제목과 내용을 모두 입력해주세요.");
                return;
            }

            alert("게시글이 성공적으로 등록되었습니다!");
            // 폼 전송
            document.getElementById('writeForm').submit();
        }
    </script>

</body>
</html>