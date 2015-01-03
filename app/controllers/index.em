class IndexController extends Ember.Controller

	actions:
		newBlock: ->
			block = @store.createRecord('block')
			block.isNew = true
			@model.blocks.pushObject block

		editBlock: (block) ->
			@transitionToRoute 'block.edit',block

		pdf: ->

			html = Ember.$('.gridster')
			pdf = new jsPDF 'p','pt','a4'
			pdf.addHTML html, ->
				pdf.output 'datauri'

`export default IndexController`