// 4_promise.js - A simple promise with an error
// CSCI3230U

// returns a promise
let countValue = new Promise(function (resolve, reject) {
    resolve("Promise resolved");
});

// executes when promise is resolved successfully
countValue
    .then(function successValue(result) {
        console.log("1.", result);
    })

    .then(function successValue1() {
        console.log("2. You can call multiple functions this way.");
    });



// const count = true;

// let countValue = new Promise(function (resolve, reject) {
//     if (count) {
//         resolve("There is a count value.");
//     } else {
//         reject("There is no count value");
//     }
// });

// console.log(countValue);