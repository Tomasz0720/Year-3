// 5_d3_svg.js - Advanced plotting with D3 and SVG
// CSCI3230U

window.onload = () => {

    // Load JSON data asynchronously.
    // d3.json(...) returns a Promise that resolves to the parsed JS object/array.
    d3.json('data/sales.json')
        .then(salesData => {

            const margin = 50;
            const width = 800;
            const height = 500;
            const chartWidth = width - 2 * margin;
            const chartHeight = height - 2 * margin;

             // Create the SVG element (the drawing canvas).
            let svg = d3.select('body')
                .append('svg')
                .attr('width', width)
                .attr('height', height);

            // Colour scale maps numeric sales values to colours.
            // scaleLinear interpolates between two colours across the specified domain.
            const colourScale = d3.scaleLinear()
                .domain([978, 2188])
                .range(['red', 'blue']);

            // X scale: scaleBand for categorical/ordinal data (years).
            // domain is the list of categories in order; range maps categories across chartWidth.
            const xScale = d3.scaleBand() // discrete, bucket
                .domain(salesData.map((data) => data.year))
                .range([0, chartWidth])
                .padding(0.3);

            // Y scale: numeric values (sales) mapped to vertical pixels.
            const yScale = d3.scaleLinear()
                .domain([0, 2200])
                .range([chartHeight, 0]);

            // Title text positioned in the outer SVG coordinates.
            svg.append('text')
                .attr('x', width / 2)
                .attr('y', margin)
                .attr('text-anchor', 'middle')
                .text('Sales by Year');


            // create a group (g) for the bars
           // This moves the origin (0,0) to the top-left of the inner plotting area.
            // All axes and bars drawn inside 'g' automatically respect the margin.
            // See: https://jenkov.com/tutorials/svg/g-element.html
            let g = svg.append('g')
                .attr('transform', `translate(${margin}, ${margin})`);

            // Y-axis: render an axis using the yScale.
            // This is added as a child <g> within the chart group.
            g.append('g')
                .call(d3.axisLeft(yScale));

            // x-axis
            g.append('g')
                .attr('transform', `translate(0, ${chartHeight})`)
                .call(d3.axisBottom(xScale));


            // Bars:
            // 1) selectAll('rect') creates a selection of existing bars (none at first)
            // 2) .data(salesData) binds one datum per bar
            // 3) .enter() represents the new elements needed
            // 4) .append('rect') creates one <rect> per salesData item
            let rectangles = g.selectAll('rect')
                .data(salesData)
                .enter()
                .append('rect')
                // X position is determined by the categorical xScale (year -> band position).
                .attr('x', (data) => xScale(data.year))
                // Start bars "at the bottom" so we can animate them rising up.
                // At initialization:
                // - y is set to chartHeight (bottom of plot area)
                // - height is set to 0
                .attr('y', (data) => chartHeight)
                .attr('width', xScale.bandwidth())
                .attr('height', (data) => 0)
                // Fill colour is computed from sales values via colourScale.
                .attr('fill', (data) => colourScale(data.sales))
                // Mouse events:
                // Use function() instead of arrow functions so that `this` refers to the hovered <rect>.
                // (With arrow functions, `this` would not be the DOM element.)
                .on('mouseenter', function (source, index) {
                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('opacity', 0.5);
                })
                .on('mouseleave', function (source, index) {
                    d3.select(this)
                        .transition()
                        .duration(200)
                        .attr('opacity', 1.0);
                });

            // Animate rectangles from the baseline up to their final heights.
            // yScale(data.sales) gives the top y pixel for that bar.
            // chartHeight - yScale(data.sales) gives the bar height in pixels.
            rectangles.transition()
                .ease(d3.easeElastic)
                .attr('height', (data) => chartHeight - yScale(data.sales))
                .attr('y', (data) => yScale(data.sales))
                .duration(1000)
                // Stagger animation by index to create a "wave" effect.
                .delay((data, index) => index * 50);
        })
        .catch(error => {
            // Catch handles either network errors or JSON parsing errors.
            console.error("Error loading or parsing data:", error);
        });
}