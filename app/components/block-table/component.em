class BlockTableComponent extends Ember.Component

	table: null
	preview: null
	attributeBindings: ['style']

	style: ~> "float:#{@table.alignment.side}".htmlSafe()

`export default BlockTableComponent`