// 1_storage.js - Client-side storage
// CSCI3230U
// See 1_storage.html

// Local storage
window.localStorage.setItem('username', 'Navi');
// session storage - store relative to the user's session (until browser closes)
window.sessionStorage.setItem('school', 'OntarioTech');

// Delay for 2000ms then run
setTimeout(() => {
    // Retrieve DOM elements
    const usernameElem = document.getElementById("username");
    const schoolElem = document.getElementById("school");
    
    // Retrieve from storage and display
    usernameElem.textContent = window.localStorage.getItem('username');
    schoolElem.textContent = window.sessionStorage.getItem('school');
    
    // Color text and make bold
    usernameElem.style.fontWeight = "bold";
    usernameElem.style.color = "blue";
    schoolElem.style.fontWeight = "bold";
    schoolElem.style.color = "red";

    // Clear storage
    window.localStorage.removeItem('username');
    window.sessionStorage.removeItem('school');
  }, "2000")
  