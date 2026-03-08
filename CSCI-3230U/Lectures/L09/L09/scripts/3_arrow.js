// 3_arrow.js - Arrow notation
// CSCI3230U

let myArray;
myArray = [1, 2, 3];

console.log("Callback");

// Traditional function syntax with callback
function myFunction(value) {
    console.log("%d", value);
}
myArray.forEach(myFunction);

console.log("Arrow notation")

// Lambda function
myArray.forEach(value => {
    console.log(value * 5);
});

// More examples
// 
// Returns hello world
str = (() => "hello world")();
console.log(str);

// If-else statement
const simple = (a) => (a > 15 ? 15 : a);
console.log(simple(16)); // 15
console.log(simple(10)); // 10

// Parameterless arrow functions that are visually easier to parse
setTimeout(() => {
    console.log("I happen first");
    setTimeout(() => {
        // deeper code
        console.log("I happen second");
    }, 2000);
}, 2000);