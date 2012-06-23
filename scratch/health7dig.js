function projectPosition(d) { return d.projectPosition * 100; }
function numberOfFeatures(d) { return d.numberOfFeatures.length * 50; }
function numberOfFixedBugs(d) { return d.fixedBugs.length * 50; }

var month = 0;

draw(months[month]);

function draw(month) {
    
    var len = month.length

    for (var index = 0; index < len; index++) {
   
     var project = month[index];
          
     var features = svg.append("g")
        .selectAll("project")
        .data(project.numberOfFeatures) 
        .enter()
        .append("rect")
        .style("fill", function() { return "#225533" } )
        .attr("x", function(d) { return projectPosition(project) } )
        .attr("y", function(d) { return height - numberOfFeatures(project) } )
        .attr("width", 60)
        .attr("height", function(d) { return numberOfFeatures(project) });
     
     svg.append("g")
        .selectAll("bug")
        .data(project.fixedBugs)
        .enter()
        .append("rect")
        .style("fill",function(){ return "#44bbcc";})
        .attr("x", function(d) { return projectPosition(project)}) 
        .attr("y", function(d) { return (height - (numberOfFeatures(project) + numberOfFixedBugs(project) )) } )
        .attr("width", 60)
        .attr("height", function(d) { return numberOfFixedBugs(project) });
    
    svg.append("g")
        .selectAll("bug")
        .data(project.unfixedBugs)
        .enter()
        .append("circle")
        .style("fill",function(){ return "red";})
        .attr("cx", function(d) { return projectPosition(project) + 30}) 
        .attr("cy", function(d) { return (height - (numberOfFeatures(project) + numberOfFixedBugs(project))) - project.unfixedBugs.indexOf(d) * 40 - 20} )
        .attr("r", 15); 
  }
  
}
  
function redraw() {
   
   month++;
   draw(months[month])
   //would put the transition in here

}

setInterval(function() {
  redraw();
}, 1500);



