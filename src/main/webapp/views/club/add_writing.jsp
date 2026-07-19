<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%
    String clubId = request.getParameter("clubId");
    if (clubId == null || clubId.trim().isEmpty()) {
        clubId = "1";
    }

    String board = request.getParameter("board");
    if (board == null || (!board.equals("notice") && !board.equals("free") && !board.equals("review"))) {
        board = "free";
    }

    // XSS 방지를 위한 간단한 이스케이프 (실제 서비스에서는 공용 유틸/필터로 대체 권장)
    String clubIdSafe = clubId.replaceAll("[^0-9]", "");
    if (clubIdSafe.isEmpty()) {
        clubIdSafe = "1";
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 게시글 작성</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #005baa;
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
            padding-bottom: 40px;
        }

        .page-header {
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .btn-back {
            background: none;
            border: none;
            font-size: 1.2rem;
            color: var(--text-dark);
            cursor: pointer;
        }

        .page-header h2 {
            font-size: 1.15rem;
        }

        .container {
            max-width: 720px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        /* 게시판 선택 탭 (공지 / 자유 / 후기) */
        .board-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 22px;
            border-bottom: 1px solid var(--border-color);
        }

        .board-tab-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 12px 8px;
            font-size: 0.98rem;
            font-weight: bold;
            color: var(--text-gray);
            cursor: pointer;
            position: relative;
        }

        .board-tab-btn.active {
            color: var(--primary-blue);
        }

        .board-tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--primary-blue);
        }

        .write-form {
            display: none;
        }

        .write-form.active {
            display: block;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-dark);
        }

        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-blue);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 220px;
            line-height: 1.6;
        }

        .form-hint {
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: var(--primary-light);
            color: var(--primary-blue);
            font-size: 0.82rem;
            font-weight: bold;
            padding: 10px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }

        .btn-cancel {
            background-color: var(--white);
            color: var(--text-gray);
            border: 1px solid var(--border-color);
            padding: 11px 22px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-cancel:hover {
            background-color: #f4f4f4;
        }

        .btn-submit {
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            padding: 11px 26px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-submit:hover {
            background-color: #004588;
        }

        .error-msg {
            color: #c0392b;
            font-size: 0.82rem;
            margin-top: 6px;
            display: none;
        }

        .error-msg.show {
            display: block;
        }

        @media (max-width: 768px) {
            .container {
                margin: 15px auto;
            }
            .board-tab-btn {
                font-size: 0.85rem;
                padding: 10px 4px;
            }
        }
    </style>
</head>
<body>

    <header class="page-header">
        <button class="btn-back" onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=<%= clubIdSafe %>'">
            <i class="fa-solid fa-arrow-left"></i>
        </button>
        <h2>게시글 작성</h2>
    </header>

    <div class="container">
        <div class="card">

            <div class="board-tabs">
                <button type="button" class="board-tab-btn" id="tabBtn-notice" onclick="switchBoard('notice')">
                    <i class="fa-solid fa-bullhorn"></i> 공지게시판
                </button>
                <button type="button" class="board-tab-btn" id="tabBtn-free" onclick="switchBoard('free')">
                    <i class="fa-solid fa-comments"></i> 자유게시판
                </button>
                <button type="button" class="board-tab-btn" id="tabBtn-review" onclick="switchBoard('review')">
                    <i class="fa-solid fa-star"></i> 후기게시판
                </button>
            </div>

            <!-- ============ 공지게시판 글쓰기 ============ -->
            <form class="write-form" id="form-notice" action="${pageContext.request.contextPath}/club/notice/write" method="post" onsubmit="return submitNotice(event)">
                <div class="form-hint">
                    <i class="fa-solid fa-circle-info"></i> 공지게시판 글쓰기는 회장/임원만 작성할 수 있습니다. (서버에서 권한 확인 필요)
                </div>
                <input type="hidden" name="clubId" value="<%= clubIdSafe %>">
                <input type="hidden" name="boardType" value="notice">

                <div class="form-group">
                    <label for="noticeTitle">제목</label>
                    <input type="text" id="noticeTitle" name="title" placeholder="공지 제목을 입력하세요" maxlength="100">
                    <div class="error-msg" id="noticeTitleErr">제목을 입력해주세요.</div>
                </div>
                <div class="form-group">
                    <label for="noticeContent">내용</label>
                    <textarea id="noticeContent" name="content" placeholder="공지 내용을 입력하세요"></textarea>
                    <div class="error-msg" id="noticeContentErr">내용을 입력해주세요.</div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=<%= clubIdSafe %>'">취소</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-paper-plane"></i> 공지 등록</button>
                </div>
            </form>

            <!-- ============ 자유게시판 글쓰기 ============ -->
            <form class="write-form" id="form-free" action="${pageContext.request.contextPath}/club/free/write" method="post" onsubmit="return submitFree(event)">
                <input type="hidden" name="clubId" value="<%= clubIdSafe %>">
                <input type="hidden" name="boardType" value="free">

                <div class="form-group">
                    <label for="freeTitle">제목</label>
                    <input type="text" id="freeTitle" name="title" placeholder="제목을 입력하세요" maxlength="100">
                    <div class="error-msg" id="freeTitleErr">제목을 입력해주세요.</div>
                </div>
                <div class="form-group">
                    <label for="freeContent">내용</label>
                    <textarea id="freeContent" name="content" placeholder="자유롭게 내용을 작성해주세요"></textarea>
                    <div class="error-msg" id="freeContentErr">내용을 입력해주세요.</div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=<%= clubIdSafe %>'">취소</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-paper-plane"></i> 등록하기</button>
                </div>
            </form>

            <!-- ============ 후기게시판 글쓰기 ============ -->
            <form class="write-form" id="form-review" action="${pageContext.request.contextPath}/club/review/write" method="post" onsubmit="return submitReview(event)">
                <div class="form-hint">
                    <i class="fa-solid fa-circle-info"></i> 활동 후기는 동아리원이라면 누구나 작성할 수 있습니다.
                </div>
                <input type="hidden" name="clubId" value="<%= clubIdSafe %>">
                <input type="hidden" name="boardType" value="review">

                <div class="form-group">
                    <label for="reviewTitle">제목</label>
                    <input type="text" id="reviewTitle" name="title" placeholder="후기 제목을 입력하세요" maxlength="100">
                    <div class="error-msg" id="reviewTitleErr">제목을 입력해주세요.</div>
                </div>
                <div class="form-group">
                    <label for="reviewContent">내용</label>
                    <textarea id="reviewContent" name="content" placeholder="활동 후기를 작성해주세요"></textarea>
                    <div class="error-msg" id="reviewContentErr">내용을 입력해주세요.</div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/club/detail?clubId=<%= clubIdSafe %>'">취소</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-paper-plane"></i> 후기 등록</button>
                </div>
            </form>

        </div>
    </div>

    <script>
        const clubId = <%= clubIdSafe %>;

        // club_detail.jsp에서 넘어온 board 파라미터로 초기 탭 결정
        const initialBoard = '<%= board %>';

        function switchBoard(boardName) {
            // 탭 버튼 활성화 상태 전환
            document.querySelectorAll('.board-tab-btn').forEach(function (btn) {
                btn.classList.remove('active');
            });
            document.getElementById('tabBtn-' + boardName).classList.add('active');

            // 폼 표시 전환
            document.querySelectorAll('.write-form').forEach(function (form) {
                form.classList.remove('active');
            });
            document.getElementById('form-' + boardName).classList.add('active');

            // 주소창의 board 파라미터도 함께 갱신 (뒤로가기/새로고침 시에도 탭 유지)
            const url = new URL(window.location.href);
            url.searchParams.set('board', boardName);
            history.replaceState(null, '', url);
        }

        // ------------------------------------------------------------------
        // 공지 / 자유 / 후기 글쓰기는 각각 별도의 함수로 분리 처리
        // (게시판마다 필수 권한, 처리 페이지, 유효성 검사 내용이 다를 수 있기 때문)
        // 실제 서비스에서는 각 처리 페이지(notice_write_process.jsp 등)에서
        // 로그인 세션 확인 후 DB에 INSERT 하고, 완료 후 club_detail.jsp로
        // 리다이렉트하도록 구현하면 됩니다.
        // ------------------------------------------------------------------

        function submitNotice(evt) {
            return validateAndSubmit(evt, 'notice');
        }

        function submitFree(evt) {
            return validateAndSubmit(evt, 'free');
        }

        function submitReview(evt) {
            return validateAndSubmit(evt, 'review');
        }

        // 3개 게시판 공통 유효성 검사 로직 (중복 코드를 줄이기 위한 헬퍼 함수)
        function validateAndSubmit(evt, boardName) {
            const titleEl = document.getElementById(boardName + 'Title');
            const contentEl = document.getElementById(boardName + 'Content');
            const titleErrEl = document.getElementById(boardName + 'TitleErr');
            const contentErrEl = document.getElementById(boardName + 'ContentErr');

            let valid = true;

            if (!titleEl.value.trim()) {
                titleErrEl.classList.add('show');
                valid = false;
            } else {
                titleErrEl.classList.remove('show');
            }

            if (!contentEl.value.trim()) {
                contentErrEl.classList.add('show');
                valid = false;
            } else {
                contentErrEl.classList.remove('show');
            }

            if (!valid) {
                evt.preventDefault();
                return false;
            }

            // 실제 서버 처리 페이지가 아직 없다면 아래 데모 코드로 동작을 확인할 수 있도록
            // 함수 내부에서 처리 페이지 존재 여부와 상관없이 폼은 정상적으로 제출됩니다.
            // (처리 페이지가 준비되면 이 alert/확인 로직은 제거하고 그대로 서버 제출만 하면 됩니다.)
            return true;
        }

        // 페이지 진입 시 club_detail.jsp에서 넘어온 board 값으로 초기 탭 선택
        switchBoard(initialBoard);
    </script>
</body>
</html>
