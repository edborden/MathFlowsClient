class BlockImageComponent extends Ember.Component

	tagName: 'img'
	classNames: ['block-image']
	attributeBindings: ['src','style']

	style: ~> "max-height:#{@availableHeight}px;max-width:#{@availableWidth}px"

	src: ~> @image.binary

`export default BlockImageComponent`