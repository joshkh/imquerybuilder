'use strict'

describe 'Service: imjs', ->

  # load the service's module
  beforeEach module 'testApp'

  # instantiate service
  imjs = {}
  beforeEach inject (_imjs_) ->
    imjs = _imjs_

  it 'should do something', ->
    expect(!!imjs).toBe true
