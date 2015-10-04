class ProgressBarComponent extends Ember.Component

	fill: null
	classNames: ['progress']

	progressStyle: Ember.computed 'fill', -> "width:#{@fill}".htmlSafe()
	

`export default ProgressBarComponent`