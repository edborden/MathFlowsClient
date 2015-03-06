attr = DS.attr

class User extends DS.Model
	layout: DS.belongsTo 'layout'
	name: attr()
	pic: attr()
	folders: DS.hasMany 'folder'
	stableFolders: ~> @folders.rejectBy 'isDeleted' #https://github.com/emberjs/data/issues/2666
	guest: attr()
	headers: DS.hasMany 'position'
	headerPosition: DS.belongsTo 'position'
	group: DS.belongsTo 'group'

`export default User`