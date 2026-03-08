// 3_dynamic.js - Dynamic properties with D3
// CSCI3230U

// List of colours for <p> text
let colours = ['blue', 'red', 'green', 'cornflowerblue', 'orange'];

// Change paragraph colours dynamically
d3.selectAll("p")
    .style("color", (data, index) => {
        return colours[index];
    });

// Alternate colour of list items
d3.selectAll("li")
    .style("color", (d, i) => {
        return i % 2 ? "gray" : "purple";
    });

// Data to overwrite 'p' text content
let data_set = ['D1', 'D2', 'D3'];
// Replace <p> text content with that of data_set.
let paragraph = d3.select("body")
    .selectAll("p")
    // Attaches the array data_set to the selection of paragraphs. 
    // Each item in data_set will be paired with an element in the DOM selection.
    .data(data_set)
    .text((d, i) => {
        console.log("d: " + d);
        console.log("i: " + i);
        console.log("this: " + this);
        // Set value of p
        return d.concat("_!");
    });