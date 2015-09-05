`import HandlesEquations from 'math-flows-client/mixins/handles-equations'`

class BlockTableComponent extends Ember.Component with HandlesEquations

	table: null
	preview: null
	attributeBindings: ['style']

	style: ~> "float:#{@table.alignment.side}".htmlSafe()

`export default BlockTableComponent`