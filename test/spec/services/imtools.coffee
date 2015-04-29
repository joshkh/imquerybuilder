'use strict'

describe 'Service: imtools', ->

  # load the service's module
  beforeEach module 'testApp'

  # instantiate service
  imtools = {}
  beforeEach inject (_imtools_) ->
    imtools = _imtools_

  it 'should do something', ->
    expect(!!imtools).toBe true
