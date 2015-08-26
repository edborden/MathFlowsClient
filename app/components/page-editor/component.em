class PageEditorComponent extends Ember.Component

	eventer: Ember.inject.service()

	page: null
	pageHolder: null
	activeBlock:null
	preview:false
	headers:false

	classNameBindings: ['preview']

	didInsertElement: ->

		options =
			auto:false
			cell_height:18
			always_show_resize_handle:true
			width:4
			float:true
			vertical_margin:9

		if @preview
			options.static_grid = true
			options.always_show_resize_handle = false

		@gridstack = Ember.$(@element).children('.grid-stack').gridstack(options).data 'gridstack'

		@pageHolder = @page #after gridstack initializes CSS, set page to intialize the blocks

		Ember.$(@element).on 'change', => 
			@eventer.triggerSyncBlocks()

	setActiveBlock: 'setActiveBlock'
	setInactiveBlock: 'setInactiveBlock'
	actions:
		setActiveBlock: (block) ->
			@sendAction 'setActiveBlock',block

		setInactiveBlock: (block) ->
			@sendAction 'setInactiveBlock',block

	onPageChange: (->
		@pageHolder = @page
		@sendAction 'setInactiveBlock', @activeBlock
	).observes 'page'

`export default PageEditorComponent`