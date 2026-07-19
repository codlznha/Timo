<!-- 모달 배경 -->
<div class="modal-overlay">
  <!-- 모달 창 -->
  <div class="modal-content">
    <!-- 헤더: 카테고리 및 닫기 -->
    <div class="modal-header">
      <span class="category">🏀 운동</span>
      <button class="close-btn">&times;</button>
    </div>

    <!-- 제목 및 기본 정보 -->
    <h2>[운동] 농구 한 판 할 사람</h2>
    <div class="info-meta">
      <span>⏰ 18:00 ~ 20:00</span>
      <span>👥 3/5</span>
    </div>

    <!-- 지도 이미지 영역 -->
    <div class="map-placeholder">
      [지도 이미지 영역]
    </div>
    <p class="location">📍 위치: TU 체육관 야외 코트</p>

    <!-- 상세 내용 -->
    <div class="details">
      <h3>상세 내용</h3>
      <p>안녕하세요! 다들 오랜만에 농구 한 판 어떠세요? 4:4로 깔끔하게 한 게임 뛰고 싶어서 사람 구해요. 실력 상관없고, 매너 플레이 하실 분들 환영합니다! 공은 제가 챙길게요. 오실 분들은 늦지 않게 와주세요!</p>
    </div>

    <!-- 하단 버튼 -->
    <div class="action-buttons">
      <button class="btn-join">참여하기</button>
    </div>
  </div>
</div>

<style>
  /* 모달 배경 */
  .modal-overlay {
    position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); display: flex;
    justify-content: center; align-items: center;
  }
  /* 모달 카드 */
  .modal-content {
    background: white; padding: 20px; border-radius: 16px;
    width: 400px; max-width: 90%; box-shadow: 0 4px 15px rgba(0,0,0,0.2);
  }
  .modal-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
  .map-placeholder { 
    background: #eee; height: 150px; display: flex; 
    align-items: center; justify-content: center; border-radius: 8px; margin: 10px 0;
  }
  .btn-join {
    width: 100%; padding: 12px; background: #007bff; color: white;
    border: none; border-radius: 8px; cursor: pointer; font-weight: bold;
  }
  .info-meta { display: flex; gap: 15px; color: #666; margin-bottom: 15px; }
</style>