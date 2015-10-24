HandlesDragging = Ember.Mixin.create

  somethingIsDragging: null
  thisSomethingIsDragging: 'thisSomethingIsDragging'
  nothingIsDragging: 'nothingIsDragging'
  drop: 'drop'

  actions:
    thisSomethingIsDragging: (something) ->
      @sendAction 'thisSomethingIsDragging',something
    nothingIsDragging: -> @sendAction 'nothingIsDragging'
    drop: (object,options) ->
      @sendAction 'drop',object,options

`export default HandlesDragging`