'use strict'


###*
 # @ngdoc function
 # @name testApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the testApp
###
angular.module 'testApp'
  .controller 'MainCtrl', ($scope, myimjs, svgutils, imtools) ->

    $scope.tree = Array {name: "Gene", nodes: []}






    $scope.test = ->
      imtools.info("Protein").then (resolved) ->
        console.log "resolved inside test", resolved

      # console.log "imtools", imtools.drill("Protein").then (result) ->
      #   _.filter result.fields, {fields: true}


    $scope.delete = (data) -> data.nodes = []

    $scope.add = (data, next) ->
      console.log "---1 called with", data
      console.log "---2 also with ", next
      post = data.nodes.length + 1
      newName = data.name + "-" + post
      data.nodes.push {name: next, nodes: []}
    

    $scope.addView = (value) ->
      console.log "addView: ", value
      if imjquery.views? then imquery.views = []

      dQuery.views.push value

    $scope.setRoot = (value) ->
      $scope.isCollapsed = !$scope.isCollapsed
      $scope.root = value
      imquery.root = value
      $scope.attributes = _.keys $scope.model.classes[value].attributes

      # $scope.availableCollections = _.keys $scope.model.classes[value].collections

    $scope.getCollections = (item) ->
      console.log "getCollections called with", item
      # imtools.drill(item).then (result) ->
      #   _.filter result.fields, {fields: true}
     

    # Get our constraint options
    $scope.cardinality = ["a specific", "a list of", "all"]
    $scope.isCollapsed = false

    $scope.model = []


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


    pluralize = (arr) ->
      arr.map (each) -> return _.pluralize each