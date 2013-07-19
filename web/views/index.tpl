<!DOCTYPE html>
<meta charset="utf-8">
<style>

body{
  font-family: "Trebuchet MS", Helvetica, sans-serif;
}

.progress-meter .background {
  fill: #ccc;
}

.progress-meter .foreground {
  fill: #000;
}

.progress-meter text {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 24px;
  font-weight: bold;
}

#title{
  font-size: 30px;
  float: left;
  width: auto;
  font-weight: bolder;
}

</style>
<body>
<div id="title">Cheetah is Running...</div>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

var width = 960,
    height = 500,
    twoPi = 2 * Math.PI,
    progress = 0,
    total = 1308573, // must be hard-coded if server doesn't report Content-Length
    formatPercent = d3.format(".0%");

var arc = d3.svg.arc()
    .startAngle(0)
    .innerRadius(180)
    .outerRadius(240);

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

var meter = svg.append("g")
    .attr("class", "progress-meter");

meter.append("path")
    .attr("class", "background")
    .attr("d", arc.endAngle(twoPi));

var foreground = meter.append("path")
    .attr("class", "foreground");

var text = meter.append("text")
    .attr("text-anchor", "middle")
    .attr("dy", ".35em");

// d3.json("https://api.github.com/repos/mbostock/d3/git/blobs/2e0e3b6305fa10c1a89d1dfd6478b1fe7bc19c1e?" + Math.random())
//     .on("progress", function() {
//       var i = d3.interpolate(progress, d3.event.loaded / total);
//       d3.transition().tween("progress", function() {
//         return function(t) {
//           progress = i(t);
//           foreground.attr("d", arc.endAngle(twoPi * progress));
//           text.text(formatPercent(progress));
//         };
//       });
//     })
//     .get(function(error, data) {
//       meter.transition().delay(250).attr("transform", "scale(0)");
//     });

setInterval(function(){
  d3.json('http://localhost:8081/fetch?'+Math.random(), function(data){
    var pro = parseInt(data);
    if(pro === 100){
      window.location.href = 'http://localhost:8081/result';
    }
    var i = d3.interpolate(progress, pro/100);
    d3.transition().tween("progress", function() {
       return function(t) {
        progress = i(t);
        foreground.attr("d", arc.endAngle(twoPi * progress));
        text.text(formatPercent(progress));
       };
    });
  });
}, 5000);

// d3.xhr('http://localhost:8080/', function(data){
//   console.log(data.response);
// });

// meter.transition().delay(250).attr("transform", "scale(0)");

</script>
