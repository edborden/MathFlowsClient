class BlockImageComponent extends Ember.Component

	image: null
	availableHeight: null
	availableWidth: null
	tagName: 'img'
	attributeBindings: ['src','style']

	style: ~> "max-height:#{@availableHeight}px;max-width:#{@availableWidth}px;float:#{@image.alignment.side}".htmlSafe()

	src: ~> "http://res.cloudinary.com/hmb9zxcjb/image/upload/" + @image.cloudinaryId

`export default BlockImageComponent`