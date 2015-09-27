`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class TableAdderComponent extends Ember.Component

	store: Ember.inject.service()

	classNameBindings: ["addingTable:padded"]

	block:null
	addingTable:false
	rows: 2
	cols: 3

	actions:
		addTable: -> 
			@addingTable = true
			false

		newTable: ->
			table = @store.createRecord 'table',
				rowsCount:@rows
				colsCount:@cols
				block:@block
			table.setPosition()
			saveModel table
			@block.tables.pushObject table
			@addingTable = false

`export default TableAdderComponent`