`import NewDimensions from 'math-flows-client/mixins/new-dimensions'`
`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

class GraphModalComponent extends Ember.Component with NewDimensions

	closeModal: 'closeModal'
	store:Ember.inject.service()

	didRender: -> console.log 'model',@model

	actions:
		screenshot: ->
			cachedModel = @model
			@blobToCloudinary(@calculator.screenshot()).then (result) =>
				newDimensions = @newDimensions result
				image = @store.createRecord 'image',
					block: cachedModel
					cloudinaryId: result.public_id
					width: newDimensions.width
					height: newDimensions.height
				image.setPosition()
				saveModel image

		registerCalculator: (calculator) ->
			@calculator = calculator

		cancel: ->
			@model.rollback()
			@sendAction 'closeModal'

		closeModal: -> @sendAction 'closeModal'

	blobToCloudinary: (blob) ->
		return new Ember.RSVP.Promise (resolve) ->
			$('body').append("<input type='file' class='cloudinary'>")
			el = $('.cloudinary')
			el.hide()
			el.unsigned_cloudinary_upload 'fqd73ph6'
			el.bind 'fileuploaddone', (e, data) ->
				resolve data.result
			el.fileupload()
			el.fileupload('option', 'formData').file = blob
			el.fileupload('add', { files: [ blob ] })

`export default GraphModalComponent`