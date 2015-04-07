`import ElRegister from 'math-flows-client/mixins/el-register'`

class PageEditorComponent extends Ember.Component with ElRegister

	page: null

	cols: ~> 4
	widgetMargin: ~> 9 / 2
	widgetBaseWidth: ~> 128.25
	widgetBaseHeight: ~> 18
	height: ~> 11 * 72 #11 inches
	width: ~> 8.5 * 72 #8.5 inches
	padding: ~> (0.5 * 72) - (9 / 2)

	classNames: ['grid-editor','gridster']
	gridster: null

	attributeBindings: ['style']
	style: ~> "height:#{@height}px;width:#{@width}px;padding:#{@padding}px;"

	didInsertElement: ->
		@_super()
		@gridster = Ember.$(@element).children().first().gridster(
			widget_margins: [@widgetMargin,@widgetMargin],
			widget_base_dimensions: [@widgetBaseWidth, @widgetBaseHeight]
			max_cols: @cols
			min_cols: @cols
			resize: 
				enabled: true
				stop: @runSync
			draggable:
				stop: @runSync
		).data 'gridster'
		@sendAction 'registerEditor',@

	#setUnpositionedWidgets: ->
	#	@unpositionedWidgets.forEach (el) =>
	#		view = Ember.$(el).data('emberObject')
	#		model = view.block
	#		next = @gridster.next_position parseInt(model.colSpan),parseInt(model.rowSpan)
	#		@gridster.mutate_widget_in_gridmap Ember.$(el),view.coords,next


	#+volatile
	#unpositionedWidgets: -> 
	#	@widgetElArray.reject (el) ->
	#		model = Ember.$(el).data('emberObject').position
	#		model.row? and model.col?

	runSync: ->
		obj = Ember.$(".grid-editor").data 'emberObject'
		obj.syncChangedBlocks().then -> obj.page.test.refreshQuestionNumbers()
				
	syncChangedBlocks: ->
		promiseArray = []
		for diffWidget in @widgetsDiff 
			obj = Ember.$(diffWidget).data 'emberObject'
			promiseArray.push obj.syncAttrsToEl()
		return Ember.RSVP.all promiseArray

	+volatile
	widgetElArray: -> Ember.A $.makeArray Ember.$('.gs-w')

	# Block elements that are different from their models
	+volatile
	widgetsDiff: -> 
		@widgetElArray.filter (el) =>
			obj = Ember.$(el).data('emberObject').block
			@widthIsDiff(el,obj) or @heightIsDiff(el,obj) or @rowIsDiff(el,obj) or @colIsDiff(el,obj)
			
	widthIsDiff: (el,obj) -> obj.colSpan isnt parseInt $(el).attr('data-sizex')
	heightIsDiff: (el,obj) -> obj.rowSpan isnt parseInt $(el).attr('data-sizey')
	rowIsDiff: (el,obj) -> obj.row isnt parseInt $(el).attr('data-row')
	colIsDiff: (el,obj) -> obj.col isnt parseInt $(el).attr('data-col')

	deleteBlock: 'deleteBlock'
	deleteImage: 'deleteImage'
	toggleNumber: 'toggleNumber'
	addImage: 'addImage'
	openModal: 'openModal'
	registerEditor: 'registerEditor'
	actions:
		deleteBlock: (block) ->
			@sendAction 'deleteBlock',block
			@page.document.refreshQuestionNumbers()
		deleteImage: (block) ->
			@sendAction 'deleteImage',block
		toggleNumber: (block) ->
			@sendAction 'toggleNumber',block
		addImage: (params) ->
			@sendAction 'addImage',params
		openGraphModal: (block) ->
			@sendAction 'openModal','modal/graph',block

`export default PageEditorComponent`