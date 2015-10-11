`import ActiveSetter from 'math-flows-client/mixins/active-setter'`
`import modeler from 'math-flows-client/utils/modeler'`
destroyModel = modeler.destroyModel

class HeadersController extends Ember.Controller with ActiveSetter

  actions:
    addHeader: -> 
      @store.createRecord 'block',{user:@session.me,rowSpan:1,colSpan:2,kind:"header"}

    destroyHeader: ->
      header = @activeItem
      @send 'setActiveItem', null
      destroyModel header

`export default HeadersController`