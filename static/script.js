function showClock() {
    const clockContainer = document.getElementById("clock-container");
    clockContainer.innerHTML = '<div id="clock"><span id="time"></span></div>';
    updateClock();
    setInterval(updateClock, 1000);
}

function updateClock() {
    const now = new Date();
    const timeString = now.toLocaleTimeString();
    document.getElementById("time").innerText = timeString;
}
