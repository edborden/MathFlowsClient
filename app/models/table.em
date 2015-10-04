`import ModelName from 'math-flows-client/mixins/model-name'`
`import SetsPosition from 'math-flows-client/mixins/sets-position'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

computed = Ember.computed

class Table extends DS.Model with ModelName,SetsPosition

	## ATTRIBUTES

	rowsCount: attr "number"
	colsCount: attr "number"
	blockPosition: attr "number"

	## ASSOCIATIONS

	block: belongsTo 'block', {async:false}
	projections: hasMany 'projection', { async:false }
	alignment: belongsTo 'alignment', { async:false }

	## COMPUTED

	rows: computed 'projections.[]', -> @projections.filterBy('row').sortBy 'position'
	cols: computed 'projections.[]', -> @projections.filterBy('col').sortBy 'position'

`export default Table`