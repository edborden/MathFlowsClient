computed = Ember.computed
alias = computed.alias

class MenuButtonComponent extends Ember.Component

	content: null
	label: null
	action: 'menuButtonPressed'
	icon: false
	iconName: (-> "fa-#{@content}").property()
	small:false

	elementSize: computed -> if @small then 20 else 40
	fontSize: computed -> if @small then 9 else 12

	tagName:'span'

	click: -> 
		@sendAction 'action',@content
		false

	buttonStyle: computed -> "width:#{@elementSize}px;height:#{@elementSize}px;font-size:#{@fontSize}px".htmlSafe()

	mouseDown: -> false #keep from grabbing focus and closing menu

	mouseEnter: -> @mouseIsOver = true if @top
	mouseLeave: -> @mouseIsOver = false if @top

`export default MenuButtonComponent`