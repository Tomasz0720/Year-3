/**
 * DOM manipulation with Javascript by Element
 * RUN: Chrome with developer console open, load 3_dom_example.html
 *
 * Author: Steven R. Livingstone
 */
console.log("START: Element example");

let ul, i, li;
ul = document.getElementsByTagName("ul");

for (i = 0; i < ul.length; i += 1) {
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