function clickMe() {
    var text = document.getElementById("show");
    if (!text.style.display) {
        text.style.display = "none";
    }
    if (text.style.display === "none") {
        text.style.display = "block";
    } else {
        text.style.display = "none";
    }

    console.log("clicked")
}