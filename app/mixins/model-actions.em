ModelActions = Ember.Mixin.create

	saveModel: 'saveModel'
	destroyModel: 'destroyModel'

	actions:
		saveModel: (model,successCallback,errorCallback) -> @sendAction 'saveModel',model,successCallback,errorCallback
		destroyModel: (model,successCallback,errorCallback) -> @sendAction 'destroyModel',model,successCallback,errorCallback

`export default ModelActions`