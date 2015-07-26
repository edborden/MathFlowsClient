class PageNavigatorComponent extends Ember.Component

	nextPage: 'nextPage'
	lastPage: 'lastPage'

	actions:
		nextPage: -> @sendAction 'nextPage'
		lastPage: -> @sendAction 'lastPage'

`export default PageNavigatorComponent`