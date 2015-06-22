class HeadersController extends Ember.Controller

	modeler:Ember.inject.service()

	actions:
		addHeader: -> 
			block = @store.createRecord('block',{user:@session.me,rowSpan:1,colSpan:2,question:false,content:"[Add content here.]"})
		deleteBlock: (block) ->
			@modeler.destroyModel block

`export default HeadersController`