`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class CellMenuComponent extends Ember.Component

	classNames: ['btn-group-vertical']
	cell: null
	tether: null
	cellElement: null
	table: Ember.computed.alias 'cell.table'
	block: Ember.computed.alias 'table.block'

	store: Ember.inject.service()

	didInsertElement: ->
		@tether = new Tether
			element: @element
			target: @cellElement
			attachment: "top left"
			targetAttachment: "bottom left"
		window.scrollBy 0,1

	willDestroyElement: ->
		@tether.destroy()

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

	mouseDown: -> false

	click: ->
		@closeMenu()
		false

`export default CellMenuComponent`