// 3_anonymous.js - Example of anonymous function
// CSCI3230U

let factorials;

let factorial = function(n) {
  if (n === 0) {
    return 1;
  }
  return n * factorial(n-1);
}


factorials = [];
for (let i = 0; i < 7; i += 1) {
  factorials.push(factorial(i));
}
console.log(factorials);