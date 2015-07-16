class EventerService extends Ember.Service with Ember.Evented

	##SYNC BLOCKS

	triggerSyncBlocks: ->
		@trigger 'syncBlocks'

`export default EventerService`