$ ->
  $.ajax
    url: '/stats/average_lifespan_by_century'
    type: 'GET'
    async: true
    dataType: 'json'
    success: (data) ->
      margin = { top: 20, right: 20, bottom: 30, left: 40 }
      width = 960 - (margin.left) - (margin.right)
      height = 500 - (margin.top) - (margin.bottom)
      # Scales
      x = d3.scale.linear().range([0, width]).domain([0, 21])
      y = d3.scale.linear().range([height, 0]).domain([0, 100])
      # Tooltip
      tip = d3
        .tip()
        .attr('class', 'd3-tip')
        .offset([-10, 0])
        .html((d) -> "<strong>Lifespan:</strong> #{d.lifespan}")
      # Axes
      xAxis = d3.svg.axis().scale(x).orient('bottom').ticks(20)
      yAxis = d3.svg.axis().scale(y).orient('left').ticks(10)
      # Create the chart
      svg = d3
        .select('#lifespan-bar>.chart')
        .append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
      svg.call(tip)
      # Draw axes
      svg
        .append('g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + height + ')')
        .call(xAxis)
        .append('text')
        .attr('x', width / 2)
        .attr('y', 20)
        .attr('dy', '.71em')
        .style('text-anchor', 'end')
        .text('Century')
      svg
        .append('g')
        .attr('class', 'y axis')
        .call(yAxis)
        .append('text')
        .attr('transform', 'rotate(-90)')
        .attr('x', -(height / 2))
        .attr('y', -35)
        .attr('dy', '.71em')
        .style('text-anchor', 'end')
        .text('Age')
      # Draw the bars
      svg
        .selectAll('.bar')
        .data(data)
        .enter()
        .append('rect')
        .attr('class', 'bar')
        .attr('x', (d, i) -> x(d.century) - 20)
        .attr('width', 40)
        .attr('y', (d) -> y(d.lifespan))
        .attr('height', (d) -> height - y(d.lifespan))
        .on('mouseover', tip.show)
        .on('mouseout', tip.hide)
