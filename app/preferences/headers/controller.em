`import ActiveBlock from 'math-flows-client/mixins/active-block'`

class HeadersController extends Ember.Controller with ActiveBlock

	modeler:Ember.inject.service()

	actions:
		addHeader: -> 
			block = @store.createRecord('block',{user:@session.me,rowSpan:1,colSpan:2,question:false,content:""})
		deleteBlock: (block) ->
			@modeler.destroyModel block

`export default HeadersController`