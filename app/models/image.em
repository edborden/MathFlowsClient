attr = DS.attr

class Image extends DS.Model
	block: DS.belongsTo 'block'
	binary: attr()
	height: attr "number"
	width: attr "number"
	ext: attr()
	scale: attr "number", {defaultValue:5}

	setDimensions: ->
		return new Ember.RSVP.Promise (resolve) =>
			image = document.createElement('img')
			image.onload = =>
				@height = image.height
				@width = image.width
				resolve()
			image.src = @binary		

	validate: ->
		return new Ember.RSVP.Promise (resolve) =>
			if @tooBig or @incompatibleType
				@processThroughCanvas().then -> resolve()
			else
				resolve()

	processThroughCanvas: ->
		return new Ember.RSVP.Promise (resolve) =>
			image = document.createElement('img')
			image.onload = =>
				$("body").append "<canvas id='canvas'></canvas>"
				canvas = document.getElementById "canvas"
				$(canvas).hide()
				@scaleDown() if @tooBig
				ctx = canvas.getContext "2d"
				ctx.clearRect 0, 0, canvas.width, canvas.height
				canvas.width = @width
				canvas.height = @height
				ctx.drawImage image, 0, 0, @width, @height
				@type = "image/jpeg"
				@binary = canvas.toDataURL(@type,0.1)
				$(canvas).remove()
				resolve()
			image.src = @binary

	scaleDown: ->
		console.log "original size ",@width,@height
		if @heightIsLonger
			@width = @width * (@maxSize / @height)
			@height = @maxSize
		else
			@height = @height * (@maxSize / @width)
			@width = @maxSize			
		console.log "new size ",@width,@height

	maxSize: ~> 1500
	tooBig: ~> @width > @maxSize or @height > @maxSize
	incompatibleType: ~> @type isnt "image/jpeg" or @type isnt "image/png"
	heightIsLonger: ~> @height > @width

`export default Image`