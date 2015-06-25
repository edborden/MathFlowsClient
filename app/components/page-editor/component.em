class PageEditorComponent extends Ember.Component with Ember.Evented

	classNames: ['grid-stack']

	blockBeingDragged: false

	didInsertElement: ->

		syncChangedBlocks = Ember.run.bind @,@syncChangedBlocks
		setBlockBeingDragged = Ember.run.bind @,@setBlockBeingDragged

		@gridstack = Ember.$(@element).children('.grid-stack').gridstack(
			auto:false
			cell_height:18
			#height:27
			width:4
			float:true
			vertical_margin:9
		).data 'gridstack'

		@blocks = @page.blocks

		#Ember.run.next @,syncChangedBlocks #account for blocks that will move up automatically if empty space above them
		
	didUpdateAttrs: ->
		@blocks = @page.blocks

	syncChangedBlocks: ->
		@blockBeingDragged = false
		@trigger 'syncIfOutOfSync'

	setBlockBeingDragged: -> @blockBeingDragged = true

`export default PageEditorComponent`