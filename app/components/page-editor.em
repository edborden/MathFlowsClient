`import GridEditorComponent from 'math-flows-client/components/grid-editor'`

class PageEditorComponent extends GridEditorComponent

	rows: ~> @grid.rows
	cols: ~> @grid.cols
	widgetMargin: ~> @grid.blockMargin
	widgetBaseWidth: ~> @grid.blockBaseWidth
	widgetBaseHeight: ~> @grid.blockBaseHeight

	widgetRendererTemplate: "components/block-renderer"
	action: "editBlock"

`export default PageEditorComponent`