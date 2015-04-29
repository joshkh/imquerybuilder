'use strict'

describe 'Directive: queryitem', ->

  # load the directive's module
  beforeEach module 'testApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<queryitem></queryitem>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the queryitem directive'
