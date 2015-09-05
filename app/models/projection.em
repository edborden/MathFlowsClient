`import ModelName from 'math-flows-client/mixins/model-name'`

attr = DS.attr
belongsTo = DS.belongsTo
hasMany = DS.hasMany

class Projection extends DS.Model with ModelName

	## ATTRIBUTES

	axis: attr()
	position: attr "number"
	size: attr "number"

	## ASSOCIATIONS

	table: belongsTo 'table', {async:false}
	cells: hasMany 'cells', { async:false,inverse:null }

	## COMPUTED

	row: ~> @axis is "row"
	col: ~> @axis is "col"

	projectionIndex: -> 
		if @row 
			@table.rows.indexOf @
		else
			@table.cols.indexOf @
	
	projectionAfter: ->
		@table.get(@axis.pluralize()).objectAt @projectionIndex()+1

	projectionBefore: -> 
		@table.get(@axis.pluralize()).objectAt @projectionIndex()-1

	newPreceedingPosition: ->
		projectionBefore = @projectionBefore()
		if projectionBefore
			return (@position+projectionBefore.position)/2
		else
			return @position/2

	newFollowingPosition: ->
		projectionAfter = @projectionAfter()
		if projectionAfter
			return (@position+projectionAfter.position)/2
		else
			return @position+1

`export default Projection`