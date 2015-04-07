class HeadersController extends Ember.Controller

	actions:
		addHeader: -> 
			@store.createRecord('block',{user:@model,rowSpan:1,colSpan:2,question:false})
		deleteBlock: (block) ->
			block.destroyRecord()
		registerEditor: (editor) ->
			@editor = editor

	editor: null #PageEditor instance, not used here

`export default HeadersController`