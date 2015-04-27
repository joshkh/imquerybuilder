'use strict'


###*
 # @ngdoc function
 # @name testApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the testApp
###
angular.module 'testApp'
  .controller 'MainCtrl', ($scope, myimjs) ->


      # query.addConstraint


    # aquery.addToSelect ["exons"]

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