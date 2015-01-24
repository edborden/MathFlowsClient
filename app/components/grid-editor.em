`import ElRegister from 'math-flows-client/mixins/el-register'`

class GridEditorComponent extends Ember.Component with ElRegister

	## Must be set elsewhere

	grid: null
	widgets: null
	widgetRendererTemplate: null
	action: null
	cols: null
	widgetMargin: null
	widgetBaseWidth: null
	widgetBaseHeight: null
	height: null
	width: null
	padding: null

	##

	classNames: ['grid-editor','gridster']
	layoutName: 'components/grid-editor'
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

	runSync: ->
		obj = Ember.$(".grid-editor").data 'emberObject'
		obj.syncChangedBlocks().then -> obj.rerender() if obj.grid.isPage

	syncChangedBlocks: ->
		promiseArray = []
		for diffWidget in @widgetsDiff 
			obj = Ember.$(diffWidget).data 'emberObject'
			promiseArray.push obj.syncAttrsToEl()
		return Ember.RSVP.all promiseArray

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