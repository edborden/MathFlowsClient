class MenuButtonComponent extends Ember.Component

	content:null
	action: 'menuButtonPressed'
	icon: false
	iconName: (-> "fa-#{@content}").property()
	small:false

	elementSize: (-> if @small then 20 else 40 ).property()
	fontSize: (-> if @small then 9 else 12 ).property()

	tagName:'span'

	label: Ember.computed.alias 'content'

	click: -> 
		@sendAction 'action',@content
		false

	buttonStyle: ~> "width:#{@elementSize}px;height:#{@elementSize}px;font-size:#{@fontSize}px".htmlSafe()

	mouseDown: -> false #keep from grabbing focus and closing menu

	mouseEnter: -> @mouseIsOver = true if @top
	mouseLeave: -> @mouseIsOver = false if @top

`export default MenuButtonComponent`