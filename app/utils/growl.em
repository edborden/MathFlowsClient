growl = (message,muted) ->
	unless muted
		Messenger().post message
	else
		console.log message

`export default growl`