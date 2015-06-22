class PageEditorComponent extends Ember.Component

	cols: ~> 4
	widgetMargin: ~> 9 / 2
	widgetBaseWidth: ~> 128.25
	widgetBaseHeight: ~> 18
	height: ~> 11 * 72 #11 inches
	width: ~> 8.5 * 72 #8.5 inches
	padding: ~> (0.5 * 72) - (9 / 2)

	classNames: ['gridster']

	attributeBindings: ['style']
	style: ~> "height:#{@height}px;width:#{@width}px;padding:#{@padding}px;".htmlSafe()

	didRender: ->

		syncChangedBlocks = Ember.run.bind @,@syncChangedBlocks

		@gridster = Ember.$(@element).children().first().gridster(
			widget_margins: [@widgetMargin,@widgetMargin],
			widget_base_dimensions: [@widgetBaseWidth, @widgetBaseHeight]
			max_cols: @cols
			min_cols: @cols
			resize: 
				enabled: true
				stop: syncChangedBlocks
			draggable:
				stop: syncChangedBlocks
		).data 'gridster'
		Ember.run.next @,syncChangedBlocks #account for blocks that will move up automatically if empty space above them
				
	syncChangedBlocks: ->
		for widget in @widgets()
			widget.syncIfOutOfSync()

	widgets: ->
		array = []
		for el in Ember.A $.makeArray Ember.$('.gs-w')
			obj = Ember.$(el).data('emberObject')
			array.push obj if obj?
		return array

	+observer page
	onPageChange: -> 
		console.log 'page changed',@
		@rerender()

`export default PageEditorComponent`