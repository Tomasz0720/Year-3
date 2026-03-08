// cc1.js - Data binding in D3
// CSCI3230U


let dataArray = [1, 2, 3, 4, 5];
let colours = ['pink', 'red', 'green', 'cornflowerblue', 'orange'];

// 1. Update fill colour of circles
let circles = d3.select("body")
    .selectAll("circle")
    .data(dataArray)
    .attr("fill", (d) => {
        return colours[d]
    })

// 2. Remove the use of dataArray
// let circles = d3.select("body")
//     .selectAll("circle")
//     .data(colours)
//     .attr("fill", (d) => {
//         return d
//     })