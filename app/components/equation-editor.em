class EquationEditorComponent extends Ember.Component

	actions:
		toJson: ->
			jsonObj = Ember.$('.editorEquation').next().data('eqObject').buildJsonObj()
			jsonString = JSON.stringify jsonObj
			@sendAction 'action',jsonString

	layoutName: 'components/equation-editor'

	didInsertElement: ->
		symbolSizeConfig = new eqEd.SymbolSizeConfiguration('.testEquation')
		clipboard = new eqEd.Clipboard()
		inializePropertyHooks(symbolSizeConfig)
		setupKeyboardEvents(symbolSizeConfig, clipboard)
		setupMenuEvents(symbolSizeConfig)
		@setupInitialContainer(symbolSizeConfig)

	setupInitialContainer: (symbolSizeConfig) ->
		container = new eqEd.Container(symbolSizeConfig)
		container.padTop = 0.2
		container.padBottom = 0.2
		container.fontSize = "fontSizeNormal"
		container.domObj = container.buildDomObj("<div class='eqEdContainer'></div>")
		container.domObj.updateFontSize(container.fontSize)
		container.domObj.value.addClass('equation')
		$('.editorEquation').after(container.domObj.value)
		topLevelEmptyContainerWrapper = new eqEd.TopLevelEmptyContainerWrapper(symbolSizeConfig)
		container.addWrappers([0, topLevelEmptyContainerWrapper])
		topLevelEmptyContainerWrapper.updateAll()
			
`export default EquationEditorComponent`