// 2_function.js - Functional programming example
// CSCI3230U
let func, factorials;

function factorial(n) {
  if (n === 0) {
    return 1;
  }
  return n * factorial(n-1);
}

func = factorial;
factorials = [];
for (let i = 0; i < 5; i += 1) {
  factorials.push(func(i));
}
console.log(factorials);

