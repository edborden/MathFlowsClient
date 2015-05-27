class BlockImageComponent extends Ember.Component

	tagName: 'img'
	attributeBindings: ['src','style']

	style: ~> "max-height:#{@availableHeight}px;max-width:#{@availableWidth}px".htmlSafe()

	src: ~> "http://res.cloudinary.com/hmb9zxcjb/image/upload/" + @image.cloudinaryId

`export default BlockImageComponent`