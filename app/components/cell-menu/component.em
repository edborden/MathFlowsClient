`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

computed = Ember.computed
alias = computed.alias
service = Ember.inject.service

class CellMenuComponent extends Ember.Component

	# ATTRIBUTES

	classNames: ['right-side']
	cell: null

	# SERVICES

	store: service()

	# COMPUTED

	table: alias 'cell.table'
	block: alias 'table.block'

	actions: 
		newProjection: (axis,position) ->
			currentProjection = @cell.get(axis)
			newPosition = if position is 'before' then currentProjection.newPreceedingPosition() else currentProjection.newFollowingPosition()
			projection = @store.createRecord 'projection', {axis:axis,position:newPosition,table:@table,size:15}
			@table.projections.pushObject projection
			saveModel(projection).then =>
				@block.validate()

		removeProjection: (axis) ->
			projection = @cell.get(axis)
			@table.projections.removeObject projection
			destroyModel(projection).then =>
				@block.validate() if @block.contentInvalid

		destroyTable: -> 
			@setActiveItem null
			destroyModel @table

`export default CellMenuComponent`