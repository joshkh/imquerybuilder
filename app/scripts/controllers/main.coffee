'use strict'


###*
 # @ngdoc function
 # @name testApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the testApp
###
angular.module 'testApp'
  .controller 'MainCtrl', ($scope, myimjs, svgutils) ->


    treeData = [ {
      'name': 'Top Level'
      'parent': 'null'
      'children': [
        {
          'name': 'Level 2: A'
          'parent': 'Top Level'
          'children': [
            {
              'name': 'Son of A'
              'parent': 'Level 2: A'
            }
            {
              'name': 'Daughter of A'
              'parent': 'Level 2: A'
            }
          ]
        }
        {
          'name': 'Level 2: B'
          'parent': 'Top Level'
        }
      ]
    } ]
    # ************** Generate the tree diagram   *****************
    margin = 
      top: 20
      right: 120
      bottom: 20
      left: 120
    width = 960 - margin.right - margin.left
    height = 500 - margin.top - margin.bottom
    i = 0
    duration = 750
    root = undefined
    tree = d3.layout.tree().size([
      height
      width
    ])
    diagonal = d3.svg.diagonal().projection((d) ->
      [
        d.y
        d.x
      ]
    )
    svg = d3.select('#d3vis').append('svg').attr('width', width + margin.right + margin.left).attr('height', height + margin.top + margin.bottom).append('g').attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

    update = (source) ->
      # Compute the new tree layout.
      nodes = tree.nodes(root).reverse()
      links = tree.links(nodes)
      # Normalize for fixed-depth.
      nodes.forEach (d) ->
        d.y = d.depth * 180
        return
      # Update the nodes…
      node = svg.selectAll('g.node').data(nodes, (d) ->
        d.id or (d.id = ++i)
      )
      # Enter any new nodes at the parent's previous position.
      nodeEnter = node.enter().append('g').attr('class', 'node').attr('transform', (d) ->
        'translate(' + source.y0 + ',' + source.x0 + ')'
      ).on('click', click)
      nodeEnter.append('circle').attr('r', 1e-6).style 'fill', (d) ->
        if d._children then 'lightsteelblue' else '#fff'
      nodeEnter.append('text').attr('x', (d) ->
        if d.children or d._children then -13 else 13
      ).attr('dy', '.35em').attr('text-anchor', (d) ->
        if d.children or d._children then 'end' else 'start'
      ).text((d) ->
        d.name
      ).style 'fill-opacity', 1e-6
      # Transition nodes to their new position.
      nodeUpdate = node.transition().duration(duration).attr('transform', (d) ->
        'translate(' + d.y + ',' + d.x + ')'
      )
      nodeUpdate.select('circle').attr('r', 10).style 'fill', (d) ->
        if d._children then 'lightsteelblue' else '#fff'
      nodeUpdate.select('text').style 'fill-opacity', 1
      # Transition exiting nodes to the parent's new position.
      nodeExit = node.exit().transition().duration(duration).attr('transform', (d) ->
        'translate(' + source.y + ',' + source.x + ')'
      ).remove()
      nodeExit.select('circle').attr 'r', 1e-6
      nodeExit.select('text').style 'fill-opacity', 1e-6
      # Update the links…
      link = svg.selectAll('path.link').data(links, (d) ->
        d.target.id
      )
      # Enter any new links at the parent's previous position.
      link.enter().insert('path', 'g').attr('class', 'link').attr 'd', (d) ->
        o = 
          x: source.x0
          y: source.y0
        diagonal
          source: o
          target: o
      # Transition links to their new position.
      link.transition().duration(duration).attr 'd', diagonal
      # Transition exiting nodes to the parent's new position.
      link.exit().transition().duration(duration).attr('d', (d) ->
        o = 
          x: source.x
          y: source.y
        diagonal
          source: o
          target: o
      ).remove()
      # Stash the old positions for transition.
      nodes.forEach (d) ->
        d.x0 = d.x
        d.y0 = d.y
        return
      return

    # Toggle children on click.

    click = (d) ->
      if d.children
        d._children = d.children
        d.children = null
      else
        d.children = d._children
        d._children = null
      update d
      return

    root = treeData[0]
    root.x0 = height / 2
    root.y0 = 0
    update root
    d3.select(self.frameElement).style 'height', '500px'


    traverse = (tree) ->
      console.log "looking at ", tree
      if tree.children?
        console.log "has children"
        tree.children.push {'name': 'new', 'value': 10, 'type': "grey", "level": "red"}
        _.each tree.children, (child) ->
          traverse child 
      else
        console.log "does not have children"
        tree.children = []
        tree.children.push {'name': 'new', 'value': 10, 'type': "grey", "level": "red"}


    traverse = (tree) ->
      console.log "looking at ", tree
      if tree.children?
        console.log "has children"



        
        _.each tree.children, (child) ->
          traverse child
        tree.children.push {'name': 'new', 'value': 10, 'type': "grey", "level": "red"}
        
      else
        console.log "does not have children"
        tree.children = []
        tree.children.push {'name': 'new', 'value': 10, 'type': "grey", "level": "red"}



    $scope.addNode = ->

      console.log "adding node"

      traverse treeData[0]
      console.log "treedata is now", treeData

      # toadd =
      #   'name': 'Level 2: C'
      #   'value': 10
      #   'type': 'grey'
      #   'level': 'red'

      # treeData[0].children[0].children.push toadd
      update root


    # root = (query.select[0].split ".")[0]
    # console.log "root", root

    # width = 600
    # height = 500
    # cluster = d3.layout.cluster().size height, width-200
    # diagonal = d3.svg.diagonal().projection (d) -> [d.y, d.x]
    # svg = d3.select("#d3vis").append("svg")
    #   .attr "width", width
    #   .attr "height", height
    #   .append "g"
    #   .attr "transform", "translate(100,0)"
    # d3.json






    s = new Snap("#snapper")

    console.log svgutils

    console.log "s", s
    window.s = s

    myarr = []

    classwidth = 100
    classheight = 100
    padding = 50





    highlight = (elem) ->
      elem.attr {class: "highlight"}


    # Update the points where arrows will be drawn
    updatepoints = (elem) ->
      bbox = elem.getBBox()

      elem.inedge =
        x: bbox.x
        y: bbox.y + bbox.height / 2

      elem.outedge =
        x: bbox.x + bbox.width
        y: bbox.y + bbox.height / 2

    # Parse a path between
    parsePath = (elemFrom, elemTo) ->

      fromx = elemFrom.outedge.x
      fromy = elemFrom.outedge.y
      tox = elemTo.inedge.x
      toy = elemTo.inedge.y

      cp1x = fromx + 20
      cp1y = fromy

      cp2x = tox - 20
      cp2y = toy

      "M#{fromx},#{fromy} C#{cp1x},#{cp1y} #{cp2x},#{cp2y} #{tox},#{toy}"


    $scope.svgAddLine = ->

      console.log "myarr is", myarr

      el1 = myarr[myarr.length - 1]
      el2 = myarr[myarr.length - 2]

      connector = s.path parsePath el2, el1
      connector.attr {fill: "none", "stroke": "white", "stroke-width": 3}


    $scope.svgAddClass = ->

      # Contains our entire class
      fg = s.group()

      # Background
      rect = fg.rect 0, 0, classwidth, classheight, 8, 0
      rect.attr {class: "square"}

      # Title Background
      titlebg = fg.rect 0, 0, classwidth, 30
      titlebg.attr {class: "titlebg"}

      # Title
      title = fg.text 50, 10, "Gene"
      title.attr {"text-anchor": "middle", "dominant-baseline": "hanging", class: "title"}

      nextpos = myarr.length * (classwidth + padding)
      console.log "nextpost is", nextpos

      # Move it
      fg.transform "translate(#{nextpos}, #{nextpos})"
      updatepoints fg

      inny = (elem) ->
        console.log "i am in", elem

      outty = (elem) ->
        console.log "i am out", elem

      fg.hover inny, outty, fg, fg

      fg.click () ->
        console.log "clicked", this
        highlight this




      myarr.push fg

      do $scope.svgAddLine


    $scope.svgAddClass2 = ->

      # Contains our entire class
      fg = s.group()

      # Background
      rect = fg.rect 0, 0, classwidth, classheight, 8, 0
      rect.attr {class: "square"}

      # Title Background
      titlebg = fg.rect 0, 0, classwidth, 30
      titlebg.attr {class: "titlebg"}

      # Title
      title = fg.text 50, 10, "Gene"
      title.attr {"text-anchor": "middle", "dominant-baseline": "hanging", class: "title"}

      nextpos = myarr.length * (classwidth + padding)
      console.log "nextpost is", nextpos

      # Move it
      fg.transform "translate(#{nextpos}, 0)"
      updatepoints fg

      myarr.push fg

      do $scope.svgAddLine






    $scope.testq


    dQuery = {}
    dQuery.views = []
    dQuery.where = []
    dQuery.limit = 10

    $scope.root


    # Start with a blank query
    myimjs.query().then (query) ->
      query.root = "Gene"
      query.maxRows = 10
      query.addToSelect("symbol")
      query.addToSelect("exons.symbol")
      console.log "FINISHED", query.toXML()
      $scope.testq = query
      


    # Get our constraint options
    $scope.cardinality = ["a specific", "a list of", "all"]
    $scope.isCollapsed = false

    $scope.model = []

    $scope.root = null

    $scope.attributes = ["next"]

    $scope.runQuery = ->

      console.log "testq is", $scope.testq

      if dQuery.views.length < 1 then dQuery.views.push "*"

      imQuery = myimjs.query(dQuery);
      console.log "super query is", imQuery

      # Turn our dumb query object into a fancy IMJS query object

      dQuery.where = {symbol: 'eve'}
      
      console.log "running with query obj", dQuery

      myimjs.rows(dQuery).then (results) ->
        console.log "query results", results




    $scope.status = {isopen: false}
    myimjs.fetchModel().then (finished) ->

      console.log "retrieved model", finished

      # Store our original search item
      $scope.model = finished

      # Create a simple array from our classes
      $scope.classes = _.sortBy _.keys finished.classes, (name) -> return name

      # Classes grouped by letter
      $scope.alphabetical = _.groupBy $scope.classes, (each) -> return each.charAt 0

      # Turn the angular crank
      $scope.$apply()



    $scope.setRoot = (value) ->
      $scope.isCollapsed = !$scope.isCollapsed
      $scope.root = value
      dQuery.root = value
      # $scope.availableCollections = _.keys $scope.model.classes[value].collections
      $scope.attributes = _.keys $scope.model.classes[value].attributes

    $scope.addView = (value) ->
      console.log "adding "
      if !dQuery.views? then dQuery.views = []
      dQuery.views.push value

    pluralize = (arr) ->
      arr.map (each) -> return _.pluralize each