// 4_undefined.js - Where you will see undefined in JS
// CSCI3230U

// 1. Variable with no value
// let x;
console.log("1. ", typeof (x));

// 2. A function with no return value
function do_nothing() {
    let x = 1
}
console.log("2. ", do_nothing());

// 3. A parameter value when none is provided
function join_char(a, b) {
    return((a + "_" + b));
}
console.log("3. ", join_char(1));