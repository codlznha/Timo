<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>티모(Timo) - 공식 동아리</title>
        <!-- 아이콘 폰트는 sidebar.jsp에서 자체적으로 불러오므로 여기서는 생략 -->
        <!-- 기존 외부 CSS 정상 호출 (합치지 않음) -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
        <style>
            /* 공식 동아리 개설 신청 카드 전용 스타일 */
            .club-card.add-club-card {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                text-align: center;
                border: 2px dashed #b9c2d8;
                background-color: #f7f9fc;
                color: var(--primary-blue, #005baa);
                min-height: 100%;
            }

            .club-card.add-club-card:hover {
                border-color: var(--primary-blue, #005baa);
                background-color: #eef3fb;
            }

            .add-club-card .add-icon {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: var(--primary-blue, #005baa);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.3rem;
                margin-bottom: 12px;
            }

            .add-club-card .club-name {
                color: var(--primary-blue, #005baa);
            }

            .add-club-card .club-desc {
                color: #6b7690;
            }
        </style>
    </head>

    <body>

        <!-- 🔥 분리된 사이드바를 여기서 불러옵니다. (main.jsp와 동일) 🔥 -->
        <%@ include file="/views/common/sidebar.jsp" %>

            <!-- 메인 컨텐츠 영역 -->
            <div class="main-wrapper" id="mainWrapper">

                <!-- 탑 헤더 -->
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

                <div class="content-container">

                    <!-- 내가 가입한 동아리 -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa-solid fa-star" style="color: #f1c40f;"></i> 내가 가입한 동아리
                        </div>
                        <div class="my-clubs-wrap">
                            <div class="my-club" onclick="location.href='${pageContext.request.contextPath}/club/detail?id=1'">
                                <div class="club-logo"><i class="fa-solid fa-code"></i></div>
                                <div class="club-info">
                                    <h4>웹개발 Timo</h4>
                                    <p>85명 활동중</p>
                                </div>
                            </div>
                            <div class="my-club" onclick="location.href='${pageContext.request.contextPath}/club/detail?id=2'">
                                <div class="club-logo"><i class="fa-solid fa-robot"></i></div>
                                <div class="club-info">
                                    <h4>ROBOTIS</h4>
                                    <p>42명 활동중</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 전체 동아리 및 필터 -->
                    <div class="section-card">
                        <div class="section-title"><i class="fa-solid fa-list" style="color: var(--primary-blue);"></i>
                            전체 공식 동아리</div>

                        <div class="toolbar-wrapper">
                            <div class="tags">
                                <div class="tag active" data-tag="all">전체</div>
                                <div class="tag" data-tag="IT">IT/개발</div>
                                <div class="tag" data-tag="운동">스포츠</div>
                                <div class="tag" data-tag="예술">문화/예술</div>
                                <div class="tag" data-tag="봉사">봉사</div>
                            </div>

                            <div class="controls">
                                <div class="search-box-local">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                    <input id="search" type="text" placeholder="동아리 검색...">
                                </div>
                                <select id="sort">
                                    <option value="asc">가나다순</option>
                                    <option value="desc">역순</option>
                                </select>
                            </div>
                        </div>

                        <div class="club-grid" id="clubGrid">

                            <div class="club-card" data-name="웹개발연합회" data-tag="IT"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?id=1'">
                                <div class="card-header">
                                    <div class="club-logo"><i class="fa-solid fa-code"></i></div>
                                    <span class="badge">IT/개발</span>
                                </div>
                                <div class="club-name">웹개발연합회</div>
                                <div class="club-desc">프론트엔드부터 백엔드까지, 웹/앱 프로젝트를 함께 기획하고 개발합니다.</div>
                                <div class="card-footer">
                                    <span class="member-count"><i class="fa-solid fa-user"></i> 85명</span>
                                </div>
                            </div>

                            <div class="club-card" data-name="로보티즈" data-tag="IT"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?id=2'">
                                <div class="card-header">
                                    <div class="club-logo"><i class="fa-solid fa-robot"></i></div>
                                    <span class="badge">IT/개발</span>
                                </div>
                                <div class="club-name">ROBOTIS</div>
                                <div class="club-desc">자율주행 및 임베디드 로봇 제어 시스템 연구 동아리입니다.</div>
                                <div class="card-footer">
                                    <span class="member-count"><i class="fa-solid fa-user"></i> 42명</span>
                                </div>
                            </div>

                            <div class="club-card" data-name="바스켓볼 크루" data-tag="운동"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?id=3'">
                                <div class="card-header">
                                    <div class="club-logo"><i class="fa-solid fa-basketball"></i></div>
                                    <span class="badge">스포츠</span>
                                </div>
                                <div class="club-name">바스켓볼 크루</div>
                                <div class="club-desc">매주 교내 체육관에서 농구 활동 및 타 대학과의 정기 교류전을 진행합니다.</div>
                                <div class="card-footer">
                                    <span class="member-count"><i class="fa-solid fa-user"></i> 43명</span>
                                </div>
                            </div>

                            <div class="club-card" data-name="포토그래피" data-tag="예술"
                                onclick="location.href='${pageContext.request.contextPath}/club/detail?id=4'">
                                <div class="card-header">
                                    <div class="club-logo"><i class="fa-solid fa-camera-retro"></i></div>
                                    <span class="badge">문화/예술</span>
                                </div>
                                <div class="club-name">포토그래피</div>
                                <div class="club-desc">주말 정기 출사와 필름 카메라 인화 스터디, 연말 사진전을 엽니다.</div>
                                <div class="card-footer">
                                    <span class="member-count"><i class="fa-solid fa-user"></i> 27명</span>
                                </div>
                            </div>

                            <!-- 공식 동아리 개설 신청 카드 -->
                            <div class="club-card add-club-card" data-name="공식 동아리 개설 신청" data-tag="all"
                                onclick="location.href='${pageContext.request.contextPath}/club/add'">
                                <div class="add-icon"><i class="fa-solid fa-plus"></i></div>
                                <div class="club-name">공식 동아리 개설 신청</div>
                                <div class="club-desc">만들고 싶은 동아리가 있나요? 신청서를 작성해보세요.</div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

            <!-- 스크립트 영역 (기존 기능 유지) -->
            <script>
                // toggleSidebar() 함수는 sidebar.jsp로 이동되었습니다.

                // 검색 및 필터 로직
                const search = document.getElementById("search");
                const sort = document.getElementById("sort");
                const grid = document.getElementById("clubGrid");
                const tags = document.querySelectorAll(".tag");
                let current = "all";

                function render() {
                    let cards = [...grid.children];
                    cards.forEach(c => {
                        // '공식 동아리 개설 신청' 카드는 검색/필터와 무관하게 항상 노출
                        if (c.classList.contains("add-club-card")) {
                            c.style.display = "flex";
                            return;
                        }
                        const okName = c.dataset.name.toLowerCase().includes(search.value.toLowerCase());
                        const okTag = current === "all" || c.dataset.tag === current;
                        c.style.display = (okName && okTag) ? "flex" : "none";
                    });
                    cards.sort((a, b) => {
                        // 신청 카드는 항상 맨 뒤에 위치
                        if (a.classList.contains("add-club-card")) return 1;
                        if (b.classList.contains("add-club-card")) return -1;
                        return sort.value === "asc" ?
                            a.dataset.name.localeCompare(b.dataset.name, "ko") :
                            b.dataset.name.localeCompare(a.dataset.name, "ko");
                    });
                    cards.forEach(c => grid.appendChild(c));
                }

                search.addEventListener('keyup', render);
                sort.addEventListener('change', render);

                tags.forEach(t => {
                    t.onclick = () => {
                        tags.forEach(x => x.classList.remove("active"));
                        t.classList.add("active");
                        current = t.dataset.tag;
                        render();
                    }
                });
            </script>
    </body>

    </html>
