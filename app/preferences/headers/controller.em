`import ActiveBlock from 'math-flows-client/mixins/active-block'`

class HeadersController extends Ember.Controller with ActiveBlock

	modeler:Ember.inject.service()

	actions:
		addHeader: -> 
			block = @store.createRecord 'block',{user:@session.me,rowSpan:1,colSpan:2,kind:"header"}
			Ember.run.next @, => @send 'setActiveBlock',block
		destroyHeader: ->
			@modeler.destroyModel @activeBlock
			@activeBlock = null

`export default HeadersController`