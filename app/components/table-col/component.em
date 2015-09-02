`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

class TableColComponent extends Ember.Component with HandlesEquations

	tagName: 'th'

	col: null

	attributeBindings: ['style']
	style: ~> "width:#{@col.size}px".htmlSafe()

	didInsertElement: ->
		@col.renderer = "#" + Ember.$(@element).attr "id"

`export default TableColComponent`