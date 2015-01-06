class RenderedEquationComponent extends Ember.Component

	#classNames:['eqEdContainer']

	#layoutName: 'components/rendered-equation'

	didInsertElement: ->
		element = @element
		symbolSizeConfig = new eqEd.SymbolSizeConfiguration(element)
		#clipboard = new eqEd.Clipboard()
		#inializePropertyHooks(symbolSizeConfig)
		#setupKeyboardEvents(symbolSizeConfig, clipboard)
		#setupMenuEvents(symbolSizeConfig)
		container = new eqEd.Container(symbolSizeConfig)
		container.padTop = 0.2
		container.padBottom = 0.2
		container.fontSize = "fontSizeSmallest"
		#element = '<div></div>'
		container.domObj = container.buildDomObj(element)
		container.domObj.updateFontSize(container.fontSize)
		container.domObj.value.addClass('equation')
		#$('#renderedEq').empty()
		Ember.$(element).html(container.domObj.value)
		jsonObj = Ember.$.parseJSON @equation
		for obj,i in jsonObj
			innerWrapperCtor = eqEd.Equation.JsonTypeToConstructor obj.type
			innerWrapper = innerWrapperCtor.constructFromJsonObj obj, symbolSizeConfig
			container.addWrappers [i, innerWrapper]

		container.updateAll()

`export default RenderedEquationComponent`