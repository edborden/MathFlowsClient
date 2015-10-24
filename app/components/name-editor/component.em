`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class NameEditorComponent extends Ember.Component

  ## ATTRIBUTES

  tagName: 'span'
  size:14
  model:null
  isEditingName:null
  handleNameClick: true

  action: 'doneEditingName'
  nameClicked: 'nameClicked'

  ## EVENTS

  onIsEditingNameChange: Ember.observer 'isEditingName', ->
    Ember.run.next @, =>
      if @isEditingName
        input = Ember.$(@element).children().first()
        @setKeyDownHandler input
        input.focus()

  focusOut: ->
    @removeKeyDownHandler()
    saveModel @model
    @sendAction()

  ## ACTIONS

  actions:
    nameClicked: -> 
      @sendAction 'nameClicked' if @handleNameClick

  ## HELPERS

  setKeyDownHandler: (el) ->
    onKeyDown = Ember.run.bind @,@onKeyDown
    el.on 'keydown',onKeyDown

  onKeyDown: (ev) ->
    @focusOut() if ev.keyCode is 13 #enter

  removeKeyDownHandler: ->
    input = Ember.$(@element).children().first()
    input.off 'keydown', '**'

`export default NameEditorComponent`