'use strict'

###*
 # @ngdoc directive
 # @name testApp.directive:queryitem
 # @description
 # # queryitem
###
angular.module 'testApp'
  .directive 'queryitem', ($rootScope) ->
    restrict: 'EA'
    # template: '<div></div>'
    templateUrl: 'tpl.html'
    link: (scope, element, attrs) ->
      console.log "rootscope is", scope.test
      element.text "HELLO"
