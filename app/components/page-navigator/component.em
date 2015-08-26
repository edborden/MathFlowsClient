class PageNavigatorComponent extends Ember.Component

	nextPage: 'nextPage'
	previousPage: 'previousPage'

	actions:
		nextPage: -> @sendAction 'nextPage'
		previousPage: -> @sendAction 'previousPage'

`export default PageNavigatorComponent`