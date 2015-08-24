`import Application from '../../app'`
`import config from '../../config/environment'`

startApp = (attrs) ->

  attributes = Ember.merge({}, config.APP)
  attributes = Ember.merge(attributes, attrs)

  Ember.run ->
    application = Application.create(attributes)
    application.setupForTesting()
    application.injectTestHelpers()

`export default startApp`