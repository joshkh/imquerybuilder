'use strict'

describe 'Directive: imToggle', ->

  # load the directive's module
  beforeEach module 'testApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<im-toggle></im-toggle>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the imToggle directive'
