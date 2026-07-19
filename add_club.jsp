<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>티모(Timo) - 공식 동아리 개설 신청</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/layout.css">
    <link rel="stylesheet" href="css/components.css">
    <style>
        /* 신청서 폼 전용 스타일 */
        .apply-form .form-row {
            margin-bottom: 22px;
        }

        .apply-form label {
            display: block;
            font-weight: bold;
            font-size: 0.95rem;
            color: #2a2f45;
            margin-bottom: 8px;
        }

        .apply-form label .required {
            color: #e74c3c;
            margin-left: 3px;
        }

        .apply-form input[type="text"],
        .apply-form input[type="number"],
        .apply-form select,
        .apply-form textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 12px 14px;
            border: 1px solid #d8dee9;
            border-radius: 8px;
            font-size: 0.95rem;
            font-family: inherit;
            color: #2a2f45;
            transition: 0.2s;
        }

        .apply-form input:focus,
        .apply-form select:focus,
        .apply-form textarea:focus {
            outline: none;
            border-color: var(--primary-blue, #005baa);
            box-shadow: 0 0 0 3px rgba(0, 91, 170, 0.12);
        }

        .apply-form textarea {
            resize: vertical;
            min-height: 110px;
            line-height: 1.5;
        }

        .form-row-split {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-hint {
            font-size: 0.82rem;
            color: #8a96b8;
            margin-top: 6px;
        }

        .file-drop {
            border: 2px dashed #d8dee9;
            border-radius: 8px;
            padding: 24px;
            text-align: center;
            color: #8a96b8;
            cursor: pointer;
            transition: 0.2s;
        }

        .file-drop:hover {
            border-color: var(--primary-blue, #005baa);
            color: var(--primary-blue, #005baa);
        }

        .file-drop i {
            font-size: 1.6rem;
            display: block;
            margin-bottom: 8px;
        }

        #fileNameDisplay {
            margin-top: 8px;
            font-size: 0.88rem;
            color: #2a2f45;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 30px;
            border-top: 1px solid #eef1f7;
            padding-top: 20px;
        }

        .btn {
            padding: 12px 26px;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: bold;
            cursor: pointer;
            border: none;
            transition: 0.2s;
        }

        .btn-cancel {
            background-color: #f1f3f8;
            color: #5a637d;
        }

        .btn-cancel:hover {
            background-color: #e5e8f0;
        }

        .btn-submit {
            background-color: var(--primary-blue, #005baa);
            color: #fff;
        }

        .btn-submit:hover {
            background-color: #004a8c;
        }
    </style>
</head>

<body>

    <%@ include file="common/sidebar.jsp" %>

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
            <h1>공식 동아리 개설 신청</h1>
            <p>새로운 공식 동아리를 만들고 싶다면 아래 신청서를 작성해주세요. 담당자 검토 후 승인 여부가 결정됩니다.</p>
        </div>

        <div class="content-container">
            <div class="section-card">
                <div class="section-title"><i class="fa-solid fa-file-signature" style="color: var(--primary-blue);"></i>
                    동아리 개설 신청서</div>

                <form class="apply-form" id="addClubForm" onsubmit="return submitClubForm(event)">

                    <div class="form-row form-row-split">
                        <div>
                            <label for="clubName">동아리명 <span class="required">*</span></label>
                            <input type="text" id="clubName" name="clubName" placeholder="예) 보드게임 연구회" required>
                        </div>
                        <div>
                            <label for="clubCategory">활동 분야 <span class="required">*</span></label>
                            <select id="clubCategory" name="clubCategory" required>
                                <option value="">분야를 선택하세요</option>
                                <option value="IT">IT/개발</option>
                                <option value="운동">스포츠</option>
                                <option value="예술">문화/예술</option>
                                <option value="봉사">봉사</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row form-row-split">
                        <div>
                            <label for="leaderName">대표자 이름 <span class="required">*</span></label>
                            <input type="text" id="leaderName" name="leaderName" placeholder="예) 이한국" required>
                        </div>
                        <div>
                            <label for="leaderContact">대표자 연락처 <span class="required">*</span></label>
                            <input type="text" id="leaderContact" name="leaderContact" placeholder="예) 010-1234-5678" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <label for="expectedMembers">예상 초기 인원 <span class="required">*</span></label>
                        <input type="number" id="expectedMembers" name="expectedMembers" min="1" placeholder="예) 10" required>
                        <div class="form-hint">공식 동아리 등록을 위한 최소 인원 기준은 별도 안내를 참고해주세요.</div>
                    </div>

                    <div class="form-row">
                        <label for="clubDesc">동아리 소개 <span class="required">*</span></label>
                        <textarea id="clubDesc" name="clubDesc" placeholder="어떤 활동을 하는 동아리인지 소개해주세요." required></textarea>
                    </div>

                    <div class="form-row">
                        <label for="activityPlan">활동 계획 <span class="required">*</span></label>
                        <textarea id="activityPlan" name="activityPlan" placeholder="정기 모임 주기, 학기별 주요 활동 계획 등을 작성해주세요." required></textarea>
                    </div>

                    <div class="form-row">
                        <label for="planFile">활동 계획서 첨부 (선택)</label>
                        <div class="file-drop" onclick="document.getElementById('planFile').click()">
                            <i class="fa-solid fa-file-arrow-up"></i>
                            클릭하여 파일을 첨부하세요 (PDF, HWP, DOCX)
                        </div>
                        <input type="file" id="planFile" name="planFile" style="display:none" accept=".pdf,.hwp,.doc,.docx">
                        <div id="fileNameDisplay"></div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-cancel" onclick="location.href='club_main.jsp'">취소</button>
                        <button type="submit" class="btn btn-submit"><i class="fa-solid fa-paper-plane"></i> 신청서 제출</button>
                    </div>

                </form>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('planFile').addEventListener('change', function () {
            const display = document.getElementById('fileNameDisplay');
            if (this.files.length > 0) {
                display.textContent = '선택된 파일: ' + this.files[0].name;
            } else {
                display.textContent = '';
            }
        });

        function submitClubForm(e) {
            e.preventDefault();

            // 실제 서비스에서는 이 부분에서 서버(add_club_process 등)로 데이터를 전송합니다.
            alert('동아리 개설 신청이 접수되었습니다.\n담당자 검토 후 승인 결과를 안내해드립니다.');
            location.href = 'club_main.jsp';
            return false;
        }
    </script>

</body>

</html>
