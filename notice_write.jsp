<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 공지사항 작성</title>
    <!-- 아이콘 폰트는 sidebar.jsp에서 자체적으로 불러오므로 여기서는 생략 -->

    <style>
        /* main.jsp와 동일한 톤 유지 (공지사항 카드 스타일을 그대로 재사용) */
        /* --primary-blue, --white는 sidebar.jsp의 :root에서 이미 제공되므로 여기서는 생략 */
        :root {
            --bg-color: #f4f6f9;
            --text-dark: #333333;
            --text-gray: #666666;
            --border-color: #e5e8eb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .main-wrapper {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .top-header {
            height: 70px;
            background-color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 90;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-toggle {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--text-dark);
            cursor: pointer;
        }

        .header-title {
            font-size: 1.1rem;
            font-weight: bold;
        }

        .page-content {
            padding: 30px;
            max-width: 720px;
            width: 100%;
            margin: 0 auto;
        }

        .card {
            background: var(--white);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            margin-bottom: 25px;
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
        }

        .card-title a {
            font-size: 0.85rem;
            color: var(--text-gray);
            text-decoration: none;
            font-weight: normal;
        }

        /* 작성 권한 안내 */
        .write-notice-info {
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: #e6f0fa;
            color: var(--primary-blue);
            font-size: 0.85rem;
            font-weight: bold;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* 폼 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .form-group select,
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 0.95rem;
            outline: none;
            color: var(--text-dark);
            transition: 0.2s;
        }

        .form-group select:focus,
        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            border-color: var(--primary-blue);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 160px;
            line-height: 1.5;
        }

        .char-count {
            text-align: right;
            font-size: 0.8rem;
            color: var(--text-gray);
            margin-top: 5px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .checkbox-line {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: var(--text-dark);
        }

        .checkbox-line input {
            width: 16px;
            height: 16px;
            accent-color: var(--primary-blue);
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 0.95rem;
            cursor: pointer;
            border: none;
            transition: 0.2s;
        }

        .btn-cancel {
            background-color: var(--white);
            color: var(--text-gray);
            border: 1px solid var(--border-color);
        }

        .btn-cancel:hover {
            background-color: var(--bg-color);
        }

        .btn-submit {
            background-color: var(--primary-blue);
            color: var(--white);
        }

        .btn-submit:hover {
            background-color: #004588;
        }

        /* 등록 전 미리보기 (main.jsp의 notice-list 스타일 재사용) */
        .notice-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .notice-list li {
            display: flex;
            justify-content: space-between;
            font-size: 0.95rem;
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .notice-list li:last-child {
            border-bottom: none;
        }

        .notice-label {
            color: #d32f2f;
            font-weight: bold;
            margin-right: 10px;
        }

        .preview-empty {
            font-size: 0.9rem;
            color: var(--text-gray);
            text-align: center;
            padding: 20px 0;
        }

        @media (max-width: 768px) {
            .main-wrapper {
                padding-bottom: 70px;
            }

            .page-content {
                padding: 15px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .form-actions {
                flex-direction: column-reverse;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <!-- 🔥 분리된 사이드바를 여기서 불러옵니다. 🔥 -->
    <%@ include file="admin_sidebar.jsp" %>

        <div class="main-wrapper" id="mainWrapper">

            <header class="top-header">
                <div class="header-left">
                    <!-- 이 버튼을 누르면 sidebar.jsp 안에 있는 toggleSidebar()가 실행됩니다 -->
                    <button class="btn-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>
                    <span class="header-title">공지사항 작성</span>
                </div>
            </header>

            <div class="page-content">

                <div class="card">
                    <div class="card-title">
                        <span><i class="fa-solid fa-bullhorn" style="color:#d32f2f;"></i> 새 공지사항 작성</span>
                        <a href="main.jsp"><i class="fa-solid fa-xmark"></i> 취소하고 홈으로</a>
                    </div>

                    <div class="write-notice-info">
                        <i class="fa-solid fa-circle-info"></i> 공지사항은 회장 또는 임원만 등록할 수 있습니다.
                    </div>

                    <form id="noticeForm" onsubmit="submitNotice(event)">
                        <div class="form-row">
                            <div class="form-group" style="max-width: 160px;">
                                <label for="noticeLabel">분류</label>
                                <select id="noticeLabel">
                                    <option value="필독">[필독]</option>
                                    <option value="점검">[점검]</option>
                                    <option value="행사">[행사]</option>
                                    <option value="일반" selected>[일반]</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="noticeTitle">제목</label>
                                <input type="text" id="noticeTitle" placeholder="공지사항 제목을 입력하세요" maxlength="60"
                                    required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="noticeContent">내용</label>
                            <textarea id="noticeContent" placeholder="공지사항 내용을 입력하세요" maxlength="1000"
                                oninput="updateCharCount(); updatePreview();" required></textarea>
                            <div class="char-count"><span id="charCount">0</span> / 1000</div>
                        </div>

                        <div class="form-group">
                            <label class="checkbox-line">
                                <input type="checkbox" id="noticePin">
                                상단에 고정하기
                            </label>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-cancel"
                                onclick="location.href='main.jsp'">취소</button>
                            <button type="submit" class="btn btn-submit"><i class="fa-solid fa-check"></i>
                                등록하기</button>
                        </div>
                    </form>
                </div>

                <div class="card">
                    <div class="card-title">
                        <span><i class="fa-regular fa-eye"></i> 미리보기</span>
                    </div>
                    <ul class="notice-list" id="previewList">
                        <li class="preview-empty" id="previewEmpty">제목과 내용을 입력하면 실제 목록에 표시될 모습을 미리 볼 수 있습니다.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 공지사항 작성 페이지 전용 스크립트 -->
        <script>
            // 데모용: 실제 서비스에서는 로그인한 사용자의 역할(회장/임원 여부)을 서버에서 받아와 판단해야 합니다.
            const canWriteNotice = true;

            function updateCharCount() {
                const content = document.getElementById('noticeContent').value;
                document.getElementById('charCount').textContent = content.length;
            }

            function todayLabel() {
                const now = new Date();
                const mm = String(now.getMonth() + 1).padStart(2, '0');
                const dd = String(now.getDate()).padStart(2, '0');
                return mm + '.' + dd;
            }

            // 제목/분류 입력에 따라 실제 공지사항 목록과 동일한 형태로 미리보기 렌더링
            function updatePreview() {
                const title = document.getElementById('noticeTitle').value.trim();
                const label = document.getElementById('noticeLabel').value;
                const previewList = document.getElementById('previewList');

                if (title === '') {
                    previewList.innerHTML = '<li class="preview-empty" id="previewEmpty">제목과 내용을 입력하면 실제 목록에 표시될 모습을 미리 볼 수 있습니다.</li>';
                    return;
                }

                previewList.innerHTML =
                    '<li>' +
                    '<span><span class="notice-label">[' + label + ']</span>' + title + '</span>' +
                    '<span style="color: var(--text-gray); font-size: 0.8rem;">' + todayLabel() + '</span>' +
                    '</li>';
            }

            document.getElementById('noticeTitle').addEventListener('input', updatePreview);
            document.getElementById('noticeLabel').addEventListener('change', updatePreview);

            // 공지사항 등록 (데모: 실제로는 서버로 POST 후 main.jsp의 공지사항 목록에 반영되어야 함)
            function submitNotice(event) {
                event.preventDefault();

                if (!canWriteNotice) {
                    alert('공지사항은 회장 또는 임원만 등록할 수 있습니다.');
                    return;
                }

                const label = document.getElementById('noticeLabel').value;
                const title = document.getElementById('noticeTitle').value.trim();
                const content = document.getElementById('noticeContent').value.trim();
                const pinned = document.getElementById('noticePin').checked;

                if (title === '' || content === '') {
                    alert('제목과 내용을 모두 입력해주세요.');
                    return;
                }

                if (!confirm('[' + label + '] ' + title + '\n\n공지사항을 등록하시겠습니까?' + (pinned ? '\n(상단 고정)' : ''))) {
                    return;
                }

                // TODO: 서버 연동 시 이 부분에서 fetch/axios 등으로 컨트롤러(예: noticeCreate)에 POST 요청
                alert('공지사항이 등록되었습니다.');
                location.href = 'main.jsp';
            }
        </script>
</body>

</html>
