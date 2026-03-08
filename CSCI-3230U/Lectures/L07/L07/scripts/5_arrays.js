// 5_arrays.js - Wokring with arrays
// CSCI3230U

// Initialise to 100 elements
let emptyArray = new Array(100);
let newArray = new Array("one", "two", 3);

// Print to console
console.log(emptyArray);
console.log(newArray);

// Overwrite with new objects
emptyArray = [];
newArray = ["one", "two", 3];
notTheSameAsAboveArray = [100];

// Print to console
console.log(emptyArray);
console.log(newArray);
console.log(notTheSameAsAboveArray);

// Initialise array
myArray = [1,2,3,4,"new item"];
// Add item to end of array, growing by 1
myArray.push("item at end");
myArray.push("Last, really", "one more!");
// Remove last element, shrinks array by 1
let lastItem = myArray.pop();
// Remove first element, shrinks array by 1
let firstItem = myArray.shift();
console.log("Last: %s, First: %d", lastItem, firstItem);
myArray.unshift("a");
console.log(myArray);
// [inclusive, exclusive]
console.log(myArray.slice(0, 4));

// Change length
console.log("Before:", myArray);
myArray.length = 3;
console.log("After:", myArray);