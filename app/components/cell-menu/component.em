class CellMenuComponent extends Ember.Component

	classNames: ['btn-group-vertical']
	cell: null
	tether: null
	cellElement: null
	table: Ember.computed.alias 'cell.table'

	modeler: Ember.inject.service()
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
			@modeler.saveModel(projection).then =>
				@table.block.reload()

		removeProjection: (axis) ->
			projection = @cell.get(axis)
			@table.projections.removeObject projection
			@modeler.destroyModel(projection).then =>
				@table.block.reload() if @table.block.invalid

	mouseDown: -> false

	click: ->
		@closeMenu()
		false

`export default CellMenuComponent`