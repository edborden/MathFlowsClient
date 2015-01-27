class SnippetRendererComponent extends Ember.Component

	snippet: null
	widget: ~> @snippet
	layoutName: 'components/snippet-renderer'
	classNames: ['snippet-renderer']

	attributeBindings: ['style']
	style: ~> "top:#{@top}px;left:#{@left}px;width:#{@width}px;height:#{@height}px;"

	position:null #passed in
	top: ~> @snippet.y
	left: ~> @snippet.x @position
	width: ~> @snippet.width @position
	height: ~> @snippet.height

`export default SnippetRendererComponent`