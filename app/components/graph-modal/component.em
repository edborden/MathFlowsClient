class GraphModalComponent extends Ember.Component

	closeModal: 'closeModal'
	saveModel: 'saveModel'
	store:Ember.inject.service()

	actions:
		screenshot: ->
			@blobToCloudinary(@calculator.screenshot()).then (result) => 	
				image = @store.createRecord 'image',
					block: @model
					cloudinaryId: result.public_id
					width: result.width
					height: result.height
				@sendAction 'saveModel',image

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