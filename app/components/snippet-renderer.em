class SnippetRendererComponent extends Ember.Component

	snippet: null
	widget: ~> @snippet
	layoutName: 'components/snippet-renderer'
	classNames: ['snippet-renderer']

	attributeBindings: ['style']
	style: ~> "top:#{@top}px;left:#{@left}px;width:#{@width}px;height:#{@height}px;"

	top: ~> @snippet.y
	left: ~> @snippet.x
	width: ~> @snippet.width
	height: ~> @snippet.height

`export default SnippetRendererComponent`