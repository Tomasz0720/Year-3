/**
 * checkEvenNumber: Returns a Promise that checks if a given number is even.
 */
function checkEvenNumber(number) {
    return new Promise((resolve, reject) => {
        // Check if the number is even
        if (number % 2 === 0) {
            resolve(`Number ${number} is even!`);
        } else {
            reject(`Number ${number} is odd!`);
        }
    });
}

// Example usage:
checkEvenNumber(10)
    .then((message) => {
        console.log("Success:", message);
    })
    .catch((error) => {
        console.error("Error:", error);
    });
