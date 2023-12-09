var updateButton = document.getElementById("updateButton1");
var editButton = document.getElementById("editButton");

function clickMe() {
    var emailElement = document.getElementById("email");
    var passwordElement = document.getElementById("password");

    toggleElementVisibility(emailElement);
    toggleElementVisibility(passwordElement);

    if (updateButton.style.display === "none") {
        editButton.style.display = "none";
    } else {
        updateButton.style.display = "none";
    }

    console.log("clicked");
}

function new_dos() {
    var dosElement = document.getElementById("dos");

    toggleElementVisibility(dosElement);

    console.log("clicked");
}


function toggleElementVisibility(element) {
    if (!element.style.display || element.style.display === "none") {
        element.style.display = "block";
    } else {
        element.style.display = "none";
    }
}

document.addEventListener("DOMContentLoaded", function() {
    var dosInput = document.getElementById("dos");
    var changeDeadlineLink = document.getElementById("change_deadline");
    var submitBtn = document.getElementById("submitBtn");

    changeDeadlineLink.addEventListener("click", function(event) {
        event.preventDefault();
        dosInput.style.display = "inline";
        changeDeadlineLink.style.display = "none";
        submitBtn.style.display = "inline";
    });

    submitBtn.addEventListener("click", function() {
        document.getElementById("updateDosForm").submit();
    });
});

function handleSubmit(event) {
    console.log("Form submitted");
}

function goBack() {
    window.history.back();
}