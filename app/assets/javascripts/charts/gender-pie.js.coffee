$ ->
  r = 100
  w = 2 * r
  h = 300
  l = w / 2
  # builtin range of colors
  color = d3.scale.category20c()
  $.ajax
    url: '/stats/gender_distribution'
    type: 'GET'
    async: true
    dataType: 'json'
    success: (data) ->
      d3_data = [
        { 'label': "Male (#{data.male})", 'value': data.male },
        { 'label': "Female (#{data.female})", 'value': data.female }
      ]
      # move the center of the pie chart from 0, 0 to l, r
      vis = d3
        .select('#gender-pie>.chart')
        .append('svg:svg')
        .data([ d3_data ])
        .attr('width', w)
        .attr('height', h)
        .append('svg:g')
        .attr('transform', 'translate(' + l + ',' + r + ')')
      arc = d3.svg.arc().outerRadius(r)
      # we must tell it how to access the value of each element in our data array
      pie = d3.layout.pie().value((d) ->
        d.value
      )
      # allow us to style things in the slices (like text)
      arcs = vis
        .selectAll('g.slice')
        .data(pie)
        .enter()
        .append('svg:g')
        .attr('class', 'slice')
      # this creates the SVG path using the associated data (pie) with the arc drawing function
      arcs.append('svg:path').attr('fill', (d, i) ->
        color i
      ).attr 'd', arc
      arcs.append('svg:text').attr('transform', (d) ->
        # set the label's origin to the center of the arc
        # we have to make sure to set these before calling arc.centroid
        d.innerRadius = 0
        d.outerRadius = r
        # this gives us a pair of coordinates like [50, 50]
        'translate(' + arc.centroid(d) + ')'
      ).attr('text-anchor', 'middle').text (d, i) ->
        # get the label from our original data array
        d3_data[i].label
