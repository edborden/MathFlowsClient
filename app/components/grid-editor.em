`import ElRegister from 'math-flows-client/mixins/el-register'`
`import RandomId from 'math-flows-client/mixins/random-id'`

class GridEditorComponent extends Ember.Component with ElRegister,RandomId

	## Must be set elsewhere

	grid: null
	widgetRendererTemplate: null
	action: null

	##

	widgets: ~> @grid.childPositions
	cols: ~> @grid.layout.cols
	widgetMargin: ~> @grid.layout.gridsterInsideMargin
	widgetBaseWidth: ~> @grid.layout.colWidth
	widgetBaseHeight: ~> @grid.layout.rowHeight

	classNames: ['grid-editor','gridster']
	layoutName: 'components/grid-editor'
	gridster: null

	attributeBindings: ['style']
	style: ~> "height:#{@grid.layout.height}px;width:#{@grid.layout.width}px;padding:#{@grid.layout.gridsterOutsideMargin}px;"

	didInsertElement: ->
		@_super()
		@gridster = Ember.$(@element).children().first().gridster(
			widget_margins: [@widgetMargin,@widgetMargin],
			widget_base_dimensions: [@widgetBaseWidth, @widgetBaseHeight]
			namespace: "#" + @randomId
			max_cols: @cols
			min_cols: @cols
			resize: 
				enabled: true
				stop: @runSync
			draggable:
				stop: @runSync
		).data 'gridster'

	runSync: ->
		obj = Ember.$(".grid-editor").data 'emberObject'
		obj.syncChangedBlocks()

	syncChangedBlocks: ->
		for diffWidget in @widgetsDiff 
			obj = Ember.$(diffWidget).data 'emberObject'
			obj.syncAttrsToEl()

	+volatile
	widgetElArray: -> Ember.$('.gs-w')

	# Block elements that are different from their models
	+volatile
	widgetsDiff: -> 
		@widgetElArray.filter (idx,el) =>
			obj = Ember.$(el).data('emberObject').widget
			@widthIsDiff(el,obj) or @heightIsDiff(el,obj) or @rowIsDiff(el,obj) or @colIsDiff(el,obj)
			
	widthIsDiff: (el,obj) -> obj.colSpan isnt parseInt $(el).attr('data-sizex')
	heightIsDiff: (el,obj) -> obj.colSpan isnt parseInt $(el).attr('data-sizey')
	rowIsDiff: (el,obj) -> obj.row isnt parseInt $(el).attr('data-row')
	colIsDiff: (el,obj) -> obj.col isnt parseInt $(el).attr('data-col')

	actions:
		editWidget: (widget) ->
			@sendAction 'action',widget

`export default GridEditorComponent`