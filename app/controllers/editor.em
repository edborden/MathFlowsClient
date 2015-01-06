class EditorController extends Ember.Controller

	creatingEquation: false

	actions:
		json: ->
			jsonObj = $.parseJSON($('#TextJSON').val())
			container = new eqEd.Container(symbolSizeConfig)
			container.padTop = 0.2
			container.padBottom = 0.2
			container.fontSize = "fontSizeNormal"
			container.domObj = container.buildDomObj()
			container.domObj.updateFontSize(container.fontSize)
			container.domObj.value.addClass('equation')
			$('#renderedEq').empty()
			$('#renderedEq').append(container.domObj.value)
			for obj,i in jsonObj
				innerWrapperCtor = eqEd.Equation.JsonTypeToConstructor obj.type
				innerWrapper = innerWrapperCtor.constructFromJsonObj obj, symbolSizeConfig
				container.addWrappers [i, innerWrapper]

			container.updateAll()
		

`export default EditorController`