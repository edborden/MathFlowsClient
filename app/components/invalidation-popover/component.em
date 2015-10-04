computed = Ember.computed
alias = computed.alias

class InvalidationPopoverComponent extends Ember.Component
	classNames: ['popover']
	classNameBindings: ['left','right']
	attributeBindings: ['style']

	col: alias 'block.col'
	width: alias 'block.width'
	height: alias 'block.height'

	right: computed 'col', -> @col >= 2
	left: computed 'col', -> @col <= 1

	top: computed 'height', -> (@height * 0.5).toString()

	style: computed 'right','top','width', -> 
		always = "top:#{@top}px;"
		always = always + "left:#{@width}px;" if @right
		always.htmlSafe()

`export default InvalidationPopoverComponent`