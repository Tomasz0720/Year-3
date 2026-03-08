// 7_jquery_dom.js - Simple jQuery
// CSCI3230U

p = $("em").parent();
console.log(p);
console.log(typeof p);
c = $($("ul")[0]).children();
console.log(c[0]);

// By CSS (newer)
jQuery("p.details").css("background-color", "yellow").show("fast");
//document.querySelector(".blue").style.backgroundColor = "lightblue";
// document.querySelector("#blueID")

// By Element ID (older)
document.getElementById("blueID").style.backgroundColor = "lightblue";

// Equivalent
//document.querySelectorAll("p")
//$("p")

// Set all
// for (const e of $("p"))
//     e.style.backgroundColor = "green";
// for (const e of $document.querySelectorAll("p")) 
//     e.style.backgroundColor = "lightblue";
// $("p").css("background-color", "yellow")
// $("p").css({ color: "red", fontWeight: "bold", backgroundColor: "lightblue" })

// Build new element
let newP = $("<p>New paragraph element generated with jQuery, then coloured green.</p>");
newP.addClass("greenP")
$("body").append(newP);

// Paint green
jQuery("p.greenP").css("background-color", "lightgreen");
