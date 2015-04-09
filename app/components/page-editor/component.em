`import ElRegister from 'math-flows-client/mixins/el-register'`

class PageEditorComponent extends Ember.Component with ElRegister

	cols: ~> 4
	widgetMargin: ~> 9 / 2
	widgetBaseWidth: ~> 128.25
	widgetBaseHeight: ~> 18
	height: ~> 11 * 72 #11 inches
	width: ~> 8.5 * 72 #8.5 inches
	padding: ~> (0.5 * 72) - (9 / 2)

	classNames: ['grid-editor','gridster']

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
				stop: @syncChangedBlocks
			draggable:
				stop: @syncChangedBlocks
		).data 'gridster'
		Ember.run.next @,@syncChangedBlocks #account for blocks that will move up automatically if empty space above them
				
	syncChangedBlocks: ->
		for el in Ember.A $.makeArray Ember.$('.gs-w')
			obj = Ember.$(el).data('emberObject')
			obj.syncIfOutOfSync() if obj?

	openModal: 'openModal'
	saveModel: 'saveModel'
	destroyModel: 'destroyModel'
	actions:
		openGraphModal: (block) -> @sendAction 'openModal','modal/graph',block
		saveModel: (model) -> @sendAction 'saveModel',model
		destroyModel: (model) -> @sendAction 'destroyModel',model

	+observer page
	onPageChange: -> @rerender()

`export default PageEditorComponent`