`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel
destroyModel = modeler.destroyModel

alias = Ember.computed.alias
service = Ember.inject.service

class LineMenuComponent extends Ember.Component

	# ATTRIBUTES

	line: null
	classNames: ['right-side']
	cell: alias 'line.cell'

	# SERVICES

	store: service()

	# ACTIONS

	actions:
		menuButtonPressed: (style) ->
			if @line.get style
				destroyModel @line.styles.filterBy("effect",style).firstObject
			else
				style = @store.createRecord 'style',{effect:style,line:@line}
				@line.styles.pushObject style
				if @cell?
					saveModel(@cell).then => saveModel(@line).then => saveModel style
				else
					saveModel(@line).then => saveModel style

`export default LineMenuComponent`