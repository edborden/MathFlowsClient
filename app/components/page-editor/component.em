computed = Ember.computed
alias = computed.alias
service = Ember.inject.service
scheduleOnce = Ember.run.scheduleOnce
observer = Ember.observer

class PageEditorComponent extends Ember.Component

	# ATTRIBUTES

	page: null
	activeItem:null
	preview:false
	headers:false
	classNameBindings: ['preview']
	gridstack: null
	
	# SERVICES

	eventer: service()

	# COMPUTED

	staticGrid: alias 'preview'
	alwaysShowResizeHandle: computed.not 'preview'
	gridstackOptions: computed -> 
		auto:false
		cell_height:18
		width:4
		float:true
		vertical_margin:9
		static_grid: @staticGrid
		always_show_resize_handle: @alwaysShowResizeHandle
	pageHolder: computed 'page', 'gridstack', ->
		if @gridstack? then @page else null

	# SETUP

	didInsertElement: -> scheduleOnce 'afterRender', @, 'setupGridstack'

	setupGridstack: ->
		@gridstack = Ember.$(@element).children('.grid-stack').gridstack(@gridstackOptions).data 'gridstack'
		Ember.$(@element).on 'change', => 
			@eventer.triggerSyncBlocks()

	# BREAKDOWN

	willDestroyElement: ->
		@gridstack.destroy()
		Ember.$(@element).off 'change','**'

	# ACTIONS

	onPageChange: observer 'page', ->
		@setActiveItem null

`export default PageEditorComponent`