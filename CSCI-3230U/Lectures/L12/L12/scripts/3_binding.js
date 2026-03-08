// 3_binding.js - Adding elements to DOM
// CSCI3230U

window.onload = () => {
    // Data arrays and colors:
    // dataArray is our "data model" — changing it and re-rendering updates the SVG.
    let dataArray = [1, 2, 3, 4, 5];

    // colours is just a lookup table to make each circle visually distinct.
    // Note: we reuse colours with modulo when there are more circles than colours.
    let colours = ['blue', 'red', 'green', 'cornflowerblue', 'orange'];

    // Select the SVG element
    // All subsequent selectAll/append calls are scoped inside this SVG.
    let svg = d3.select("#mySVG");

    // A function to render circles based on the current dataArray
    // This illustrates the D3 "general update pattern": join → exit → update → enter.
    function render(data) {

       // 1. DATA JOIN (BIND DATA)
        // selectAll("circle") returns a selection of existing circles (possibly empty).
        // .data(data, d => d) binds the array to that selection.
        //
        // The second argument is a "key function":
        // - it tells D3 how to match data items to existing DOM elements across renders
        // - stable keys allow D3 to reuse/update the *same* circle when data changes,
        //   rather than treating everything as new/removed each time.
        // Here, we use the data value itself as the key (works only if values are unique).
        const circles = svg.selectAll("circle")
            .data(data, d => d);

        // 2. EXIT SELECTION
        // Any circles that no longer have a corresponding data element are in the "exit" selection.
        // Removing them keeps the DOM in sync with the data.
        circles.exit().remove();

        // 3. UPDATE SELECTION
        // The "update" selection is circles that already exist AND still have bound data.
        // Here, we update their position and styling in case indices/colours changed.
        circles
            .attr("cx", (d, i) => (i + 1) * 50)
            .attr("cy", 100)
            .attr("r", 20)
            .attr("fill", (d, i) => colours[i % colours.length]);

        // 4. ENTER SELECTION
        // The "enter" selection represents new data items with no existing circle.
        // For each entering item, we append a new <circle> and set its attributes.
        circles
            .enter()
            .append("circle")
            .attr("cx", (d, i) => (i + 1) * 50)
            .attr("cy", 100)
            .attr("r", 20)
            .attr("fill", (d, i) => colours[i % colours.length]);
        
        // Alternate implemtation
        // svg.selectAll("circle").data(data, d => d).join(
        //   enter => enter.append("circle").attr(...),
        //   update => update.attr(...),
        //   exit => exit.remove()
        // );

    } // end of render()

    // Initial render
    render(dataArray);

    // After 3 seconds: fewer data points.
    // Effects:
    // - exit: circles whose bound keys are not present anymore are removed
    // - update: circles whose keys still exist are updated
    setTimeout(() => {
        dataArray = [10, 20, 30]; // Fewer data points
        render(dataArray);
    }, 3000);

    // Modifying our data: After another 3 seconds, expand data again to show another enter
    setTimeout(() => {
        dataArray = [42, 99, 11, 64, 128, 256]; // More data points
        render(dataArray);
    }, 6000);
}