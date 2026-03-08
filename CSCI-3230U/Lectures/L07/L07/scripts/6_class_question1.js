// 6_class_question1.js - What will it output? It's tricky!
// CSCI3230U

let a = Array("Santa", "Never", "came", "up", 2);
let b = [3.14, -237, ["give", "you"], 0];
a.shift();
let c = [a.shift(), "gonna", ...b[a.pop()], a.pop()];
console.log(c.join(" "));