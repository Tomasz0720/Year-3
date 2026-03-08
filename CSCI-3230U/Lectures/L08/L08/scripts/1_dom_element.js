// 1_dom_element.js - Manipulating the DOM using HTML elements
// CSCI3230U

/**
 * DOM manipulation with Javascript by Element
 * RUN: Chrome: View/Developer/JavaScript console, load 1_dom_element.html
 */
console.log("START: Element example");

let ul, li;
ul = document.getElementsByTagName("ul");

for (let i = 0; i < ul.length; i += 1) {
    li = ul[i].getElementsByTagName("li");
    console.log("The " + (i+1) +
        "st list has " + li.length +
        " items in it.");
}

// Change list element font color
li[0].style.color="red";
li[1].style.color="blue";

//console.log(document.getElementById);
console.log("END: Element example");