class PageEditorComponent extends Ember.Component with Ember.Evented

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

	blockBeingDragged: false

	didInsertElement: ->

		syncChangedBlocks = Ember.run.bind @,@syncChangedBlocks
		setBlockBeingDragged = Ember.run.bind @,@setBlockBeingDragged

		@gridster = Ember.$(@element).children().first().gridster(
			static_class: 'static'
			widget_margins: [@widgetMargin,@widgetMargin]
			widget_base_dimensions: [@widgetBaseWidth, @widgetBaseHeight]
			shift_larger_widgets_down: true
			max_cols: @cols
			min_cols: @cols
			resize: 
				start: setBlockBeingDragged
				enabled: true
				stop: syncChangedBlocks
			draggable:
				start: setBlockBeingDragged
				#items: ".gs_w:not(.static)"
				stop: syncChangedBlocks
		).data 'gridster'

		Ember.run.next @,syncChangedBlocks #account for blocks that will move up automatically if empty space above them
				
	syncChangedBlocks: ->
		@blockBeingDragged = false
		@trigger 'syncIfOutOfSync'

	setBlockBeingDragged: -> @blockBeingDragged = true

	didUpdateAttrs: ->
		@gridster.remove_all_widgets()

`export default PageEditorComponent`