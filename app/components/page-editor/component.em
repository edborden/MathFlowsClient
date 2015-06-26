class PageEditorComponent extends Ember.Component with Ember.Evented

	classNames: ['grid-stack']

	blockBeingDragged: false

	didInsertElement: ->

		syncChangedBlocks = Ember.run.bind @,@syncChangedBlocks
		setBlockBeingDragged = Ember.run.bind @,@setBlockBeingDragged

		@gridstack = Ember.$(@element).children('.grid-stack').gridstack(
			auto:false
			cell_height:18
			always_show_resize_handle:true
			height:27
			width:4
			float:true
			vertical_margin:9
		).data 'gridstack'

		Ember.$(@element).on 'change', =>
			@trigger 'syncBlocks'

`export default PageEditorComponent`