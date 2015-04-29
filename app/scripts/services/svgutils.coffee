'use strict'

###*
 # @ngdoc service
 # @name testApp.svgutils
 # @description
 # # svgutils
 # Service in the testApp.
###
angular.module 'testApp'
  .service 'svgutils', ->

    destroy = (elem) ->
      console.log "destroying elem"
      # elem.remove()

    myobj =
      destroyfade: (snapelem) ->
        console.log "fading out"
        snapelem.animate {opacity: 0}, 3000, mina.bounce, destroy snapelem


    # AngularJS will instantiate a singleton by calling "new" on this function