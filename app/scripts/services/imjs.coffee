'use strict'

###*
 # @ngdoc service
 # @name testApp.imjs
 # @description
 # # imjs
 # Service in the testApp.
###
angular.module 'testApp'
  .service 'myimjs', ->
  	flymine = new imjs.Service {root: "beta.flymine.org/query"}
    # AngularJS will instantiate a singleton by calling "new" on this function
