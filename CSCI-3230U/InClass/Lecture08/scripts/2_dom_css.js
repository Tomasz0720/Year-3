// 2_dom_css.js - Manipulating the DOM using CSS selectors
// CSCI3230U

/**
 * DOM manipulation with Javascript by Element
 * RUN: Chrome with developer console open, load 2_dom_css.html
 */
console.log("START: CSS selector example");

let ul_list, head1, first_odd, all_odd;

head1 = document.querySelectorAll("h1");
ul_list = document.querySelector("#myID");
first_odd = document.querySelector(".odd");
all_odd = document.querySelectorAll(".odd");

console.log("Head1: ", head1);
console.log("List: ", ul_list);
console.log("First odd li: ", first_odd);
console.log("All odd li: ", all_odd);

// Change color of all headers
all_odd[0].style.color = "Green";
all_odd[1].style.color = "Purple";
console.log("END: CSS selector example");

// Remove an element
// all_even = document.querySelectorAll(".even");
// ul_list.removeChild(all_even[0]);

// Add an element
let new_li = document.createElement("li");
new_li.classList.add("even");  // Or new_li.className = "even"
new_li.textContent = "List item four";
ul_list.appendChild(new_li);