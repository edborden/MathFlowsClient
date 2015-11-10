`import modeler from 'math-flows-client/utils/modeler'`
saveModel = modeler.saveModel

service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class SessionService extends Ember.Service

  store: service()
  keen: service()

  # COMPUTED

  loggedIn: alias 'model'
  model: null
  token: alias 'model.token'
  me: alias 'model.user'
  googleReferrer: alias 'keen.googleReferrer'
  facebookReferrer: alias 'keen.facebookReferrer'
  kickstarterReferrer: alias 'keen.kickstarterReferrer'
  
  open: ->
    return new Ember.RSVP.Promise (resolve,reject) =>
      token = localStorage.mathFlowsToken
      if token?
        @store.query('session', {token: token}).then(
          (response) => 
            @model = response.objectAt(0)
            resolve()
          (errors) => 
            console.log errors
            if errors.errors[0].status is "401"
              @close()
              console.log "401!"
            reject()
        )
      else
        @post('issue').then => resolve()

  post: (token,redirectUri) ->
    return new Ember.RSVP.Promise (resolve,reject) =>
      session = @store.createRecord 'session',
        token:token
        redirectUri:redirectUri
        googleReferrer: @get('googleReferrer')
        facebookReferrer: @get('facebookReferrer')
        kickstarterReferrer: @get('kickstarterReferrer')
      saveModel(session).then(
        (response) => 
          @model = response
          localStorage.mathFlowsToken = @token
          resolve()
        (errors) => 
          console.log errors
          @close() if errors.errors[0].status is "401"
          reject()
      )

  close: ->
    localStorage.clear()
    @model = null

`export default SessionService`