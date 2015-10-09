`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

run = Ember.run
scheduleOnce = run.scheduleOnce

ActiveNew = Ember.Mixin.create

  didInsertElement: -> 
    @_super()
    scheduleOnce 'afterRender', @, 'handleNew'

  handleNew: ->
    if @model.isNew
      @setActiveItem @model,@
      saveModel @model

`export default ActiveNew`