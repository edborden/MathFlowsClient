`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Table extends DS.Model with ModelName

	## ATTRIBUTES

	rowsCount: attr "number"
	colsCount: attr "number"

	## ASSOCIATIONS

	block: belongsTo 'block', {async:false}
	projections: hasMany 'projection', { async:false }

	## COMPUTED

	rows: ~> @projections.filterBy('row').sortBy 'position'
	cols: ~> @projections.filterBy('col').sortBy 'position'

`export default Table`