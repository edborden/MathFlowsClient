class IndexController extends Ember.Controller

	actions:
		newBlock: ->
			block = @store.createRecord('block')
			@model.blocks.pushObject block

		editBlock: (block) -> @transitionToRoute 'block',block

		pdf: ->
			html = Ember.$('.gridster')
			pdf = new jsPDF 'p','pt','a4'
			pdf.addHTML html, ->
				pdf.output 'datauri'

`export default IndexController`