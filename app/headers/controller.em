class HeadersController extends Ember.Controller

	actions:
		addHeader: -> 
			block = @store.createRecord('block',{user:@session.me,rowSpan:1,colSpan:2,question:false,content:"[Add content here.]"})
			@session.me.stableBlocks.addObject block
		deleteBlock: (block) ->
			block.destroyRecord()

`export default HeadersController`