attr = DS.attr

class Block extends DS.Model
	col: attr "number"
	row: attr "number"
	width: attr "number"
	height: attr "number"
	layout: DS.belongsTo 'layout'
	snippets: DS.hasMany 'snippet'

	pixelWidth: ~> 
		blockMarginSpace = (@width - 1) * @layout.blockMargin
		blockWidthWithoutMargin = @layout.blockBaseWidth * @width
		blockMarginSpace + blockWidthWithoutMargin
	pixelHeight: ~>
		blockMarginSpace = (@height - 1) * @layout.blockMargin
		blockHeightWithoutMargin = @layout.blockBaseHeight * @height
		blockMarginSpace + blockHeightWithoutMargin


`export default Block`