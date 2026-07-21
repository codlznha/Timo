<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&amp;A - 웹 개발 연합회 (Timo)</title>
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
            --answered-color: #1a9b5c;
            --answered-light: #e8f8f0;
            --waiting-color: #e08a1e;
            --waiting-light: #fdf3e6;
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

        /* --- 상단 헤더 --- */
        .qa-header {
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 20px 0;
        }

        .qa-header-inner {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .btn-back {
            background: none;
            border: 1px solid var(--border-color);
            color: var(--text-gray);
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 0.9rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: 0.2s;
        }

        .btn-back:hover {
            background-color: var(--primary-light);
            color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .qa-header-inner h1 {
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-dark);
        }

        .qa-header-inner h1 i {
            color: var(--primary-blue);
        }

        /* --- 컨테이너 --- */
        .qa-container {
            max-width: 1100px;
            margin: 30px auto 0;
            padding: 0 20px;
        }

        .card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        /* --- 질문 작성 카드 --- */
        .qa-write-card {
            margin-bottom: 20px;
        }

        .qa-write-card h3 {
            font-size: 1.05rem;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .qa-write-card textarea {
            width: 100%;
            min-height: 80px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 12px;
            font-size: 0.95rem;
            resize: vertical;
            font-family: inherit;
        }

        .qa-write-card textarea:focus {
            outline: none;
            border-color: var(--primary-blue);
        }

        .btn-submit-question {
            margin-top: 10px;
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            float: right;
            transition: 0.2s;
        }

        .btn-submit-question:hover {
            background-color: #004588;
        }

        /* --- 요약 카운트 바 --- */
        .qa-summary {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            clear: both;
            flex-wrap: wrap;
        }

        .qa-count {
            background-color: var(--white);
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 0.85rem;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
            color: var(--text-gray);
        }

        .qa-count b {
            color: var(--text-dark);
            margin-left: 3px;
        }

        .qa-count.answered {
            color: var(--answered-color);
        }

        .qa-count.answered b {
            color: var(--answered-color);
        }

        .qa-count.waiting {
            color: var(--waiting-color);
        }

        .qa-count.waiting b {
            color: var(--waiting-color);
        }

        /* --- Q&A 리스트 --- */
        .qa-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .qa-item {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
            border-left: 5px solid var(--waiting-color);
        }

        .qa-item.answered {
            border-left: 5px solid var(--answered-color);
        }

        .qa-item-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 20px;
            border-bottom: 1px solid var(--border-color);
            background-color: #fafbfc;
        }

        .qa-item-number {
            font-size: 0.85rem;
            color: var(--text-gray);
            font-weight: bold;
        }

        .qa-status-badge {
            font-size: 0.8rem;
            font-weight: bold;
            padding: 4px 12px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .qa-status-badge.waiting {
            background-color: var(--waiting-light);
            color: var(--waiting-color);
        }

        .qa-status-badge.answered {
            background-color: var(--answered-light);
            color: var(--answered-color);
        }

        /* 좌(질문) / 우(답변) 2단 분할 */
        .qa-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        .qa-question-col, .qa-answer-col {
            padding: 18px 20px;
        }

        .qa-question-col {
            border-right: 1px dashed var(--border-color);
        }

        .qa-answer-col {
            background-color: var(--waiting-light);
        }

        .qa-item.answered .qa-answer-col {
            background-color: var(--answered-light);
        }

        .qa-col-label {
            font-size: 0.8rem;
            font-weight: bold;
            color: var(--text-gray);
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 8px;
        }

        .qa-question-col .qa-col-label i {
            color: var(--primary-blue);
        }

        .qa-answer-col .qa-col-label i {
            color: var(--waiting-color);
        }

        .qa-item.answered .qa-answer-col .qa-col-label i {
            color: var(--answered-color);
        }

        .qa-author-meta {
            font-size: 0.8rem;
            color: var(--text-gray);
            margin-bottom: 8px;
        }

        .qa-text {
            font-size: 0.92rem;
            line-height: 1.5;
            white-space: pre-line;
            word-break: break-word;
        }

        .qa-no-answer {
            font-size: 0.9rem;
            color: var(--text-gray);
            font-style: italic;
        }

        .btn-write-answer {
            margin-top: 12px;
            background-color: var(--primary-blue);
            color: var(--white);
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-write-answer:hover {
            background-color: #004588;
        }

        .answer-form {
            display: none;
            margin-top: 12px;
        }

        .answer-form.open {
            display: block;
        }

        .answer-form textarea {
            width: 100%;
            min-height: 70px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 10px;
            font-size: 0.9rem;
            resize: vertical;
            font-family: inherit;
        }

        .answer-form-actions {
            margin-top: 8px;
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        .btn-answer-cancel {
            background: none;
            border: 1px solid var(--border-color);
            color: var(--text-gray);
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.85rem;
            cursor: pointer;
        }

        .btn-answer-submit {
            background-color: var(--answered-color);
            border: none;
            color: var(--white);
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
            cursor: pointer;
        }

        .qa-empty {
            text-align: center;
            color: var(--text-gray);
            padding: 60px 0;
            font-size: 0.95rem;
        }

        /* --- 모바일 대응: 좌우 분할 -> 상하 분할 --- */
        @media (max-width: 680px) {
            .qa-columns {
                grid-template-columns: 1fr;
            }
            .qa-question-col {
                border-right: none;
                border-bottom: 1px dashed var(--border-color);
            }
            .qa-header-inner {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>
</head>
<body>

    <header class="qa-header">
        <div class="qa-header-inner">
            <button class="btn-back" onclick="location.href='/club/detail'">
                <i class="fa-solid fa-arrow-left"></i> 동아리로 돌아가기
            </button>
            <h1><i class="fa-solid fa-circle-question"></i> Q&amp;A 게시판</h1>
            <span style="width:1px;"></span>
        </div>
    </header>

    <div class="qa-container">

        <div class="qa-write-card card">
            <h3><i class="fa-solid fa-pen"></i> 궁금한 점 물어보기</h3>
            <textarea id="newQuestionInput" placeholder="동아리에 대해 궁금한 점을 자유롭게 남겨주세요."></textarea>
            <button class="btn-submit-question" onclick="submitQuestion()">질문 등록</button>
        </div>

        <div class="qa-summary">
            <span class="qa-count total">전체 <b id="totalCount">0</b></span>
            <span class="qa-count answered"><i class="fa-solid fa-circle-check"></i> 답변완료 <b id="answeredCount">0</b></span>
            <span class="qa-count waiting"><i class="fa-solid fa-hourglass-half"></i> 답변대기 <b id="waitingCount">0</b></span>
        </div>

        <div id="qaList" class="qa-list"></div>
    </div>

    <script>
        // 회장/임원 여부 (실제 서비스에서는 서버에서 로그인한 사용자의 권한을 전달받아야 합니다)
        const isPresident = true;

        // 목데이터: 하나의 질문에는 하나의 답변만 작성 가능
        let qaItems = [
            {
                id: 1,
                question: "신입 부원도 프로젝트에 바로 참여할 수 있나요?",
                askedBy: "김지훈",
                askedDate: "2026-07-15",
                answer: {
                    text: "네! OT 이후 바로 소규모 팀 프로젝트에 배정되며, 선배 멘토가 함께 붙어서 도와드립니다.",
                    answeredBy: "회장",
                    answeredDate: "2026-07-16"
                }
            },
            {
                id: 2,
                question: "정기 모임은 얼마나 자주 진행되나요?",
                askedBy: "이서연",
                askedDate: "2026-07-18",
                answer: null
            }
        ];

        let nextId = 3;

        function escapeHtml(str) {
            const div = document.createElement('div');
            div.textContent = str;
            return div.innerHTML;
        }

        function renderQAList() {
            const listEl = document.getElementById('qaList');
            const totalEl = document.getElementById('totalCount');
            const answeredEl = document.getElementById('answeredCount');
            const waitingEl = document.getElementById('waitingCount');

            if (qaItems.length === 0) {
                listEl.innerHTML = '<div class="qa-empty">아직 등록된 질문이 없습니다. 첫 질문을 남겨보세요!</div>';
                totalEl.textContent = 0;
                answeredEl.textContent = 0;
                waitingEl.textContent = 0;
                return;
            }

            const answeredCount = qaItems.filter(q => q.answer).length;
            const waitingCount = qaItems.length - answeredCount;
            totalEl.textContent = qaItems.length;
            answeredEl.textContent = answeredCount;
            waitingEl.textContent = waitingCount;

            listEl.innerHTML = '';

            // 최신 질문이 위로 오도록 정렬
            const sorted = [...qaItems].sort((a, b) => b.id - a.id);

            sorted.forEach((qa, idx) => {
                const isAnswered = !!qa.answer;
                const item = document.createElement('div');
                item.className = 'qa-item' + (isAnswered ? ' answered' : '');
                item.id = 'qa-' + qa.id;

                const answerColHtml = isAnswered
                    ? `
                        <div class="qa-col-label"><i class="fa-solid fa-message"></i> 답변</div>
                        <div class="qa-author-meta">${escapeHtml(qa.answer.answeredBy)} · ${escapeHtml(qa.answer.answeredDate)}</div>
                        <div class="qa-text">${escapeHtml(qa.answer.text)}</div>
                    `
                    : `
                        <div class="qa-col-label"><i class="fa-solid fa-hourglass-half"></i> 답변</div>
                        <div class="qa-no-answer">아직 답변이 등록되지 않았습니다.</div>
                        ${isPresident ? `
                        <button class="btn-write-answer" onclick="toggleAnswerForm(${qa.id})">
                            <i class="fa-solid fa-reply"></i> 답변 작성
                        </button>
                        <div class="answer-form" id="answerForm-${qa.id}">
                            <textarea id="answerInput-${qa.id}" placeholder="답변을 입력해주세요."></textarea>
                            <div class="answer-form-actions">
                                <button class="btn-answer-cancel" onclick="toggleAnswerForm(${qa.id})">취소</button>
                                <button class="btn-answer-submit" onclick="submitAnswer(${qa.id})">답변 등록</button>
                            </div>
                        </div>
                        ` : ''}
                    `;

                item.innerHTML = `
                    <div class="qa-item-top">
                        <span class="qa-item-number">Q${qaItems.length - qaItems.findIndex(q => q.id === qa.id)}</span>
                        <span class="qa-status-badge ${isAnswered ? 'answered' : 'waiting'}">
                            <i class="fa-solid ${isAnswered ? 'fa-circle-check' : 'fa-hourglass-half'}"></i>
                            ${isAnswered ? '답변완료' : '답변대기'}
                        </span>
                    </div>
                    <div class="qa-columns">
                        <div class="qa-question-col">
                            <div class="qa-col-label"><i class="fa-solid fa-circle-question"></i> 질문</div>
                            <div class="qa-author-meta">${escapeHtml(qa.askedBy)} · ${escapeHtml(qa.askedDate)}</div>
                            <div class="qa-text">${escapeHtml(qa.question)}</div>
                        </div>
                        <div class="qa-answer-col">
                            ${answerColHtml}
                        </div>
                    </div>
                `;
                listEl.appendChild(item);
            });
        }

        function submitQuestion() {
            const input = document.getElementById('newQuestionInput');
            const text = input.value.trim();
            if (!text) {
                alert('질문 내용을 입력해주세요.');
                return;
            }

            // 실제 서비스에서는 서버로 질문을 전송하고, 로그인한 사용자 정보를 함께 저장해야 합니다.
            qaItems.push({
                id: nextId++,
                question: text,
                askedBy: '나',
                askedDate: new Date().toISOString().slice(0, 10),
                answer: null
            });

            input.value = '';
            renderQAList();
        }

        function toggleAnswerForm(id) {
            const form = document.getElementById('answerForm-' + id);
            if (form) form.classList.toggle('open');
        }

        function submitAnswer(id) {
            if (!isPresident) return;
            const input = document.getElementById('answerInput-' + id);
            const text = input.value.trim();
            if (!text) {
                alert('답변 내용을 입력해주세요.');
                return;
            }

            const qa = qaItems.find(q => q.id === id);
            if (!qa) return;

            // 실제 서비스에서는 서버로 답변을 전송하고, 로그인한 임원/회장 정보를 함께 저장해야 합니다.
            qa.answer = {
                text: text,
                answeredBy: '회장',
                answeredDate: new Date().toISOString().slice(0, 10)
            };

            renderQAList();
        }

        renderQAList();
    </script>
</body>
</html>
