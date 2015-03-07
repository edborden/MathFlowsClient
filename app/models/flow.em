attr = DS.attr

class Flow extends DS.Model

	documents: DS.hasMany 'document', {async:true}
	stableDocuments: ~> @documents.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	layout: DS.belongsTo 'layout'
	folder: DS.belongsTo 'folder'
	name: attr()
	open: attr "boolean"
	multipleDocuments: ~> @documents.length > 1

`export default Flow`