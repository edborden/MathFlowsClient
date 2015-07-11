class PageEditorComponent extends Ember.Component with Ember.Evented

	activeBlock:null

	didInsertElement: ->

		@gridstack = Ember.$(@element).children('.grid-stack').gridstack(
			auto:false
			cell_height:18
			always_show_resize_handle:true
			width:4
			float:true
			vertical_margin:9
		).data 'gridstack'

		Ember.$(@element).on 'change', =>
			@trigger 'syncBlocks'

	setActiveBlock: 'setActiveBlock'
	setInactiveBlock: 'setInactiveBlock'
	actions:
		setActiveBlock: (block) ->
			@sendAction 'setActiveBlock',block

		setInactiveBlock: (block) ->
			@sendAction 'setInactiveBlock',block

	+observer page
	onPageChange: ->
		@sendAction 'setInactiveBlock', @activeBlock

`export default PageEditorComponent`