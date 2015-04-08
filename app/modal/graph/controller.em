class ModalGraphController extends Ember.Controller

	actions:
		screenshot: ->
			@blobToCloudinary(@calculator.screenshot()).then (result) => 	
				image = @store.createRecord 'image',
					block: @model
					cloudinaryId: result.public_id
					width: result.width
					height: result.height
				@send 'saveModel',image
		registerCalculator: (calculator) ->
			@calculator = calculator

	blobToCloudinary: (blob) ->
		return new Ember.RSVP.Promise (resolve) ->
			$('body').append("<input type='file' class='cloudinary'>")
			el = $('.cloudinary')
			el.hide()
			el.unsigned_cloudinary_upload 'fqd73ph6', {cloud_name: "hmb9zxcjb"}
			el.bind 'fileuploaddone', (e, data) ->
				resolve data.result
			el.fileupload()
			el.fileupload('option', 'formData').file = blob
			el.fileupload('add', { files: [ blob ] })


`export default ModalGraphController`