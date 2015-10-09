`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

class LineMenuComponent extends Ember.Component

	# ATTRIBUTES

	line: null
	classNames: ['right-side']

	# SERVICES

	store:Ember.inject.service()

	# ACTIONS

	actions:
		menuButtonPressed: (style) ->
			if @line.get style
				destroyModel @line.styles.filterBy("effect",style).firstObject
			else
				style = @store.createRecord 'style',{effect:style,line:@line}
				@line.styles.pushObject style
				saveModel(@line).then => saveModel style

`export default LineMenuComponent`