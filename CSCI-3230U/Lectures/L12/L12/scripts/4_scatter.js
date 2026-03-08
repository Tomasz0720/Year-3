// 4_scatter.js - Simple scatter plot with D3
// CSCI3230U

window.onload = () => {
    // Overall dimensions of the SVG canvas (in pixels).
    // These are the outer dimensions, including margins.
    const xSize = 500;
    const ySize = 500;

    // Margin creates padding so axes/labels are not drawn at the very edge.
    const margin = 40;

    // "Inner plot area" dimensions (the drawable region inside margins).
    // Points will be generated within [0, xMax] × [0, yMax] in plot coordinates.
    const xMax = xSize - margin * 2;
    const yMax = ySize - margin * 2;

    // Create Random Points
    const numPoints = 100;
    const data = [];
    for (let i = 0; i < numPoints; i++) {
        data.push([Math.random() * xMax, Math.random() * yMax]);
    }

    // Append the SVG to the page.
    // We append a <g> (group) and translate it by (margin, margin)
    // so that (0,0) in the group corresponds to the top-left of the inner plot area.
    // This makes it easier to position axes and points.
    // See: https://jenkov.com/tutorials/svg/g-element.html
    const svg = d3.select("#myPlot")
        .append("svg")
        .append("g")
        .attr("transform", "translate(" + margin + "," + margin + ")");

    // X axis scale (data space -> pixel space).
    // domain is the "data units" range; range is the pixel range on screen.
    const x = d3.scaleLinear()
        .domain([0, 500])
        .range([0, xMax]);

    // Create an axis generator and render it into a <g>.
    // The transform moves the x-axis to the bottom of the inner plot area.
    svg.append("g")
        .attr("transform", "translate(0," + yMax + ")")
        .call(d3.axisBottom(x));

    // Y axis scale.
    // The range is reversed: [yMax, 0] so that larger y values appear higher,
    const y = d3.scaleLinear()
        .domain([0, 500])
        .range([yMax, 0]);

    svg.append("g")
        .call(d3.axisLeft(y));

    // Dots (scatter points)
    // This uses the D3 "enter selection" pattern:
    // 1) selectAll("dot") creates an *empty selection* (there are no <dot> elements)
    // 2) .data(data) binds the 100 data points
    // 3) .enter() represents the 100 new elements we need to create
    // 4) .append("circle") creates one <circle> per data point
    //
    // Note: "dot" is not an SVG element; it is just a placeholder selector.
    // Using "circle" here would also work: selectAll("circle").
    svg.append('g')
        .selectAll("dot")
        .data(data)
        .enter()
        .append("circle")
        .attr("cx", function (d) { return d[0] })
        .attr("cy", function (d) { return d[1] })
        .attr("r", 3)
        .style("fill", "Red");
}