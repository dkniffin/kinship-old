$ ->

  buildWordCloud = (selector, data) ->
    words = Object.keys(data).map((k) -> { text: k, size: data[k] * 10 })
    fill = d3.scale.category20()
    layout = d3
      .layout
      .cloud()
      .size([ 960, 600 ])
      .words(words)
      .padding(5)
      .rotate((d) -> ~~(Math.random() * 2) * 90)
      .font('Impact')
      .fontSize((d) -> d.size)
      .on('end', (d) -> draw(selector, d))

    draw = (selector, words) ->
      d3
      .select("#{selector}>.chart")
      .append('svg')
      .attr('width', layout.size()[0])
      .attr('height', layout.size()[1])
      .append('g')
      .attr('transform', "translate(#{layout.size()[0] / 2},#{layout.size()[1] / 2})")
      .selectAll('text')
      .data(words)
      .enter()
      .append('text')
      .style('font-size', (d) -> "#{d.size}px")
      .style('font-family', 'Impact')
      .style('fill', (d, i) -> fill i)
      .attr('text-anchor', 'middle')
      .attr('transform', (d) -> "translate(#{[d.x, d.y]})rotate(#{d.rotate})")
      .text((d) -> d.text)

    layout.start()

  $.ajax
    url: '/stats/name_popularity'
    type: 'GET'
    async: true
    dataType: 'json'
    success: (data) ->
      buildWordCloud('#surname-word-cloud', data['last_names'])
      buildWordCloud('#firstname-word-cloud', data['first_names'])
