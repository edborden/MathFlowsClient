`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Cell extends DS.Model with ModelName

	## ATTRIBUTES

	content: attr()
	rowId: attr "number"
	colId: attr "number"
	tableId: attr "number"

	## ASSOCIATIONS

	projections: hasMany 'projection', {async:false}

	## COMPUTED

	row: ~> @projections.filterBy('row').firstObject
	col: ~> @projections.filterBy('col').firstObject

`export default Cell`