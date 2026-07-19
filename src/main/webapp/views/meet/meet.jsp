<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>티모 - 프로토타입</title>
  <style>
    /* 기본 스타일 리셋 */
    * { 
      box-sizing: border-box; 
      margin: 0; 
      padding: 0; 
      font-family: sans-serif; 
    }
    body { 
      background-color: #f5f5f5; 
      padding: 20px 20px 80px 20px; 
      color: #333; 
    }
    
    /* 상단 헤더 */
    header { 
      display: flex; 
      align-items: center; 
      background: #222; 
      color: #fff;
      padding: 12px 20px; 
      border-radius: 8px; /* 헤더 모서리 둥글기 살짝 조정 */
      margin-bottom: 20px; 
      box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
      gap: 15px; /* 로고, 공지, 아이콘 사이의 간격 고정 */
    }
    
    /* 좌측 로고 */
    .logo { 
      font-size: 20px; 
      font-weight: bold; 
      white-space: nowrap; 
    }
    
    /* 실시간 전체 공지방 */
    .live-notice-ticker {
      flex-grow: 1; /* 남은 중간 영역 모두 차지 */
      background: #333; /* 이미지와 동일한 어두운 배경 */
      padding: 8px 12px;
      border-radius: 6px; /* 둥근 캡슐형에서 살짝 각진 형태로 변경 */
      font-size: 14px;
      color: #00ff66; /* 텍스트 색상 유지 */
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      text-align: left; /* 왼쪽 정렬 */
      display: flex;
      align-items: center;
    }

    /* 우측 상단 알림 및 예약 아이콘 영역 */
    .header-icons {
      display: flex;
      align-items: center;
      gap: 15px;
      font-size: 20px;
      white-space: nowrap;
    }
    .header-icons span { 
      cursor: pointer; 
      transition: transform 0.2s; 
    }
    .header-icons span:hover { 
      transform: scale(1.1); 
    }

    /* 상단 카테고리 탭 */
    .category-container { 
      display: flex; 
      gap: 15px; 
      background: #fff; 
      padding: 15px; 
      border-radius: 10px; 
      margin-bottom: 15px; 
      overflow-x: auto; 
    }
    .category-tab { 
      display: flex; 
      flex-direction: column; 
      align-items: center; 
      cursor: pointer; 
      min-width: 60px; 
    }
    .category-icon { 
      width: 45px; 
      height: 45px; 
      background: #eee; 
      border-radius: 50%; 
      display: flex; 
      align-items: center; 
      justify-content: center; 
      margin-bottom: 5px; 
      font-size: 20px; 
    }
    .category-tab span { 
      font-size: 13px; 
    }

    /* 필터 및 검색 라인 */
    .filter-container { 
      display: flex; 
      justify-content: space-between; 
      align-items: center; 
      margin-bottom: 15px; 
      gap: 15px; 
    }
    .search-input {
      flex-grow: 1; 
      padding: 10px 15px;
      font-size: 14px;
      border-radius: 6px;
      border: 1px solid #ccc;
      outline: none;
    }
    .search-input:focus { 
      border-color: #007BFF; 
    }
    .sort-select { 
      padding: 10px 12px; 
      font-size: 14px; 
      border-radius: 6px; 
      border: 1px solid #ccc; 
      background-color: #fff; 
      cursor: pointer; 
      outline: none; 
    }

    /* 상품형 Grid UI */
    .grid-container { 
      display: grid;
      grid-template-columns: repeat(5, minmax(0, 1fr)); 
      gap: 15px; 
      padding-bottom: 20px;
    }

    /* 모임 카드 스타일 */
    .meeting-card { 
      background: #fff; 
      border-radius: 12px; 
      overflow: hidden; 
      box-shadow: 0 4px 6px rgba(0,0,0,0.07);
      cursor: pointer;
      transition: transform 0.2s;
      display: flex;
      flex-direction: column;
    }
    .meeting-card:hover { 
      transform: translateY(-5px); 
    }
    .card-img { 
      width: 100%; 
      height: 130px; 
      background: #ddd; 
      display: flex; 
      align-items: center; 
      justify-content: center; 
      color: #777; 
      font-size: 14px; 
    }
    .card-content { 
      padding: 15px; 
      flex-grow: 1; 
      display: flex; 
      flex-direction: column; 
      justify-content: space-between; 
    }
    .card-title { 
      font-size: 15px; 
      font-weight: bold; 
      margin-bottom: 10px; 
      height: 40px; 
      overflow: hidden; 
    }
    .card-info-row { 
      display: flex; 
      justify-content: space-between; 
      font-size: 13px; 
      color: #555; 
      margin-bottom: 8px; 
    }
    .card-item { 
      font-size: 13px; 
      color: #777; 
      background: #f0f0f0; 
      padding: 4px 8px; 
      border-radius: 4px; 
      display: inline-block; 
      width: fit-content; 
    }

    /* 상세 화면 & 채팅방 */
    .view-section { 
      display: none; 
      background: #fff; 
      padding: 20px; 
      border-radius: 12px; 
      margin-top: 20px; 
      box-shadow: 0 4px 10px rgba(0,0,0,0.1); 
      margin-bottom: 30px;
    }
    .view-section.active { 
      display: block; 
    }
    
    .detail-header { 
      display: flex; 
      justify-content: space-between; 
      align-items: center; 
      margin-bottom: 15px; 
    }
    .mock-map { 
      width: 100%; 
      height: 200px; 
      background: #e0ebd3; 
      border: 2px dashed #999; 
      display: flex; 
      align-items: center; 
      justify-content: center; 
      margin: 15px 0; 
      border-radius: 8px; 
    }
    .detail-desc { 
      background: #f9f9f9; 
      padding: 15px; 
      border-radius: 8px; 
      border-left: 4px solid #333; 
      margin-bottom: 20px; 
    }
    
    .join-btn { 
      width: 100%; 
      padding: 12px; 
      background: #007BFF; 
      color: white; 
      border: none; 
      border-radius: 6px; 
      font-size: 16px; 
      font-weight: bold; 
      cursor: pointer; 
    }
    .join-btn.cancel { 
      background: #DC3545; 
    }

    .chat-box { 
      border: 1px solid #ddd; 
      height: 200px; 
      overflow-y: auto; 
      padding: 10px; 
      background: #fafafa; 
      margin-top: 15px; 
      border-radius: 6px; 
    }
    .chat-msg { 
      margin-bottom: 10px; 
      font-size: 14px; 
    }
    .chat-msg.system { 
      color: blue; 
      font-style: italic; 
    }

    /* 하단 고정 메뉴 바 */
    .bottom-nav {
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      height: 65px;
      background: #ffffff;
      display: flex;
      justify-content: space-around;
      align-items: center;
      box-shadow: 0 -3px 10px rgba(0,0,0,0.1);
      z-index: 1000;
    }
    .nav-item {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      color: #888;
      cursor: pointer;
      text-decoration: none;
      width: 20%;
      height: 100%;
    }
    .nav-item .nav-icon { 
      font-size: 20px; 
      margin-bottom: 2px; 
    }
    .nav-item.active { 
      color: #007BFF; 
      font-weight: bold; 
    }
    .nav-item.plus-btn .nav-icon { 
      font-size: 28px; 
      color: #333; 
    }

    /* 공통 폼 & 모달 스타일 (통합됨) */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      align-items: center;
      justify-content: center;
      z-index: 2000;
    }
    .modal-content {
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      width: 90%;
      max-width: 400px;
      max-height: 90vh; /* 모달 내용이 길어질 경우를 대비해 최대 높이 지정 */
      overflow-y: auto; /* 내용이 넘칠 경우 스크롤 생성 */
    }
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }
    .form-group { 
      margin-bottom: 15px; 
    }
    .form-group label { 
      display: block; 
      font-size: 13px; 
      font-weight: bold; 
      margin-bottom: 5px; 
      color: #555; 
    }
    .form-input { 
      width: 100%; 
      padding: 10px; 
      border: 1px solid #ddd; 
      border-radius: 6px; 
      font-size: 14px; 
    }
    .btn-submit { 
      width: 100%; 
      padding: 12px; 
      background: #28a745; 
      color: white; 
      border: none; 
      border-radius: 8px; 
      cursor: pointer; 
      font-weight: bold; 
      margin-top: 10px;
    }
    .close-btn { 
      background: none; 
      border: none; 
      font-size: 20px; 
      cursor: pointer; 
    }

    /* 반응형 */
    @media (max-width: 1000px) { 
      .grid-container { grid-template-columns: repeat(3, minmax(0, 1fr)); } 
    }
    @media (max-width: 600px) { 
      .grid-container { grid-template-columns: repeat(1, minmax(0, 1fr)); } 
    }
  </style>
</head>
<body>

  <!-- 상단 헤더 -->
  <header>
    <!-- 1. 좌측: 로고 -->
    <div class="logo">티모</div>
    
    <!-- 2. 중앙: 전체 공지 -->
    <div class="live-notice-ticker" id="noticeTicker">
      📢 [전체 공지] 익명3: "정문 앞 대리석 의자 쪽 택시 타실 분 급구!!"
    </div>

    <!-- 3. 우측: 알림, 예약 아이콘 -->
    <div class="header-icons">
      <span title="알림" onclick="alert('알림 내역을 엽니다.')">🔔</span>
      <span title="예약" onclick="alert('내 예약 목록을 엽니다.')">📅</span>
    </div>
  </header>

  <!-- 상단 카테고리 탭 -->
  <div class="category-container">
    <div class="category-tab" onclick="alert('식사 필터')">
      <div class="category-icon">🍔</div>
      <span>식사</span>
    </div>
    <div class="category-tab" onclick="alert('게임 필터')">
      <div class="category-icon">🎮</div>
      <span>게임</span>
    </div>
    <div class="category-tab" onclick="alert('공부 필터')">
      <div class="category-icon">📚</div>
      <span>공부</span>
    </div>
    <div class="category-tab" onclick="alert('택시 필터')">
      <div class="category-icon">🚕</div>
      <span>택시</span>
    </div>
    <div class="category-tab" onclick="alert('운동 필터')">
      <div class="category-icon">🏀</div>
      <span>운동</span>
    </div>
    <div class="category-tab" onclick="alert('기타 필터')">
      <div class="category-icon">📌</div>
      <span>기타</span>
    </div>
  </div>

  <!-- 검색 UI + 정렬 조건 Select 박스 -->
  <div class="filter-container">
    <input type="text" class="search-input" placeholder="원하는 모임을 검색해보세요...">
    <select class="sort-select" onchange="alert(this.value + ' 정렬 적용 (뼈대)')">
      <option value="최신순">최신순</option>
      <option value="오래된순">오래된순</option>
      <option value="인원많은순">모임 인원 많은순</option>
      <option value="인원적은순">모임 인원 적은순</option>
      <option value="시간많이남은순">시간 많이 남은 순</option>
      <option value="시간안남은순">시간 안 남은 순</option>
    </select>
  </div>

  <!-- 상품형 Grid UI -->
  <div class="grid-container">
    <!-- 1줄 -->
    <div class="meeting-card" onclick="openDetail('정문 앞 점심 식사', '[식사]', '2/4', '11:00 ~ 12:00', '지갑')">
      <div class="card-img">🍲 식사</div>
      <div class="card-content">
        <div class="card-title">[식사] 정문 앞 점심 식사 파티</div>
        <div class="card-info-row">
          <span>👥 2/4</span>
          <span>⏰ 11:00~12:00</span>
        </div>
        <div class="card-item">준비물: 지갑</div>
      </div>
    </div>

    <div class="meeting-card" onclick="openDetail('PC방 5인큐 롤 하실분', '[게임]', '2/4', '13:00 ~ 14:30', '피시방비')">
      <div class="card-img">🎮 게임</div>
      <div class="card-content">
        <div class="card-title">[게임] PC방 5인큐, 지금 당장!</div>
        <div class="card-info-row">
          <span>👥 2/4</span>
          <span>⏰ 13:00~14:30</span>
        </div>
        <div class="card-item">준비물: 피시방비</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[공부] 카페 카공족 모집</div>
        <div class="card-info-row">
          <span>👥 2/4</span>
          <span>⏰ 14:00~16:00</span>
        </div>
        <div class="card-item">준비물: 노트북</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[택시] 하교 버스 놓쳐서 카풀</div>
        <div class="card-info-row">
          <span>👥 1/3</span>
          <span>⏰ 16:00~17:00</span>
        </div>
        <div class="card-item">준비물: 3000원</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[운동] 농구 한 판 할 사람</div>
        <div class="card-info-row">
          <span>👥 3/5</span>
          <span>⏰ 18:00~20:00</span>
        </div>
        <div class="card-item">준비물: 운동화</div>
      </div>
    </div>

    <!-- 2줄 -->
    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[식사] 치킨 번개 달립니다</div>
        <div class="card-info-row">
          <span>👥 1/2</span>
          <span>⏰ 19:00~20:30</span>
        </div>
        <div class="card-item">준비물: 공짜</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[공부] 도서관 메이트 구함</div>
        <div class="card-info-row">
          <span>👥 1/2</span>
          <span>⏰ 10:00~12:00</span>
        </div>
        <div class="card-item">준비물: 책</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[택시] 공항 택시 동승</div>
        <div class="card-info-row">
          <span>👥 1/4</span>
          <span>⏰ 06:00~08:00</span>
        </div>
        <div class="card-item">준비물: 1만원</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[식사] 마라탕 파티원 고</div>
        <div class="card-info-row">
          <span>👥 3/4</span>
          <span>⏰ 12:00~13:00</span>
        </div>
        <div class="card-item">준비물: 입맛</div>
      </div>
    </div>

    <div class="meeting-card">
      <div class="card-img">📦 모임 박스</div>
      <div class="card-content">
        <div class="card-title">[기타] 보드게임 하실 분</div>
        <div class="card-info-row">
          <span>👥 2/4</span>
          <span>⏰ 20:00~22:00</span>
        </div>
        <div class="card-item">준비물: 없음</div>
      </div>
    </div>
  </div>

  <!-- 상세 화면 섹션 -->
  <div id="detailSection" class="view-section">
    <div class="detail-header">
      <h2 id="detailTitle">[카테고리] 모임 목적 제목</h2>
      <button onclick="closeDetail()" style="padding:5px; cursor:pointer;">닫기 X</button>
    </div>
    
    <p><strong>모집 인원:</strong> <span id="detailPeople">0/0</span></p>
    <p><strong>모집 시간:</strong> <span id="detailTime">00:00 ~ 00:00</span></p>
    <p style="margin-bottom: 10px;"><strong>준비물:</strong> <span id="detailMaterial">없음</span></p>

    <div class="mock-map">📍 지도의 위치 정보 표시 영역</div>

    <div class="detail-desc">
      <h3>상세 내용</h3>
      <p>모임 세부 설명 영역입니다.</p>
    </div>

    <button id="joinBtn" class="join-btn" onclick="toggleJoin()">참여하기</button>

    <div id="chatSection" style="display: none; margin-top: 25px; border-top: 2px solid #eee; padding-top: 15px;">
      <h3>💬 모임 전용 채팅방 (자동 참여됨)</h3>
      <div class="chat-box">
        <div class="chat-msg system">[시스템] 모임에 참여하셨습니다.</div>
        <div class="chat-msg"><b>익명1:</b> 안녕하세요!</div>
      </div>
    </div>
  </div>

  <!-- 새 모임 만들기 모달 -->
  <div id="createMeetingModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
      <div class="modal-header">
        <h2>새 모임 만들기</h2>
        <button class="close-btn" onclick="closeCreateModal()">&times;</button>
      </div>
      
      <div class="form-group">
        <label>카테고리</label>
        <select class="form-input">
          <option>🍔 식사</option>
          <option>🎮 게임</option>
          <option>📚 공부</option>
          <option>🚕 택시</option>
          <option>🏀 운동</option>
          <option>📌 기타</option>
        </select>
      </div>

      <div class="form-group">
        <label>모임 제목</label>
        <input type="text" class="form-input" placeholder="모임 제목을 입력하세요">
      </div>

      <div class="form-group">
        <label>모집 인원 (예: 4)</label>
        <input type="number" class="form-input" placeholder="숫자만 입력">
      </div>

      <div class="form-group">
        <label>모임 시간</label>
        <input type="time" class="form-input">
      </div>

      <!-- 추가된 준비물 항목 -->
      <div class="form-group">
        <label>준비물</label>
        <input type="text" class="form-input" placeholder="예: 지갑, 신분증, 노트북 등 (없으면 생략)">
      </div>

      <div class="form-group">
        <label>상세 내용</label>
        <textarea class="form-input" rows="4" placeholder="상세 내용을 입력하세요"></textarea>
      </div>

      <button class="btn-submit" onclick="alert('모임이 생성되었습니다!'); closeCreateModal();">모임 생성하기</button>
    </div>
  </div>

  <!-- 하단 네비게이션 메뉴 바 -->
  <nav class="bottom-nav">
    <a class="nav-item" onclick="alert('동아리 탭 이동')">
      <div class="nav-icon">🛡️</div><span>동아리</span>
    </a>
    <a class="nav-item active" onclick="location.reload();">
      <div class="nav-icon">👥</div><span>모임</span>
    </a>
    <a class="nav-item plus-btn" onclick="openCreateModal()">
      <div class="nav-icon">➕</div><span>작성</span>
    </a>
    <a class="nav-item" onclick="alert('지도 화면 이동')">
      <div class="nav-icon">🗺️</div><span>지도</span>
    </a>
    <a class="nav-item" onclick="alert('마이페이지 이동')">
      <div class="nav-icon">👤</div><span>my</span>
    </a>
  </nav>

  <!-- 통합된 Script 태그 -->
  <script>
    // 전체 공지방 롤링
    const notices = [
      "📢 [전체 공지] 익명3: \"정문 앞 대리석 의자 쪽 택시 타실 분 급구!!\"",
      "📢 [전체 공지] 학식빌런: \"학생식당 돈까스 같이 드실 분 구함요\"",
      "📢 [전체 공지] 코딩노예: \"3공학관 4층 오픈스페이스에서 카공하실 분 구해요\""
    ];
    let noticeIdx = 0;
    
    setInterval(() => {
      noticeIdx = (noticeIdx + 1) % notices.length;
      document.getElementById('noticeTicker').innerText = notices[noticeIdx];
    }, 4000);

    // 상세페이지 제어
    function openDetail(title, category, people, time, material) {
      document.getElementById('detailTitle').innerText = `${category} ${title}`;
      document.getElementById('detailPeople').innerText = people;
      document.getElementById('detailTime').innerText = time;
      document.getElementById('detailMaterial').innerText = material;
      
      const joinBtn = document.getElementById('joinBtn');
      joinBtn.innerText = "참여하기";
      joinBtn.classList.remove('cancel');
      document.getElementById('chatSection').style.display = "none";

      document.getElementById('detailSection').classList.add('active');
      window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
    }

    function closeDetail() {
      document.getElementById('detailSection').classList.remove('active');
    }

    // 참여 버튼 토글
    function toggleJoin() {
      const joinBtn = document.getElementById('joinBtn');
      const chatSection = document.getElementById('chatSection');
      
      if(joinBtn.innerText === "참여하기") {
        joinBtn.innerText = "참여 취소";
        joinBtn.classList.add('cancel');
        chatSection.style.display = "block";
      } else {
        joinBtn.innerText = "참여하기";
        joinBtn.classList.remove('cancel');
        chatSection.style.display = "none";
      }
    }

    // 새 모임 만들기 모달 제어
    function openCreateModal() {
      document.getElementById('createMeetingModal').style.display = 'flex';
    }
    
    function closeCreateModal() {
      document.getElementById('createMeetingModal').style.display = 'none';
    }
  </script>
</body>
</html>