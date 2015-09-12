class MenuButtonComponent extends Ember.Component

	content:null
	action: 'action'

	tagName:'span'

	label: Ember.computed.alias 'content'

	click: -> 
		@sendAction 'action',@content
		false

	buttonStyle: ~> "width:40px;height:40px;font-size:12px".htmlSafe()

	mouseDown: -> false #keep from grabbing focus and closing menu

	mouseEnter: -> @mouseIsOver = true if @top
	mouseLeave: -> @mouseIsOver = false if @top

`export default MenuButtonComponent`