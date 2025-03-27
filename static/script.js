function showClock() {
    const clockContainer = document.getElementById("clock-container");
    clockContainer.innerHTML = '<div style="border-radius:50%; width:150px; height:150px; background-color:grey; display:flex; align-items:center; justify-content:center;"><span id="time"></span></div>';
    updateClock();
    setInterval(updateClock, 1000);
}

function updateClock() {
    const now = new Date();
    const timeString = now.toLocaleTimeString();
    document.getElementById("time").innerText = timeString;
}
