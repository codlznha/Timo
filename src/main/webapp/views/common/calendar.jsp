<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .cal-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:15px; font-weight:bold; }
    .cal-header button { background:none; border:none; cursor:pointer; color:var(--text-gray); font-size:1rem; }
    .cal-grid { display:grid; grid-template-columns:repeat(7,1fr); gap:5px; text-align:center; font-size:0.85rem; }
    .cal-day-name { color:var(--text-gray); font-size:0.75rem; font-weight:bold; margin-bottom:5px; }
    .cal-date { padding:6px 0; border-radius:50%; cursor:pointer; color:var(--text-dark); }
    .cal-date:hover { background-color:var(--bg-color); }
    .cal-date.today { background-color:var(--primary-blue); color:var(--white); font-weight:bold; }
    .cal-date.has-event { border-bottom:2px solid #ff8c00; border-radius:0; font-weight:bold; }
    .cal-date.empty { cursor:default; }
    .cal-date.empty:hover { background:none; }
</style>

<div class="card">
    <div class="cal-header">
        <button type="button" onclick="calChangeMonth(-1)"><i class="fa-solid fa-chevron-left"></i></button>
        <span id="calTitle"></span>
        <button type="button" onclick="calChangeMonth(1)"><i class="fa-solid fa-chevron-right"></i></button>
    </div>
    <div class="cal-grid" id="calGrid"></div>
</div>

<!-- 일정 모달 -->
<div class="modal-overlay" id="calModal">
    <div class="modal-content">
        <div class="modal-header">
            <span id="calModalTitle">일정</span>
            <button class="btn-close" onclick="closeCalModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div style="margin-bottom:20px;">
            <ul id="calModalList" style="list-style:none; font-size:0.9rem; color:var(--text-dark); margin-bottom:10px;"></ul>
            <input type="text" id="calNewSchedule" placeholder="새로운 일정 추가..."
                style="width:100%; padding:10px; border:1px solid var(--border-color); border-radius:6px; outline:none;">
        </div>
        <button
            style="width:100%; padding:12px; background:var(--primary-blue); color:white; border:none; border-radius:6px; cursor:pointer; font-weight:bold;"
            onclick="calSaveSchedule()">저장하기</button>
    </div>
</div>

<script>
    // ===== 상태 =====
    const CAL_TODAY = new Date(); // 실제 오늘 (동적)
    let calViewYear = CAL_TODAY.getFullYear();
    let calViewMonth = CAL_TODAY.getMonth(); // 0-based
    let calSelectedDate = null;

    // ===== 일정 데이터 (임시: localStorage) =====
    // TODO: 실제 서비스에서는 아래 두 함수를 서버 API(fetch) 호출로 교체하세요.
    //   getEvents(year, month)  -> GET  /api/schedule?year=..&month=..
    //   saveEvent(dateKey, txt) -> POST /api/schedule  { date: dateKey, content: txt }
    function calLoadEvents() {
        return JSON.parse(localStorage.getItem('timo_schedule_events') || '{}');
    }
    function calStoreEvents(events) {
        localStorage.setItem('timo_schedule_events', JSON.stringify(events));
    }

    function calDateKey(y, m, d) {
        return y + '-' + String(m + 1).padStart(2, '0') + '-' + String(d).padStart(2, '0');
    }

    function calRender() {
        const events = calLoadEvents();
        document.getElementById('calTitle').innerText =
            calViewYear + '. ' + String(calViewMonth + 1).padStart(2, '0');

        const grid = document.getElementById('calGrid');
        grid.innerHTML = '';

        ['일','월','화','수','목','금','토'].forEach((d, i) => {
            const el = document.createElement('div');
            el.className = 'cal-day-name';
            if (i === 0) el.style.color = '#ff5252';
            if (i === 6) el.style.color = 'var(--primary-blue)';
            el.innerText = d;
            grid.appendChild(el);
        });

        const firstWeekday = new Date(calViewYear, calViewMonth, 1).getDay();
        const totalDays = new Date(calViewYear, calViewMonth + 1, 0).getDate();

        for (let i = 0; i < firstWeekday; i++) {
            const el = document.createElement('div');
            el.className = 'cal-date empty';
            grid.appendChild(el);
        }

        for (let d = 1; d <= totalDays; d++) {
            const key = calDateKey(calViewYear, calViewMonth, d);
            const el = document.createElement('div');
            el.className = 'cal-date';
            el.innerText = d;

            const isToday = calViewYear === CAL_TODAY.getFullYear()
                && calViewMonth === CAL_TODAY.getMonth()
                && d === CAL_TODAY.getDate();
            if (isToday) el.classList.add('today');

            if (events[key] && events[key].length > 0) el.classList.add('has-event');

            el.onclick = () => openCalModal(key);
            grid.appendChild(el);
        }
    }

    function calChangeMonth(diff) {
        calViewMonth += diff;
        if (calViewMonth < 0) { calViewMonth = 11; calViewYear--; }
        if (calViewMonth > 11) { calViewMonth = 0; calViewYear++; }
        calRender();
    }

    function openCalModal(dateKey) {
        calSelectedDate = dateKey;
        const [y, m, d] = dateKey.split('-');
        document.getElementById('calModalTitle').innerText = `${y}. ${m}. ${d} 일정`;

        const events = calLoadEvents();
        const list = document.getElementById('calModalList');
        list.innerHTML = '';
        const dayEvents = events[dateKey] || [];

        if (dayEvents.length === 0) {
            list.innerHTML = '<li style="color:var(--text-gray); font-size:0.9rem;">등록된 일정이 없습니다.</li>';
        } else {
            dayEvents.forEach(txt => {
                const li = document.createElement('li');
                li.style.padding = '6px 0';
                li.style.borderBottom = '1px solid var(--border-color)';
                li.innerText = txt;
                list.appendChild(li);
            });
        }

        document.getElementById('calNewSchedule').value = '';
        document.getElementById('calModal').classList.add('show');
    }

    function closeCalModal() {
        document.getElementById('calModal').classList.remove('show');
        calSelectedDate = null;
    }

    function calSaveSchedule() {
        const input = document.getElementById('calNewSchedule');
        const txt = input.value.trim();
        if (!txt) { alert('일정 내용을 입력해주세요.'); return; }

        const events = calLoadEvents();
        if (!events[calSelectedDate]) events[calSelectedDate] = [];
        events[calSelectedDate].push(txt);
        calStoreEvents(events);

        closeCalModal();
        calRender(); // has-event 표시 갱신
    }

    window.addEventListener('click', function (event) {
        if (event.target === document.getElementById('calModal')) closeCalModal();
    });

    calRender();
</script>