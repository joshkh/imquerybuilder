'use strict'

describe 'Service: svgutils', ->

  # load the service's module
  beforeEach module 'testApp'

  # instantiate service
  svgutils = {}
  beforeEach inject (_svgutils_) ->
    svgutils = _svgutils_

  it 'should do something', ->
    expect(!!svgutils).toBe true
