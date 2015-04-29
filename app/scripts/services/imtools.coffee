'use strict'

###*
 # @ngdoc service
 # @name testApp.imtools
 # @description
 # # imtools
 # Service in the testApp.
###
angular.module 'testApp'
  .service 'imtools', (myimjs, $cacheFactory) ->

  	cache = $cacheFactory 'fields'

  	helpers =
  		info: (classname) ->

  			# Return the cached version if we have it.
  			if cache.get(classname)?
  				console.log "FOUND IN CACHE"
  				return cache.get(classname)
  			else
  				console.log "NOT FOUND IN CACHE"

	  			# Otherwise run and store
			  	myimjs.get("model/#{classname}").then (results) ->
			  		cache.put results.id, results
			  		results




    # AngularJS will instantiate a singleton by calling "new" on this function
