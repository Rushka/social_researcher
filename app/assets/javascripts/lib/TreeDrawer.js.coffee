$ ->
  treeData = 
    name: '/'
    contents: [
      {
        name: 'Applications'
        contents: [
          { name: 'Mail.app' }
          { name: 'iPhoto.app' }
          { name: 'Keynote.app' }
          { name: 'iTunes.app' }
          { name: 'XCode.app' }
          { name: 'Numbers.app' }
          { name: 'Pages.app' }
        ]
      }
      {
        name: 'System'
        contents: []
      }
      {
        name: 'Library'
        contents: [
          {
            name: 'Application Support'
            contents: [
              { name: 'Adobe' }
              { name: 'Apple' }
              { name: 'Google' }
              { name: 'Microsoft' }
            ]
          }
          {
            name: 'Languages'
            contents: [
              { name: 'Ruby' }
              { name: 'Python' }
              { name: 'Javascript' }
              { name: 'C#' }
            ]
          }
          {
            name: 'Developer'
            contents: [
              { name: '4.2' }
              { name: '4.3' }
              { name: '5.0' }
              { name: 'Documentation' }
            ]
          }
        ]
      }
      {
        name: 'opt'
        contents: []
      }
      {
        name: 'Users'
        contents: [
          { name: 'pavanpodila' }
          { name: 'admin' }
          { name: 'test-user' }
        ]
      }
    ]

  visit = (parent, visitFn, childrenFn) ->
    if !parent
      return
    visitFn parent
    children = childrenFn(parent)
    if children
      count = children.length
      i = 0
      while i < count
        visit children[i], visitFn, childrenFn
        i++
    return

  buildTree = (containerName, customOptions) ->
    # build the options object
    options = $.extend({
      nodeRadius: 5
      fontSize: 12
    }, customOptions)
    # Calculate total nodes, max label length
    totalNodes = 0
    maxLabelLength = 0
    visit treeData, ((d) ->
      totalNodes++
      maxLabelLength = Math.max(d.name.length, maxLabelLength)
      return
    ), (d) ->
      if d.contents and d.contents.length > 0 then d.contents else null
    # size of the diagram
    size = 
      width: $(containerName).outerWidth()
      height: totalNodes * 15
    tree = d3.layout.tree().sort(null).size([
      size.height
      size.width - (maxLabelLength * options.fontSize)
    ]).children((d) ->
      if !d.contents or d.contents.length == 0 then null else d.contents
    )
    nodes = tree.nodes(treeData)
    links = tree.links(nodes)

    ###
        <svg>
            <g class="container" />
        </svg>
    ###

    layoutRoot = d3.select(containerName).append('svg:svg').attr('width', size.width).attr('height', size.height).append('svg:g').attr('class', 'container').attr('transform', 'translate(' + maxLabelLength + ',0)')
    # Edges between nodes as a <path class="link" />
    link = d3.svg.diagonal().projection((d) ->
      [
        d.y
        d.x
      ]
    )
    layoutRoot.selectAll('path.link').data(links).enter().append('svg:path').attr('class', 'link').attr 'd', link

    ###
        Nodes as
        <g class="node">
            <circle class="node-dot" />
            <text />
        </g>
    ###

    nodeGroup = layoutRoot.selectAll('g.node').data(nodes).enter().append('svg:g').attr('class', 'node').attr('transform', (d) ->
      'translate(' + d.y + ',' + d.x + ')'
    )
    nodeGroup.append('svg:circle').attr('class', 'node-dot').attr 'r', options.nodeRadius
    nodeGroup.append('svg:text').attr('text-anchor', (d) ->
      if d.children then 'end' else 'start'
    ).attr('dx', (d) ->
      gap = 3 * options.nodeRadius
      if d.children then -gap else gap
    ).attr('dy', 3).text (d) ->
      d.name
    return

  buildTree("#tree-container");