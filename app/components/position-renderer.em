class PositionRendererComponent extends Ember.Component

	classNames: ['position-renderer']

	attributeBindings: ['style']
	style: ~> "top:#{@top}px;left:#{@left}px;width:#{@width}px;height:#{@height}px;"

	top: ~> @positionLayout.rowHeight * (@position.row - 1)
	left: ~> @positionLayout.colWidth * (@position.col - 1)
	width: ~> @positionLayout.colWidth * @position.colSpan
	height: ~> @positionLayout.rowHeight * @position.rowSpan

`export default PositionRendererComponent`