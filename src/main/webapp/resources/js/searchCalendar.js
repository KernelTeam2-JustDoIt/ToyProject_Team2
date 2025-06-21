const container = document.getElementById("calendar-container");
const dateLabel = document.getElementById("date-label");

let checkIn = new Date();
let checkOut = new Date();
checkOut.setDate(checkOut.getDate() + 1);

function updateDateLabel() {
    const formatDisplay = d => ("0" + (d.getMonth() + 1)).slice(-2) + '.' + ("0" + d.getDate()).slice(-2);
    const formatForServer = d => d.getFullYear() + '-' +
        ("0" + (d.getMonth() + 1)).slice(-2) + '-' +
        ("0" + d.getDate()).slice(-2);

    const nights = Math.max(1, Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24)));

    // 화면에 표시할 날짜
    dateLabel.textContent = formatDisplay(checkIn) + "~" + formatDisplay(checkOut) + ", " + nights + "박";

    // 서버로 전달할 input 값 설정
    document.getElementById("checkInInput").value = formatForServer(checkIn);
    document.getElementById("checkOutInput").value = formatForServer(checkOut);
}

function generateCalendar(year, month) {
    const box = document.createElement("div");
    box.className = "calendar-box";

    const monthTitle = document.createElement("div");
    monthTitle.style.textAlign = "center";
    monthTitle.style.fontWeight = "bold";
    monthTitle.style.marginBottom = "8px";
    monthTitle.textContent = year + "." + ("0" + (month + 1)).slice(-2);
    box.appendChild(monthTitle);

    const table = document.createElement("table");
    const thead = document.createElement("thead");
    thead.innerHTML = '<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>';
    table.appendChild(thead);

    const tbody = document.createElement("tbody");
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const startWeek = firstDay.getDay();

    let date = 1;
    for (let i = 0; i < 6; i++) {
        const row = document.createElement("tr");
        for (let j = 0; j < 7; j++) {
            const cell = document.createElement("td");
            if (i === 0 && j < startWeek) {
                cell.classList.add("disabled");
            } else if (date > lastDay.getDate()) {
                cell.innerHTML = "";
            } else {
                cell.textContent = date;
                cell.classList.add("day");
                const fullDate = new Date(year, month, date);
                cell.dataset.date = fullDate.toISOString();
                cell.addEventListener("click", () => handleDateClick(cell, fullDate));
                date++;
            }
            row.appendChild(cell);
        }
        tbody.appendChild(row);
        if (date > lastDay.getDate()) break;
    }

    table.appendChild(tbody);
    box.appendChild(table);
    container.appendChild(box);
}

function handleDateClick(cell, dateObj) {
    const allCells = document.querySelectorAll(".calendar-box .day");
    allCells.forEach(c => c.classList.remove("checkin", "checkout", "selected"));

    if (!checkIn || (checkIn && checkOut)) {
        checkIn = dateObj;
        checkOut = null;
        cell.classList.add("checkin", "selected");
    } else if (checkIn && !checkOut && dateObj > checkIn) {
        checkOut = dateObj;
        allCells.forEach(c => {
            const d = new Date(c.dataset.date);
            if (d > checkIn && d < checkOut) c.classList.add("selected");
            if (+d === +checkIn) c.classList.add("checkin");
            if (+d === +checkOut) c.classList.add("checkout");
        });
    } else {
        checkIn = dateObj;
        checkOut = null;
        cell.classList.add("checkin", "selected");
    }
}

document.addEventListener("DOMContentLoaded", () => {
    generateCalendar(new Date().getFullYear(), new Date().getMonth());
    generateCalendar(new Date().getFullYear(), new Date().getMonth() + 1);
    updateDateLabel();

    document.getElementById("dateApplyBtn").addEventListener("click", () => {
        updateDateLabel();
        togglePopup('searchPopup');
    });
});
