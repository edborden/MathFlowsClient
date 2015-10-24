`import config from 'math-flows-client/config/environment'`

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class ServerService extends Ember.Service
  host: config.apiHostName
  session: service()
  store: service()

  token: alias 'session.token'

  headers: computed 'token', ->
    if @token?
      {'Authorization': 'Bearer ' + @token }
    else
      {}

  post: (url,data = {}) -> 
    @http url,data,"POST"

  delete: (url,data = {}) -> 
    @http url,data,"DELETE"

  http: (url,data,type) ->
    return new Ember.RSVP.Promise (resolve) =>
      Ember.$.ajax 
        data: data
        url: @host + "/" + url + ".json"
        success: (response) =>
          @store.pushPayload response
          resolve response
        dataType: "json"
        headers: @headers
        type: type
        crossDomain: true

`export default ServerService`