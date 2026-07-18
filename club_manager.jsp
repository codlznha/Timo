<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 동아리 관리</title>
    <!-- 아이콘 폰트는 sidebar.jsp에서 자체적으로 불러오므로 여기서는 생략 -->
    <!-- 기존 외부 CSS 정상 호출 (club_main.jsp와 동일하게 합치지 않음) -->
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/components.css">

    <!-- 🔥 이 페이지(동아리 등록/삭제)에서만 쓰는 추가 스타일 -->
    <!-- section-card, club-grid, club-card, badge 등은 공통 CSS를 그대로 재사용하여 club_main.jsp와 디자인을 통일합니다 -->
    <style>
        .manage-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .btn-add-club {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background-color: var(--primary-blue);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 0.9rem;
            cursor: pointer;
            transition: 0.2s;
            white-space: nowrap;
        }

        .btn-add-club:hover {
            background-color: #004588;
        }

        /* club-card 내부 하단 영역: 인원수 + 삭제 버튼을 양 끝으로 배치 */
        .club-grid .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-delete-club {
            background: none;
            border: 1px solid #f0d0d0;
            color: #d32f2f;
            width: 30px;
            height: 30px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s;
        }

        .btn-delete-club:hover {
            background-color: #d32f2f;
            color: #ffffff;
            border-color: #d32f2f;
        }

        .empty-club-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            color: var(--text-gray);
            border: 1px dashed var(--border-color);
            border-radius: 12px;
        }

        .empty-club-state i {
            font-size: 2.5rem;
            margin-bottom: 12px;
            color: #cccccc;
        }

        /* --- 동아리 등록 모달 (club_apply.jsp 폼 스타일과 통일) --- */
        .club-modal-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .club-modal-overlay.show { display: flex; }

        .club-modal-box {
            background: #ffffff;
            width: 100%;
            max-width: 480px;
            margin: 20px;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            max-height: 90vh;
            overflow-y: auto;
        }

        .club-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .club-modal-close {
            background: none;
            border: none;
            font-size: 1.3rem;
            color: var(--text-gray);
            cursor: pointer;
        }

        .club-form-group { margin-bottom: 18px; }

        .club-form-label {
            display: block;
            font-weight: bold;
            font-size: 0.9rem;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .club-form-label .required { color: #d32f2f; margin-left: 3px; }

        .club-form-control {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.9rem;
            color: var(--text-dark);
            outline: none;
            transition: 0.2s;
            font-family: inherit;
        }

        .club-form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(0, 91, 170, 0.1);
        }

        textarea.club-form-control { resize: vertical; min-height: 80px; }

        .club-modal-submit {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-blue);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
            transition: 0.2s;
        }

        .club-modal-submit:hover { background-color: #004588; }
    </style>
</head>

<body>

    <!-- 🔥 분리된 사이드바를 여기서 불러옵니다. (main.jsp, club_main.jsp와 동일) 🔥 -->
    <%@ include file="common/sidebar.jsp" %>

    <!-- 메인 컨텐츠 영역 -->
    <div class="main-wrapper" id="mainWrapper">

        <!-- 탑 헤더 (club_main.jsp와 동일) -->
        <header class="top-header">
            <div class="header-left">
                <button class="btn-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>
                <div class="header-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="통합 검색...">
                </div>
            </div>
            <div class="header-icons">
                <i class="fa-regular fa-bell"></i>
            </div>
        </header>

        <!-- 타이틀 영역 -->
        <div class="page-header">
            <h1>동아리 관리</h1>
            <p>공식 동아리를 등록하거나 삭제할 수 있습니다.</p>
        </div>

        <div class="content-container">

            <div class="section-card">

                <div class="manage-toolbar">
                    <div class="section-title">
                        <i class="fa-solid fa-shield-halved" style="color: var(--primary-blue);"></i>
                        등록된 동아리 <span id="clubCount">(4개)</span>
                    </div>
                    <button class="btn-add-club" onclick="openAddModal()">
                        <i class="fa-solid fa-plus"></i> 새 동아리 등록
                    </button>
                </div>

                <div class="club-grid" id="clubGrid">

                    <div class="club-card" data-name="웹개발연합회">
                        <div class="card-header">
                            <div class="club-logo"><i class="fa-solid fa-code"></i></div>
                            <span class="badge">IT/개발</span>
                        </div>
                        <div class="club-name">웹개발연합회</div>
                        <div class="club-desc">프론트엔드부터 백엔드까지, 웹/앱 프로젝트를 함께 기획하고 개발합니다.</div>
                        <div class="card-footer">
                            <span class="member-count"><i class="fa-solid fa-user"></i> 85명</span>
                            <button class="btn-delete-club" title="삭제" onclick="deleteClub(this, '웹개발연합회')">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </div>

                    <div class="club-card" data-name="로보티즈">
                        <div class="card-header">
                            <div class="club-logo"><i class="fa-solid fa-robot"></i></div>
                            <span class="badge">IT/개발</span>
                        </div>
                        <div class="club-name">ROBOTIS</div>
                        <div class="club-desc">자율주행 및 임베디드 로봇 제어 시스템 연구 동아리입니다.</div>
                        <div class="card-footer">
                            <span class="member-count"><i class="fa-solid fa-user"></i> 42명</span>
                            <button class="btn-delete-club" title="삭제" onclick="deleteClub(this, 'ROBOTIS')">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </div>

                    <div class="club-card" data-name="바스켓볼 크루">
                        <div class="card-header">
                            <div class="club-logo"><i class="fa-solid fa-basketball"></i></div>
                            <span class="badge">스포츠</span>
                        </div>
                        <div class="club-name">바스켓볼 크루</div>
                        <div class="club-desc">매주 교내 체육관에서 농구 활동 및 타 대학과의 정기 교류전을 진행합니다.</div>
                        <div class="card-footer">
                            <span class="member-count"><i class="fa-solid fa-user"></i> 43명</span>
                            <button class="btn-delete-club" title="삭제" onclick="deleteClub(this, '바스켓볼 크루')">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </div>

                    <div class="club-card" data-name="포토그래피">
                        <div class="card-header">
                            <div class="club-logo"><i class="fa-solid fa-camera-retro"></i></div>
                            <span class="badge">문화/예술</span>
                        </div>
                        <div class="club-name">포토그래피</div>
                        <div class="club-desc">주말 정기 출사와 필름 카메라 인화 스터디, 연말 사진전을 엽니다.</div>
                        <div class="card-footer">
                            <span class="member-count"><i class="fa-solid fa-user"></i> 27명</span>
                            <button class="btn-delete-club" title="삭제" onclick="deleteClub(this, '포토그래피')">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <!-- 새 동아리 등록 모달 -->
    <div class="club-modal-overlay" id="addClubModal">
        <div class="club-modal-box">
            <div class="club-modal-header">
                새 동아리 등록
                <button class="club-modal-close" onclick="closeAddModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>

            <form id="addClubForm" action="clubProcess.jsp" method="post" onsubmit="return addClub(event)">
                <div class="club-form-group">
                    <label class="club-form-label">동아리명 <span class="required">*</span></label>
                    <input type="text" class="club-form-control" name="clubName" id="clubNameInput" placeholder="예: 웹개발연합회" required>
                </div>

                <div class="club-form-group">
                    <label class="club-form-label">카테고리 <span class="required">*</span></label>
                    <select class="club-form-control" name="clubTag" id="clubTagInput" required>
                        <option value="IT">IT/개발</option>
                        <option value="운동">스포츠</option>
                        <option value="예술">문화/예술</option>
                        <option value="봉사">봉사</option>
                    </select>
                </div>

                <div class="club-form-group">
                    <label class="club-form-label">대표 아이콘 <span class="required">*</span></label>
                    <select class="club-form-control" name="clubIcon" id="clubIconInput" required>
                        <option value="fa-code">코드 (개발)</option>
                        <option value="fa-robot">로봇</option>
                        <option value="fa-basketball">스포츠</option>
                        <option value="fa-camera-retro">카메라</option>
                        <option value="fa-music">음악</option>
                        <option value="fa-palette">예술</option>
                        <option value="fa-heart">봉사</option>
                        <option value="fa-users">일반</option>
                    </select>
                </div>

                <div class="club-form-group">
                    <label class="club-form-label">한 줄 소개 <span class="required">*</span></label>
                    <textarea class="club-form-control" name="clubDesc" id="clubDescInput" placeholder="동아리를 간단히 소개해주세요." required></textarea>
                </div>

                <button type="submit" class="club-modal-submit">등록하기</button>
            </form>
        </div>
    </div>

    <!-- 스크립트 영역 -->
    <script>
        // toggleSidebar() 함수는 sidebar.jsp로 이동되었습니다.

        const clubGrid = document.getElementById('clubGrid');
        const clubCountEl = document.getElementById('clubCount');
        const addClubModal = document.getElementById('addClubModal');

        // 뱃지 라벨 매핑 (data-tag 값 -> 화면에 보여줄 카테고리명)
        const tagLabels = {
            'IT': 'IT/개발',
            '운동': '스포츠',
            '예술': '문화/예술',
            '봉사': '봉사'
        };

        function updateClubCount() {
            const count = clubGrid.querySelectorAll('.club-card').length;
            clubCountEl.textContent = '(' + count + '개)';
        }

        // 1. 동아리 등록 모달 열기/닫기
        function openAddModal() { addClubModal.classList.add('show'); }
        function closeAddModal() {
            addClubModal.classList.remove('show');
            document.getElementById('addClubForm').reset();
        }

        window.onclick = function (event) {
            if (event.target == addClubModal) closeAddModal();
        }

        // 2. 새 동아리 카드 추가
        function addClub(event) {
            event.preventDefault();

            const name = document.getElementById('clubNameInput').value.trim();
            const tag = document.getElementById('clubTagInput').value;
            const icon = document.getElementById('clubIconInput').value;
            const desc = document.getElementById('clubDescInput').value.trim();

            if (!name || !desc) {
                alert('동아리명과 소개를 모두 입력해주세요.');
                return false;
            }

            // 빈 목록 상태 문구가 있다면 제거
            const emptyState = clubGrid.querySelector('.empty-club-state');
            if (emptyState) emptyState.remove();

            const card = document.createElement('div');
            card.className = 'club-card';
            card.dataset.name = name;
            card.innerHTML =
                '<div class="card-header">' +
                    '<div class="club-logo"><i class="fa-solid ' + icon + '"></i></div>' +
                    '<span class="badge">' + tagLabels[tag] + '</span>' +
                '</div>' +
                '<div class="club-name">' + name + '</div>' +
                '<div class="club-desc">' + desc + '</div>' +
                '<div class="card-footer">' +
                    '<span class="member-count"><i class="fa-solid fa-user"></i> 0명</span>' +
                    '<button class="btn-delete-club" title="삭제" onclick="deleteClub(this, \'' + name + '\')">' +
                        '<i class="fa-solid fa-trash"></i>' +
                    '</button>' +
                '</div>';

            clubGrid.appendChild(card);
            updateClubCount();
            closeAddModal();
            alert("'" + name + "' 동아리가 등록되었습니다.");

            return false; // 실제 서버 연동 전까지는 폼 기본 제출을 막습니다.
        }

        // 3. 동아리 삭제
        function deleteClub(button, name) {
            if (!confirm("'" + name + "' 동아리를 삭제하시겠습니까?\n삭제 후에는 되돌릴 수 없습니다.")) return;

            const card = button.closest('.club-card');
            card.remove();
            updateClubCount();

            // 목록이 비었을 경우 빈 상태 문구 표시
            if (clubGrid.querySelectorAll('.club-card').length === 0) {
                const empty = document.createElement('div');
                empty.className = 'empty-club-state';
                empty.innerHTML = '<i class="fa-solid fa-shield-halved"></i><p>등록된 동아리가 없습니다.<br>새 동아리를 등록해보세요!</p>';
                clubGrid.appendChild(empty);
            }
        }
    </script>
</body>

</html>