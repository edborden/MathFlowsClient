`import PageEditorComponent from 'math-flows-client/components/page-editor'`

class HeadersEditorComponent extends PageEditorComponent

	user: null
	page: {document: {refreshQuestionNumbers: -> return}}
	pageLayout: ~> @user.layout
	height: 200

`export default HeadersEditorComponent`