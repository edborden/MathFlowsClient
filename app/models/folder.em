attr = DS.attr

class Folder extends DS.Model

	user: DS.belongsTo 'user', {inverse: 'folders'}
	flows: DS.hasMany 'flows'
	stableFlows: ~> @flows.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	name: attr()
	open: attr "boolean"

`export default Folder`