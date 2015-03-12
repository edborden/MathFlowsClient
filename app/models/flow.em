attr = DS.attr

class Flow extends DS.Model

	iconName: "fa-th-large" 
	documents: DS.hasMany 'document', {async:true}
	stableDocuments: ~> @documents.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	layout: DS.belongsTo 'layout'
	folder: DS.belongsTo 'folder'
	name: attr()
	open: attr "boolean"
	multipleDocuments: ~> @stableDocuments.length > 1
	isFlow:true
	hasChildren: ~> @stableDocuments.length > 0

	refreshQuestionNumbers: ->
		@stableDocuments.forEach (document) -> document.refreshQuestionNumbers()

`export default Flow`