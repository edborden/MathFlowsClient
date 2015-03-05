class BlockImageComponent extends Ember.Component

	tagName: 'img'
	classNames: ['block-image']
	attributeBindings: ['src','style']

	style: ~> "max-height:#{@availableHeight}px;max-width:#{@availableWidth}px"

	src: ~> "http://res.cloudinary.com/hmb9zxcjb/image/upload/" + @image.cloudinaryId

`export default BlockImageComponent`