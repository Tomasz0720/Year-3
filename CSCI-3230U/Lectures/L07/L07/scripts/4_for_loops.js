// 4_for_loops.js - For..in and For..of and forEach
// CSCI3230U

const numbers = [45, 4, 9, 16, 25, 73];

console.log("-- For..in -- ");
for (let i in numbers) {
    console.log(i);
}

console.log("-- For..of -- ");
for (element of numbers) {
    console.log(element);
}

console.log("-- forEach -- ");
function myFunction(value, index) {
    console.log("[%d:%d]",index, value);
}
numbers.forEach(myFunction);