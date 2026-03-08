// 6_promise_wait.js - Lambda function with promises
// CSCI3230U

function wait(howLong = 0) {
    return new Promise((resolve, reject) => {
        setTimeout(resolve, howLong);
    });
}

console.log("Lets make a promise ...");

let promise = wait(1000).then(() => {
    console.log("wait()'s promise has been fulfilled");
});