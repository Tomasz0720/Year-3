// 5_binding.js - Data binding in D3
// CSCI3230U


let dataArray = [1, 2, 3, 4, 5];
let colours = ['pink', 'red', 'green', 'cornflowerblue', 'orange'];

// Update fill colour of circles
let circles = d3.select("body")
    .selectAll("circle")
    .data(dataArray)
    .attr("fill", "blue");

let myData = ["Hello World!", "Lets replace me", "with more text"];

// Replace paragraph text with myData
let p = d3.select("body")
    .selectAll("p")
    .data(myData)
    .text((d) => {
        return d;
    });