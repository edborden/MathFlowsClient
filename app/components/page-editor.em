`import ElRegister from 'math-flows-client/mixins/el-register'`

class PageEditorComponent extends Ember.Component with ElRegister

	page: null
	action: "editBlock"

	pageLayout: ~> @page.layout

	cols: ~> @pageLayout.cols
	widgetMargin: ~> @pageLayout.gridsterInsideMargin
	widgetBaseWidth: ~> @pageLayout.colWidth
	widgetBaseHeight: ~> @pageLayout.rowHeight
	height: ~> @pageLayout.height
	width: ~> @pageLayout.width
	padding: ~> @pageLayout.gridsterOutsideMargin

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
		@setUnpositionedWidgets()

	setUnpositionedWidgets: ->
		@unpositionedWidgets.forEach (el) =>
			view = Ember.$(el).data('emberObject')
			model = view.position
			next = @gridster.next_position parseInt(model.colSpan),parseInt(model.rowSpan)
			@gridster.mutate_widget_in_gridmap Ember.$(el),view.coords,next
			view.syncAttrsToEl().then => @rerender()

	+volatile
	unpositionedWidgets: -> 
		@widgetElArray.reject (el) ->
			model = Ember.$(el).data('emberObject').position
			model.row? and model.col?

	runSync: ->
		obj = Ember.$(".grid-editor").data 'emberObject'
		obj.syncChangedBlocks().then -> 
			obj.page.document.refreshQuestionNumbers()
			obj.rerender()
				
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
			obj = Ember.$(el).data('emberObject').position
			@widthIsDiff(el,obj) or @heightIsDiff(el,obj) or @rowIsDiff(el,obj) or @colIsDiff(el,obj)
			
	widthIsDiff: (el,obj) -> obj.colSpan isnt parseInt $(el).attr('data-sizex')
	heightIsDiff: (el,obj) -> obj.rowSpan isnt parseInt $(el).attr('data-sizey')
	rowIsDiff: (el,obj) -> obj.row isnt parseInt $(el).attr('data-row')
	colIsDiff: (el,obj) -> obj.col isnt parseInt $(el).attr('data-col')

	deleteBlock: 'deleteBlock'
	deleteImage: 'deleteImage'
	addNumber: 'addNumber'
	deleteNumber: 'deleteNumber'
	addImage: 'addImage'
	openModal: 'openModal'
	actions:
		deleteBlock: (block) ->
			@sendAction 'deleteBlock',block
			@page.document.refreshQuestionNumbers()
		addNumber: (block) ->
			block.question = true
			block.save()
			@page.document.refreshQuestionNumbers()
			@rerender()
		deleteImage: (block) ->
			@sendAction 'deleteImage',block
		deleteNumber: (block) ->
			@sendAction 'deleteNumber',block
		addImage: (params) ->
			@sendAction 'addImage',params
		openGraphModal: (block) ->
			@sendAction 'openModal','modal/graph',block

`export default PageEditorComponent`