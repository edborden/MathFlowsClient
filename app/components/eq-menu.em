class EqMenuComponent extends Ember.Component

	layoutName: 'components/eq-menu'

	didInsertElement: ->
		Ember.$('#toJSON').on 'click', ->
			jsonObj = Ember.$('.testEquation').next().data('eqObject').buildJsonObj()
			Ember.$('#ContentJSON').html(JSON.stringify(jsonObj))
    
		Ember.$('#JSONtoEqEd').on 'click', (e) ->
			jsonObj = Ember.$.parseJSON(Ember.$('#TextJSON').val())
			container = new eqEd.Container(symbolSizeConfig)
			container.padTop = 0.2
			container.padBottom = 0.2
			container.fontSize = "fontSizeSmallest"
			container.domObj = container.buildDomObj()
			container.domObj.updateFontSize(container.fontSize)
			container.domObj.value.addClass('equation')
			Ember.$('#renderedEq').empty()
			Ember.$('#renderedEq').append(container.domObj.value)
			for obj,i in jsonObj
				innerWrapperCtor = eqEd.Equation.JsonTypeToConstructor obj.type
				innerWrapper = innerWrapperCtor.constructFromJsonObj obj, symbolSizeConfig
				container.addWrappers [i, innerWrapper]

			container.updateAll()
			
`export default EqMenuComponent`