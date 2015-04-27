'use strict'

###*
 # @ngdoc directive
 # @name testApp.directive:imToggle
 # @description
 # # imToggle
###
angular.module 'testApp'
  .directive 'imToggle', ->
    restrict: 'E',
    transclude: true,
    compile: (elem, attrs, transclude) ->
      console.log elem