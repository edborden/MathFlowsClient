`import modeler from 'math-flows-client/utils/modeler'`
destroyModel = modeler.destroyModel

DestroyBlock = Ember.Mixin.create
  
  actions:
    destroyBlock: ->
      @setActiveItem null
      destroyModel @block
      @page.notifyPropertyChange 'invalidBlocks' if @page?
      @page.refreshQuestionNumbers()

`export default DestroyBlock`