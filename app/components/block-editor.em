`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class BlockEditorComponent extends GridEditorComponent

	didInsertElement: ->
		@_super()
		Ember.$(@element).height => @grid.pixelHeight
		Ember.$(@element).width => @grid.pixelWidth

	in: ~> 1.5 * 72

	rows: ~> Math.floor(@grid.pixelHeight / @widgetBaseHeight)
	cols: ~> Math.floor(@grid.pixelWidth / @widgetBaseWidth)
	widgetBaseWidth: 12
	widgetBaseHeight: ~> @lineHeight

	widgetMargin: 0
	lineHeight: ~> 1.5*@fontSize
	fontSize: ~> @in / 6

	widgetRendererTemplate: "components/snippet-renderer"
	action: "editSnippet"

`export default BlockEditorComponent`