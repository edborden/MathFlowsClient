`import ActiveModelAdapter from 'active-model-adapter'`
`import config from 'math-flows-client/config/environment'`

computed = Ember.computed
alias = computed.alias

class ApplicationAdapter extends ActiveModelAdapter
  host: config.apiHostName
  session: Ember.inject.service()
  token: alias 'session.token'

  #crossdomain
  ajax: (url, method, hash) -> 
    hash = hash || {}
    hash.crossDomain = true
    return @_super(url, method, hash)

  headers: computed 'token', ->
    if @token?
      {'Authorization': 'Bearer ' + @token }
    else
      {}

`export default ApplicationAdapter`