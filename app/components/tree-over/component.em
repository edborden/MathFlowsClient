`import HandlesDragging from 'math-flows-client/mixins/handles-dragging'`
`import ElRegister from 'math-flows-client/mixins/el-register'`
`import TreeObjects from 'math-flows-client/mixins/tree-objects'`

computed = Ember.computed
alias = computed.alias
equal = computed.equal

class TreeOverComponent extends Ember.Component with HandlesDragging,ElRegister,TreeObjects

  # ATTRIBUTES

  model: null
  static: null
  mouseOver: false
  isEditingName: false
  dragging: false
  activeObj: null
  nameClicked: null
  classNameBindings: ['static','active','showMenu']
  indented: false

  # COMPUTED

  showMenu: computed 'isEditingName','mouseOver','dragging','somethingIsDragging', -> 
    showMenu = not @isEditingName and @mouseOver and not @dragging and not @somethingIsDragging
    if showMenu and @static and @model.isTest
      true
    else if showMenu and @static
      false
    else if showMenu
      true
    else
      false

  active: computed 'activeObj', -> @activeObj is @model

  # SETUP

  didInsertElement: ->
    @_super()
    @makeDraggable() unless @static

  # BREAKDOWN

  destroyDraggable: ->
    Ember.$(@element).draggable 'destroy'   

  # ACTIONS

  mouseEnter: -> 
    @mouseOver = true
    false
  mouseLeave: ->
    @mouseOver = false

  actions:
    toggle: -> 
      @model.toggleProperty 'open'
      @model.save() if @model.isFolder and not @static
    sendEditObj: ->
      @sendAction 'editObj',@model,@static
    editName: ->
      unless @static
        @destroyDraggable()
        @isEditingName = true
        false
    doneEditingName: ->
      @makeDraggable()
      @isEditingName = false  

  # HELPERS

  makeDraggable: ->
    Ember.$(@element).draggable
      revert: true 
      start: =>
        @dragging = true
        @sendAction 'thisSomethingIsDragging',@
      stop: =>
        unless @isDestroyed
          @dragging = false
          @sendAction 'nothingIsDragging'
          @makeDraggable() #must re-initialize, otherwise can only drag once

`export default TreeOverComponent`