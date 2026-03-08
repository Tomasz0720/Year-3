// 5_promise_catch.js - Demonstrating how to catch an error
// CSCI3230U

// returns a promise
let countValue = new Promise(function (resolve, reject) {
    // Uncomment to reject or resolve
    resolve('Promise ...');
    //reject('Promise ...')
});

// executes when promise is resolved successfully
countValue
    .then(
        function successValueX(result) {
            console.log(result, "resolved");
        },
    )
    // executes if there is an error
    .catch(
        function errorValue(result) {
            console.log(result, "REJECTED");
        }
    );