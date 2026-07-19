<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 동아리 개설 신청 승인</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/components.css">
    <style>
        /* 승인 페이지 전용 레이아웃 */
        .check-layout {
            display: grid;
            grid-template-columns: 340px 1fr;
            gap: 20px;
            align-items: start;
        }

        @media (max-width: 900px) {
            .check-layout {
                grid-template-columns: 1fr;
            }
        }

        .apply-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-height: 75vh;
            overflow-y: auto;
            padding-right: 4px;
        }

        .apply-item {
            border: 1px solid #e5e9f2;
            border-radius: 10px;
            padding: 14px 16px;
            cursor: pointer;
            transition: 0.2s;
            background-color: #fff;
        }

        .apply-item:hover {
            border-color: var(--primary-blue, #005baa);
        }

        .apply-item.active {
            border-color: var(--primary-blue, #005baa);
            background-color: #eef4fb;
        }

        .apply-item-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 6px;
        }

        .apply-item-name {
            font-weight: bold;
            color: #2a2f45;
        }

        .apply-item-sub {
            font-size: 0.82rem;
            color: #8a96b8;
        }

        .status-badge {
            font-size: 0.75rem;
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 20px;
        }

        .status-pending {
            background-color: #fff4d6;
            color: #b8860b;
        }

        .status-approved {
            background-color: #dcf5e3;
            color: #1e8e4a;
        }

        .status-rejected {
            background-color: #fbe1e1;
            color: #c0392b;
        }

        .detail-panel {
            border: 1px solid #e5e9f2;
            border-radius: 10px;
            padding: 30px;
            background-color: #fff;
            min-height: 400px;
        }

        .detail-empty {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 400px;
            color: #b3bacf;
            gap: 10px;
        }

        .detail-empty i {
            font-size: 2.4rem;
        }

        .detail-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid #eef1f7;
            padding-bottom: 18px;
            margin-bottom: 20px;
        }

        .detail-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #2a2f45;
            margin-bottom: 6px;
        }

        .detail-meta {
            color: #8a96b8;
            font-size: 0.9rem;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px 24px;
            margin-bottom: 24px;
        }

        .detail-field-label {
            font-size: 0.8rem;
            color: #8a96b8;
            font-weight: bold;
            margin-bottom: 4px;
        }

        .detail-field-value {
            color: #2a2f45;
            font-size: 0.95rem;
        }

        .detail-block {
            margin-bottom: 22px;
        }

        .detail-block-title {
            font-weight: bold;
            color: #2a2f45;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-block-content {
            color: #4a5170;
            line-height: 1.6;
            font-size: 0.92rem;
            background-color: #f8f9fc;
            border-radius: 8px;
            padding: 14px 16px;
            white-space: pre-line;
        }

        .detail-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            border-top: 1px solid #eef1f7;
            padding-top: 20px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: bold;
            cursor: pointer;
            border: none;
            transition: 0.2s;
        }

        .btn-approve {
            background-color: #1e8e4a;
            color: #fff;
        }

        .btn-approve:hover {
            background-color: #167339;
        }

        .btn-reject {
            background-color: #c0392b;
            color: #fff;
        }

        .btn-reject:hover {
            background-color: #a1301f;
        }

        .btn:disabled {
            background-color: #d8dee9;
            color: #9aa3b8;
            cursor: not-allowed;
        }
    </style>
</head>

<body>

    <%@ include file="common/admin_sidebar.jsp" %>

    <div class="main-wrapper" id="mainWrapper">

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

        <div class="page-header">
            <h1>동아리 개설 신청 승인</h1>
            <p>학생들이 제출한 공식 동아리 개설 신청서를 확인하고 승인 또는 거부를 결정합니다.</p>
        </div>

        <div class="content-container">
            <div class="section-card">
                <div class="section-title"><i class="fa-solid fa-clipboard-check" style="color: var(--primary-blue);"></i>
                    신청 목록 및 검토</div>

                <div class="check-layout">
                    <!-- 신청 목록 -->
                    <div class="apply-list" id="applyList"></div>

                    <!-- 상세 정보 패널 -->
                    <div class="detail-panel" id="detailPanel">
                        <div class="detail-empty">
                            <i class="fa-solid fa-hand-pointer"></i>
                            왼쪽 목록에서 신청서를 선택하세요.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 실제 서비스에서는 서버에서 신청 목록을 조회해와야 합니다. (예시 목데이터)
        let applications = [
            {
                id: 1,
                clubName: "보드게임 연구회",
                category: "문화/예술",
                leaderName: "김민수",
                leaderContact: "010-1234-5678",
                expectedMembers: 12,
                appliedDate: "2026-07-10",
                desc: "다양한 보드게임을 함께 즐기고, 자체 제작 게임을 기획/개발하는 동아리입니다.",
                plan: "매주 금요일 정기 모임 진행\n학기 말 자체 보드게임 프로토타입 제작 및 시연회 개최",
                status: "pending"
            },
            {
                id: 2,
                clubName: "창업 스터디",
                category: "IT/개발",
                leaderName: "박지훈",
                leaderContact: "010-2345-6789",
                expectedMembers: 8,
                appliedDate: "2026-07-12",
                desc: "예비 창업자들이 모여 아이디어를 발전시키고 창업 역량을 기르는 동아리입니다.",
                plan: "격주 세미나 및 외부 강사 초청 특강\n학기 말 IR 피칭 데이 진행",
                status: "pending"
            },
            {
                id: 3,
                clubName: "필름사진 동호회",
                category: "문화/예술",
                leaderName: "이서연",
                leaderContact: "010-3456-7890",
                expectedMembers: 15,
                appliedDate: "2026-07-14",
                desc: "필름 카메라로 사진을 찍고 직접 암실에서 인화하는 활동을 하는 동아리입니다.",
                plan: "월 2회 출사 활동\n학기 말 소규모 전시회 진행",
                status: "approved"
            }
        ];

        let selectedId = null;

        const statusInfo = {
            pending: { label: "대기중", cls: "status-pending" },
            approved: { label: "승인완료", cls: "status-approved" },
            rejected: { label: "거부됨", cls: "status-rejected" }
        };

        function renderList() {
            const listEl = document.getElementById('applyList');
            listEl.innerHTML = '';

            applications.forEach(app => {
                const s = statusInfo[app.status];
                const item = document.createElement('div');
                item.className = 'apply-item' + (app.id === selectedId ? ' active' : '');
                item.onclick = () => selectApplication(app.id);
                item.innerHTML = `
                    <div class="apply-item-top">
                        <span class="apply-item-name">${app.clubName}</span>
                        <span class="status-badge ${s.cls}">${s.label}</span>
                    </div>
                    <div class="apply-item-sub">${app.category} · 대표자 ${app.leaderName} · ${app.appliedDate}</div>
                `;
                listEl.appendChild(item);
            });
        }

        function selectApplication(id) {
            selectedId = id;
            renderList();
            renderDetail();
        }

        function renderDetail() {
            const panel = document.getElementById('detailPanel');
            const app = applications.find(a => a.id === selectedId);

            if (!app) {
                panel.innerHTML = `
                    <div class="detail-empty">
                        <i class="fa-solid fa-hand-pointer"></i>
                        왼쪽 목록에서 신청서를 선택하세요.
                    </div>`;
                return;
            }

            const s = statusInfo[app.status];
            const isPending = app.status === 'pending';

            panel.innerHTML = `
                <div class="detail-header">
                    <div>
                        <div class="detail-title">${app.clubName}</div>
                        <div class="detail-meta">신청일 ${app.appliedDate}</div>
                    </div>
                    <span class="status-badge ${s.cls}">${s.label}</span>
                </div>

                <div class="detail-grid">
                    <div>
                        <div class="detail-field-label">활동 분야</div>
                        <div class="detail-field-value">${app.category}</div>
                    </div>
                    <div>
                        <div class="detail-field-label">예상 초기 인원</div>
                        <div class="detail-field-value">${app.expectedMembers}명</div>
                    </div>
                    <div>
                        <div class="detail-field-label">대표자</div>
                        <div class="detail-field-value">${app.leaderName}</div>
                    </div>
                    <div>
                        <div class="detail-field-label">대표자 연락처</div>
                        <div class="detail-field-value">${app.leaderContact}</div>
                    </div>
                </div>

                <div class="detail-block">
                    <div class="detail-block-title"><i class="fa-solid fa-align-left" style="color: var(--primary-blue);"></i> 동아리 소개</div>
                    <div class="detail-block-content">${app.desc}</div>
                </div>

                <div class="detail-block">
                    <div class="detail-block-title"><i class="fa-solid fa-calendar-check" style="color: var(--primary-blue);"></i> 활동 계획</div>
                    <div class="detail-block-content">${app.plan}</div>
                </div>

                <div class="detail-actions">
                    <button class="btn btn-reject" ${isPending ? '' : 'disabled'} onclick="decideApplication(${app.id}, 'rejected')">
                        <i class="fa-solid fa-xmark"></i> 거부
                    </button>
                    <button class="btn btn-approve" ${isPending ? '' : 'disabled'} onclick="decideApplication(${app.id}, 'approved')">
                        <i class="fa-solid fa-check"></i> 승인
                    </button>
                </div>
            `;
        }

        function decideApplication(id, decision) {
            const app = applications.find(a => a.id === id);
            if (!app) return;

            const label = decision === 'approved' ? '승인' : '거부';
            if (!confirm(`'${app.clubName}' 신청을 ${label} 처리하시겠습니까?`)) return;

            // 실제 서비스에서는 이 부분에서 서버로 승인/거부 결과를 전송합니다.
            app.status = decision;
            renderList();
            renderDetail();
        }

        renderList();
    </script>

</body>

</html>
