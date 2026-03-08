// 5_button.js - Demonstration of onload behaviour
// CSCI3230U
// See 3_button.html

//  Defines behavior when button is clicked
function buttonClicked() {
    alert("The button was clicked!");
}

// Event handler for window loading
// function setup() {
    
//     let button = document.getElementById("btn");
//     // Register an event handler for when the button is clicked
//     button.onclick = buttonClicked;
// }

// // Set the onload property of our Window object to our setup function
// window.onload = setup;

// Anonymous function equivalent
window.onload = function() {
    let button = document.getElementById("btn");
    // Register an event handler for when the button is clicked
    button.onclick = buttonClicked;
};
