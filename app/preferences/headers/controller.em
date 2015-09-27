`import ActiveBlock from 'math-flows-client/mixins/active-block'`
`import modeler from 'math-flows-client/utils/modeler'`
destroyModel = modeler.destroyModel

class HeadersController extends Ember.Controller with ActiveBlock

	actions:
		addHeader: -> 
			block = @store.createRecord 'block',{user:@session.me,rowSpan:1,colSpan:2,kind:"header"}
			Ember.run.next @, => @send 'setActiveBlock',block
		destroyHeader: ->
			destroyModel @activeBlock
			@activeBlock = null

`export default HeadersController`