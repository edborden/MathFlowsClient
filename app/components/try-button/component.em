class TryButtonComponent extends Ember.Component

	keen:Ember.inject.service()

	tagName: 'button'
	classNames: ['btn','btn-primary','btn-xs']

	position: null

	click: ->
		@keen.introClickPosition = @position
		@router.transitionTo 'intro'


`export default TryButtonComponent`