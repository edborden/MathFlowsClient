class HeadersController extends Ember.Controller

	actions:
		addHeader: -> 
			pos = @store.createRecord('position',{user:@model,rowSpan:1,colSpan:2,question:false})
			@model.stableHeaders.addObject pos
		deleteBlock: (block) ->
			block.positions.forEach (position) -> 
				position.user.stableHeaders.removeObject position
				position.deleteRecord() #doesn't save deletion, happens on backend
			block.destroyRecord()
		registerEditor: (editor) ->
			@editor = editor

	editor: null #PageEditor instance, not used here

`export default HeadersController`