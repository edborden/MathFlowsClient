class InvalidationPopoverComponent extends Ember.Component
	classNames: ['popover']
	classNameBindings: ['left','right']
	attributeBindings: ['style']

	right: ~> true if @block.col is 2 or @block.col is 3
	left: ~> true if @block.col is 0 or @block.col is 1

	top: ~> (@block.height * 0.5).toString()

	style: ~> 
		always = "top:#{@top}px;"
		if @right
			always = always + "left:#{@block.width}px;"
		always.htmlSafe()

`export default InvalidationPopoverComponent`