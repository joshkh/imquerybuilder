'use strict'

###*
 # @ngdoc service
 # @name testApp.imtools
 # @description
 # # imtools
 # Service in the testApp.
###
angular.module 'testApp'
  .service 'imtools', (myimjs, $cacheFactory, $q) ->

  	cache = $cacheFactory 'fields'

  	helpers =

  		info: (classname) ->
  			deferred = $q.defer()

  			if cache.get(classname)?
  				deferred.resolve cache.get(classname)
  			else
  				myimjs.get("model/#{classname}").then (results) ->
  					deferred.resolve results
  					cache.put results.id, results

  			deferred.promise
	

