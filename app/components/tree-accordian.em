class TreeAccordianComponent extends Ember.Component

	layoutName: 'components/tree-accordian'
	expanded:false
	iconName:null
	mouseOver: false

	mouseEnter: -> 
		@mouseOver = true
		false
	mouseLeave: ->
		@mouseOver = false

	actions:
		toggle: -> @toggleProperty 'expanded'
			
`export default TreeAccordianComponent`