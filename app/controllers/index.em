class IndexController extends Ember.Controller

	actions:
		newBlock: ->
			block = @store.createRecord('block')
			@model.blocks.pushObject block

		editBlock: (block) -> @transitionToRoute 'block',block

		pdf: ->
			svgs = Ember.$('.bigOperatorSymbol')#.child()
			console.log svgs#.html() for svg in svgs
			#html = Ember.$(".gridster").html()
			#console.log svgs
			html = Ember.$('.gridster')
			pdf = new jsPDF 'p','pt','a4'
			svgElementToPdf svgs, pdf, {x_offset:1}
			#pdf.addSVG svgs,0,0 #for svg in svgs#, pdf, {scale: 1,removeInvalid: false}
			#pdf.addHTML html, ->
			pdf.output 'datauri'









			#html = '<table name="foo"><tr><td>word up</td></tr></table><textarea>Foo&nbsp;&nbsp;&trade;&nbsp;&nbsp;Bar</textarea>'
			#data = 
			#	doc: 
			#		test: true
			#		document_type: 'pdf'
			#		name: 'adoc.pdf'
			#		document_content: html
			#		strict: 'none'
			#		tag: "tag"
			#		javascript: true
			#		async: false
			#	user_credentials: "2eXhG6AGYUtQeorpgrMq"
 
			#@download1("https://docraptor.com/docs", data)

	download: (url, data,method) ->
		data = Ember.$.param(data)
		console.log data
		url += '?' + data
		console.log url
		Ember.$('<form style="display: none" action="' + url + '" method="' + (method||'post') + '">' + '</form>').appendTo('body').submit().remove()


	download1: (url, data, method) ->

		Ember.$('<form style="display: none" id="dr_submission" action="' + url + '" method="' + (method||'post') + '">' + '</form>').appendTo('body') 

		Ember.$('form#dr_submission').append('<textarea name="user_credentials"></textarea>')
		Ember.$('form#dr_submission textarea[name=user_credentials]').val(data.user_credentials)

		for key,val of data.doc
			Ember.$('form#dr_submission').append('<textarea name="doc['+key+']"></textarea>')
			Ember.$('form#dr_submission textarea[name="doc['+key+']"]').val(val)

		Ember.$('form#dr_submission').submit().remove()

`export default IndexController`