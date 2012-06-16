// Various accessors that specify the four dimensions of data to visualize.
function projectPosition(d) { return d.projectPosition * 100; }
function numberOfFeatures(d) { return d.numberOfFeatures; }
function greenBugs(d) { return d.fixedBugs; }
function redBugs(d) { return d.unfixedBugs; }

// Chart dimensions.
var margin = {top: 19.5, right: 19.5, bottom: 19.5, left: 39.5},
    width = 960 - margin.right,
    height = 500 - margin.top - margin.bottom;

// Various scales. These domains make assumptions of data, naturally.
var xScale = d3.scale.linear().domain([0, 4]).range([0, width]), 
    yScale = d3.scale.linear().domain([0, 26]).range([height, 0]),
    radiusScale = d3.scale.sqrt().domain([0, 5e8]).range([0, 40]),
    colorScale = d3.scale.category10();

// The x & y axes.
var xAxis = d3.svg.axis().orient("bottom").scale(xScale).ticks(12, d3.format(",d")),
    yAxis = d3.svg.axis().scale(yScale).orient("left");

// Create the SVG container and set the origin.
var svg = d3.select("#chart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Add the x-axis.
svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

// Add the y-axis.
svg.append("g")
    .attr("class", "y axis")
    .call(yAxis);

// Add an x-axis label.
svg.append("text")
    .attr("class", "x label")
    .attr("text-anchor", "end")
    .attr("x", width)
    .attr("y", height - 6)
    .text("time spent on features");

// Add a y-axis label.
svg.append("text")
    .attr("class", "y label")
    .attr("text-anchor", "end")
    .attr("y", 6)
    .attr("dy", ".75em")
    .attr("transform", "rotate(-90)")
    .text("number of completed features");

// Add the year label; the value is set on transition.
var label = svg.append("text")
    .attr("class", "year label")
    .attr("text-anchor", "end")
    .attr("y", height - 24)
    .attr("x", width);

draw(projects);

function draw(projects) {

    var project = svg.append("g")
        .selectAll("project")
        .data(projects)
        .enter()
        .append("rect")
        .style("fill", "blue")
        .call(bar)
     
    var len = projects.length
    for (var index = 0; index < len; index++) {
   
   //do the bar work in here as well so can position them together
     
     var project = projects[index];
      
     svg.append("g")
        .selectAll("bug")
        .data(project.fixedBugs)
        .enter()
        .append("circle")
        .style("fill",function(){ return "green";})
        .attr("cx", function(d) { return projectPosition(project) }) 
        .attr("cy", function(d) { return d*30 } )
        .attr("r", 10);
    
    svg.append("g")
        .selectAll("bug")
        .data(project.unfixedBugs)
        .enter()
        .append("circle")
        .style("fill",function(){ return "red";})
        .attr("cx", function(d) { return projectPosition(project) + 10}) 
        .attr("cy", function(d) { return d*40 } )
        .attr("r", 10);


        
/*        .
        
        
        call(bugs);

  `dunction bugs(bug) {
    console.log("bug" + bug)
    bug 
    .attr("cx", function(d) { return project*30 }) 
      .attr("cy", function(d) { return d*30 } )
        .attr("r", 10);
  }*/


   }

}

  function bar(project) {
    project .attr("x", function(d) {return projectPosition(d) } )
        .attr("y", function(d) { return height - numberOfFeatures(d) } )
        .attr("width", 60)
        .attr("height", function(d) { return numberOfFeatures(d) });
    }


/*
  function position(dot) {
    dot .attr("cx", function(d) { return xScale(x(d)); })
        .attr("cy", function(d) { return yScale(y(d)); })
        .attr("r", function(d) { return radiusScale(radius(d)); });
  }
/*

  // Defines a sort order so that the smallest dots are drawn on top.
  function order(a, b) {
    return radius(b) - radius(a);
  }
/*
  // After the transition finishes, you can mouseover to change the year.
  function enableInteraction() {
    var box = label.node().getBBox();

    var yearScale = d3.scale.linear()
        .domain([1800, 2009])
        .range([box.x + 10, box.x + box.width - 10])
        .clamp(true);

    svg.append("rect")
        .attr("class", "overlay")
        .attr("x", box.x)
        .attr("y", box.y)
        .attr("width", box.width)
        .attr("height", box.height)
        .on("mouseover", mouseover)
        .on("mouseout", mouseout)
        .on("mousemove", mousemove)
        .on("touchmove", mousemove);

    function mouseover() {
      label.classed("active", true);
    }

    function mouseout() {
      label.classed("active", false);
    }

    function mousemove() {
      displayYear(yearScale.invert(d3.mouse(this)[0]));
    }
  }
*/ 

/*
  // Tweens the entire chart by first tweening the year, and then the data.
  // For the interpolated data, the dots and label are redrawn.
  function tweenYear() {
    var year = d3.interpolateNumber(1800, 2009);
    return function(t) { displayYear(year(t)); };
  }

  // Updates the display to show the specified year.
  function displayYear(year) {
    dot.data(interpolateData(year), key).call(position).sort(order);
    //label.text(Math.round(year));
  }

  // Interpolates the dataset for the given (fractional) year.
  function interpolateData(year) {
    return nations.map(function(d) {
      return {
        name: d.name,
        region: d.region,
        income: interpolateValues(d.income, year),
        population: interpolateValues(d.population, year),
        lifeExpectancy: interpolateValues(d.lifeExpectancy, year)
      };
    });
  }

  // Finds (and possibly interpolates) the value for the specified year.
  function interpolateValues(values, year) {
    var i = bisect.left(values, year, 0, values.length - 1),
        a = values[i];
    if (i > 0) {
      var b = values[i - 1],
          t = (year - a[0]) / (b[0] - a[0]);
      return a[1] * (1 - t) + b[1] * t;
    }
    return a[1];
  }
}; */
