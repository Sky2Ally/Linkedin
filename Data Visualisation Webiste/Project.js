function init()
{
    var margin = {top: 50, bottom: 100, left: 100, right: 1000}; //Defined margin sets svg container size
	var w =800
	var h =400
	var padding = 60;


	// Add the tooltip element
	var tooltip = d3.select("body")
	.append("div")
	.attr("class", "tooltip")
	.style("display", "none");


	// var parseDate = d3.time.format("%Y").parse; //This will pass a base string formatted in this way and convert into javascript date object.




	var svg = d3.select("#chart")              //Creates svg container.                                         // creating the svg element
					.append("svg")
					.attr("width", w+ margin.left + margin.right ) 
					.attr("height", h + margin.bottom + margin.top)
					.append("g")
					.attr("transform", "translate(" + margin.left + "," + margin.top + ")");


	xScale = d3.scaleTime() //Time scale scaling function. Range from 0 to width
				.range([0,w]);

	yScale = d3.scaleLinear() //Time scale scaling function. Range from height to 0
				.range([h,0]);

	var tooltip = d3.select("body")
				.append("div")
				.attr("class", "tooltip")
				.style("opacity", 0);


	line = d3.line()                                                        //line function to draw a line
			// .defined(function(d){ return d.date >= 2008;})
			.x(function(d){return xScale(d.Year);})                                  //x and y ar the points on the line
			.y(function(d){return yScale(d.Value);})
			// .curve(d3.curveMonotoneX);

	var countries = ["Philippines.csv", "Nepal.csv", "New-Zealand.csv", "Pakistan.csv", "South-Africa.csv", "United-Kingdom.csv" , "China.csv", "India.csv", "Hong-Kong.csv","Viet-Nam.csv", ];

	var colors = ["red", "blue", "green", "olive", "purple", "brown", "gray", "pink", "cyan", "magenta"];

	var legendLabels = ["Philippines", "Nepal", "New Zealand", "Pakistan", "South Africa", "United Kingdom" , "China", "India", "Hong Kong","Viet Nam", ];

	var checkboxContainer = d3.select("#checkboxes");

		// Create checkboxes for each country
	var checkboxes = checkboxContainer
						.selectAll("div")
						.data(countries)
						.enter()
						.append("div")
						.attr("class", "checkbox-container")
						.each(function (d) {
		var container = d3.select(this);
		var countryName = d.replace(".csv", ""); // Remove ".csv" from the country name

  container
    .append("input")
    .attr("type", "checkbox")
    .attr("value", function (d) {
      return countryName; // Use the modified country name as the checkbox value
    })
    .property("checked", true) // Initially check all checkboxes
    .on("change", function () {
      // Get the value (country) of the changed checkbox
      var country = d3.select(this).property("value");
      console.log("Selected country:", country);

      // Show or hide the corresponding line based on checkbox status
      var line = svg.select(".line-" + country.replace(/\s+/g, "-")); // Replace spaces with dashes in country names
      var display = this.checked ? "block" : "none";
      line
        .transition()
        .duration(500) // Set the duration of the transition effect in milliseconds
        .style("display", display);

      // Show or hide the corresponding circles based on checkbox status
      var circles = svg.selectAll(".circle-" + country.replace(/\s+/g, "-"));
      circles
        .transition()
        .duration(500) // Set the duration of the transition effect in milliseconds
        .style("display", display);
    });

  container.append("label").text(countryName);
});







	for (let i = 0; i < countries.length; i++) {
		d3.csv(countries[i]).then((data) => {
		  // Convert the date strings to date objects
		  data.forEach((d) => {
			d.Year =  new Date (d.Year);
			d.Value = +d.Value;
			d.Country = d.nationality;
		  });
		  console.log(data);

		  // Set the domain of the x and y scales
		xScale.domain([                                                            //configuring domain for minimum and maximum dates
					d3.min(data, function(d){return (d.Year);}),
					d3.max(data, function(d){return (d.Year);})
				]);
		yScale.domain([0, 45000]);

		  // Append the line to the svg
		svg.append("path")
			.datum(data)
			.attr("class", function(d) { return "line line-" + data[0].Country.replace(/\s+/g, "-") })
			.attr("d", line)
			.attr("stroke", colors[i])
			// .on("mouseenter", handleMouseEnter)
  			// .on("mouseleave", handleMouseLeave)
			.attr("title", function(d) {
				return d.Country;
			  })
			.transition() // Add transition for the line
			.duration(80 * i) // Set the transition duration
			.ease(d3.easeLinear) // Set the transition easing function
			.attrTween("stroke-dasharray", function() {
				var length = this.getTotalLength();
				return d3.interpolate(`0,${length}`, `${length},${length}`);
  			});

			 // Add the circles and tooltips for the current country
  		svg.selectAll(".circle-" + data[0].Country) // Use a unique class for each country's circles
			.data(data)
			.enter()
			.append("circle")
			.attr("class", function(d) { return "circle-" + d.nationality.replace(/\s+/g, "-") + " circle-" + d.nationality.replace(/\s+/g, "-") + "-" + d.Country.replace(/\s+/g, "-"); })
			.attr("cx", function(d) { return xScale(d.Year); })
			.attr("cy", function(d) { return yScale(d.Value); })
			.attr("r", 4) // Adjust the size of the circle as needed
			.attr("fill", colors[i])
			.on("mouseenter", function(event, d) {
				d3.select(this)
				.transition() // Add transition for the hover effect
				.duration(200) // Set the transition duration
				.attr("r", 8) // Increase the size of the circle on hover
				.attr("fill", "orange"); // Change the color of the circle on hover
			// Show the tooltip
			tooltip.style("opacity", 1)
				.html("Country: " + d.nationality + "<br/>Year: " + new Date(d.Year).getFullYear() + "<br/>Value: " + d.Value)
				.style("left", (event.pageX + 10) + "px")
				.style("top", (event.pageY - 10) + "px");
			})
				.on("mouseleave", function() {
					// Hide the tooltip
				tooltip.style("opacity", 0)
				d3.select(this)
				.transition() // Add transition for the hover effect
				.duration(200) // Set the transition duration
				.attr("r", 4) // Restore the size of the circle on mouseout
				.attr("fill", colors[i]); // Restore the color of the circle on mouseout

			})
			.on("click", function (event, d) {
				// Get the selected data for the clicked circle
				var selectedData = d;

				// Show the graph and text in the container div
				showGraphAndText(selectedData);
				showPieChart(selectedData);
			  });
			
			  //adding legend so the chart

			  var numColumns = 2;
			  var legendWidth = w / numColumns;
			  
			  var legend = svg
				.selectAll(".legend")
				.data(legendLabels)
				.enter()
				.append("g")
				.attr("class", "legend")
				.attr("transform", function (d, i) {
					var col = i % numColumns;
					var row = Math.floor(i / numColumns);
					var x = w + 100 + col * 220;
					var y = h / 2 - 100 + row * 50;
					return "translate(" + x + "," + y + ")";
				  });
			  
			  legend
				.append("rect")
				.attr("x", 0)
				.attr("width", 18)
				.attr("height", 18)
				.style("fill", function (d, i) {
				  return colors[i];
				});
			  
			  legend
				.append("text")
				.attr("x", 24)
				.attr("y", 9)
				.attr("dy", ".35em")
				.text(function (d) {
				  return d;
				})
				.style("font-size", "18px");





			function showGraphAndText(selectedData) {

			// Clear the infoContainer
			document.getElementById("infoContainer").innerHTML = "";

			// Create a new paragraph element for the text information
			var paragraph = document.createElement("p");
			paragraph.innerHTML = 'The Bar Graph below shows the migration pattern of people from <b>' + selectedData["nationality"] + '</b> in Australia of Year <b>' + selectedData["Year"].getFullYear() + '</b><br>';

			// Create a new div element for the wrapper
			var wrapperDiv = document.createElement("div");
			wrapperDiv.setAttribute("class", "chart-wrapper");

			// Append the paragraph to the wrapper div
			wrapperDiv.appendChild(paragraph);
			/////////////////
			// Create a new paragraph2 element for the text information
			var para2 = document.createElement("p");
			para2.innerHTML = 'The Pie Chart below shows the number of people who acquired Australian Nationality in Year <b>' + selectedData["Year"].getFullYear() + '</b><br>';

			// Create a new div element for the wrapper2
			var wrapperDiv2 = document.createElement("div");
			wrapperDiv2.setAttribute("class", "chart-wrapper2");

			// Append the paragraph to the wrapper div
			wrapperDiv2.appendChild(para2);
			////////////////
			// Create a new div element for the bar chart
			var barChartDiv = document.createElement("div");
			barChartDiv.setAttribute("id", "barChart");

			// Create a new div element for the pie chart
			var pieChartDiv = document.createElement("div");
			pieChartDiv.setAttribute("id", "pieChart");

			// Append the wrapperDiv to the infoContainer div
			document.getElementById("infoContainer").appendChild(wrapperDiv);

			

			// Append the barChartDiv to the infoContainer div
			infoContainer.appendChild(barChartDiv);
			
			// Append the wrapperDiv2 to the infoContainer div
			document.getElementById("infoContainer").appendChild(wrapperDiv2);

			// Append the pieChartDiv to the infoContainer div
			infoContainer.appendChild(pieChartDiv);


				// Process the data and create the bar chart
				d3.csv("newData.csv").then(function (data) {

					// console.log(data);
					// Filter the data based on the selected year and nationality
					var filteredData = data.filter(function (d) {
						return +d.Year === selectedData["Year"].getFullYear() &&
						d.nationality === selectedData["nationality"];
					});

					// Create the bar chart
					var margin = { top: 20, right: 20, bottom: 250, left: 120 };
					var width = 300 - margin.left - margin.right;
					var height = 500 - margin.top - margin.bottom;

					var colors = ["#e41a1c", "#377eb8", "#4daf4a", "#984ea3", "#ff7f00"];

					var colorScale = d3.scaleOrdinal()
										.range(colors);

					var tooltip2 = d3.select("body")
					.append("div")
					.attr("class", "tooltip2")
					.style("opacity", 0)
					.style("position", "absolute")
					.style("pointer-events", "none");



					var x = d3
						.scaleBand()
						.range([0, width])
						.padding(0.1);

					var y = d3.scaleLinear().range([height, 0]);


					var svg = d3
						.select("#barChart")
						.append("svg")
						.attr("width", width + margin.left + margin.right)
						.attr("height", height + margin.top + margin.bottom)
						.append("g")
						// .transition()
						// .duration(500) // Set the duration of the transition effect in milliseconds
						.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

					x.domain(filteredData.map(function (d) {
						return d.Variable;
					}));
					y.domain([0, d3.max(filteredData, function (d) {
						return +d.Value + 1000;
					})]);
					console.log(filteredData);


					svg.selectAll(".bar")
					.data(filteredData, function(d) {
						return d.Variable;
					})
					.enter()
					.append("rect")
					.attr("class", "bar")
					.attr("x", function (d) {
					  return x(d.Variable);
					})
					.attr("width", x.bandwidth())
					.attr("y", function (d) {
					  return y(+d.Value);
					})
					.attr("height", function (d) {
					  return height - y(+d.Value);
					})
					.attr("fill", function(d) { return colorScale(d.Variable); })
					.on("mouseover", function(event,d) {
						d3.select(this)
						  .attr("fill", "orange");

						// Show the tooltip
						tooltip2.style("opacity", 1)
						.html(`Value: ${filteredData.find(item => item.Variable === d.Variable).Value}`)
						.style("left", (event.pageX + 10) + "px")
						.style("top", (event.pageY - 10) + "px")
						.style("z-index", 9999); // Set a higher z-index value
					  })
					  .on("mouseout", function(d) {
						d3.select(this)
						  .attr("fill", function(d) { return colorScale(d.Variable); });

						// Hide the tooltip
						tooltip2.style("opacity", 0);
					  });


					  //XAxis

					svg.append("g")
					.attr("transform", "translate(0," + height + ")")
					.call(d3.axisBottom(x))
					.selectAll("text")
					.attr("transform", "rotate(-45)")
					.style("text-anchor", "end")
					.style("font-size", "14px");				//inc font of labels

					//Yaxis
				  	svg.append("g").call(d3.axisLeft(y).ticks(5).tickFormat(d3.format(".2s"))).style("font-size", "14px");			//inc font of labels

				  	// Custom y-axis title
					svg.append("text")
					.attr("transform", "rotate(-90)")
					.attr("y", 0 - margin.left)
					.attr("x", 0 - (height / 2))
					.attr("dy", "2em")
					.style("text-anchor", "middle")
					.style("font-weight", "bold") // Set font weight to bold
					.text("Population");



  				});
			}

			function showPieChart(selectedData){
				// Create a new div element for the bar chart
				
				var pieLegendLabels = ["Philippines", "Nepal", "New Zealand", "Pakistan", "South Africa", "United Kingdom" , "China", "India", "Hong Kong","Viet Nam", ];
				var colors = ["red", "blue", "green", "olive", "purple", "brown", "gray", "pink", "cyan", "magenta"];

				d3.csv("pieData.csv").then(function (data) {

					console.log(data);
					// Filter the data based on the selected year and nationality
					var filteredData = data.filter(function (d) {
						return +d.Year === selectedData["Year"].getFullYear() &&
						d.Variable === "Acquisition of Australian Nationality";

					});
					console.log(filteredData);

					var tooltip3 = d3.select("body")
					.append("div")
					.attr("class", "tooltip3")
					.style("opacity", 0)
					.style("position", "absolute")
					.style("pointer-events", "none");

					var width = 400;
					var height = 400;
					var margin = { top: 20, right: 140, bottom: 70, left: 40 };

					var svg = d3
						.select("#pieChart")
						.append("svg")
						.attr("width", width + margin.left + margin.right)
						.attr("height", height  + margin.bottom)
						.append("g")
						.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
      					// .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

					var radius = Math.min(width, height) / 2;
					

					 var colorScale = d3.scaleOrdinal()
						.domain(pieLegendLabels)
						.range(colors);
					var arc = d3.arc()
						  .innerRadius(0)
						  .outerRadius(radius);

					var pie = d3.pie()
						.value(d => d.Value);

					var arcs = svg.selectAll("arc")
						  .data(pie(filteredData))
						  .enter()
						  .append("g")
						  .attr("class", "arc")
						  .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
						  

						arcs.append("path")
						  .attr("d", arc)
						  .attr("fill", (d, i) => colorScale(d.data.nationality))
						  .on("mouseover", function(event,d) {
							d3.select(this)
							  .attr("fill", "orange");

							// Show the tooltip
							tooltip3.style("opacity", 1)

							.html("Nationality: " + d.data.nationality + "<br/>Value: " + d.data.Value)
							.style("left", (event.pageX + 10) + "px")
							.style("top", (event.pageY - 10) + "px")
							.style("z-index", 9999); // Set a higher z-index value
						  })
						  .on("mouseout", function(d) {
							d3.select(this).attr("fill", (d, i) => colorScale(d.data.nationality));

							// Hide the tooltip
							tooltip3.style("opacity", 0);
						  });


						
						// Append a title to the SVG
						svg.append("text")
						.attr("class", "chart-title")
						.attr("x", width / 2)
						.attr("y", height + 20)
						.style("z-index", 9999) // Set a higher z-index value
						.attr("text-anchor", "middle")
						.text('Acquisition of Australian Nationality by foreign Population in ' + selectedData["Year"].getFullYear())
						.style("font-size", "16px")
						.style("font-weight", "bold")
						// Adjust the height of the SVG to accommodate the title
						svg.attr("height", height + 20);

						var pieLegend = svg.append("g")
						.attr("class", "pie-legend")
						.attr("transform", "translate(" + (width + margin.right - 20) + "," + margin.top + ")");
				  
					  var legendItems = pieLegend.selectAll(".legend-item")
						.data(pieLegendLabels)
						.enter()
						.append("g")
						.attr("class", "legend-item")
						.attr("transform", function (d, i) {
						  return "translate(0," + i * 20 + ")";
						});
				  
					  legendItems.append("rect")
						.attr("x", 0)
						.attr("width", 18)
						.attr("height", 18)
						.style("fill", function (d, i) {
						  return colors[i];
						});
				  
					  legendItems.append("text")
						.attr("x", -6)
						.attr("y", 9)
						.attr("dy", ".35em")
						.style("text-anchor", "end")
						.text(function (d) {
						  return d;
						});
				
					});


			}



		var xAxis = d3.axisBottom() //Create the X-axis and pass in the xScale time scaling function. Axis orientation bottom.
					.scale(xScale);

		var yAxis = d3.axisLeft() //Create y-axis by passing in the time scaling function.
						.scale(yScale)
						.ticks()
						.tickFormat(d3.format(".2s"));


		svg.append("g")
			.attr("transform","translate(0, " + h +")")
			.call(xAxis)
			.style("font-size", "14px");    //inc font of labels

		svg.append("g")
			.call(yAxis)
			.style("font-size", "14px");		//inc font of labels

		// Add x-axis title
		svg.append("text")
		.attr("class", "x-axis-title")
		.attr("transform", "translate(" + (w / 2) + " ," + (h + margin.top) + ")")
		.style("text-anchor", "middle")
		.style("font-weight", "bold") // Set font weight to bold
		.text("Years");

		// Add y-axis title
		svg.append("text")
			.attr("transform", "rotate(-90)")
			.attr("y", 0 - margin.left)
			.attr("x", 0 - (h / 2))
			.attr("dy", "2em")
			.style("text-anchor", "middle")
			.style("font-weight", "bold") // Set font weight to bold
			.text("Population (in thousands)");
			
			//Add Chart title

		svg.append("text")
			.attr("class", "x-axis-title")
			.attr("transform", "translate(" + (w / 2) + " ," + (0) + ")")
			.style("text-anchor", "middle")
			.style("font-size", "20px")
			.style("font-weight", "bold") // Set font weight to bold
			.text("Inflows of immigrants in Australia");
		});
	}




}


window.onload = init;
