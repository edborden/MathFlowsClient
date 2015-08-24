class ProgressBarComponent extends Ember.Component

	fill: null
	classNames: ['progress']

	progressStyle: ~> "width:#{@fill}".htmlSafe()
	

`export default ProgressBarComponent`