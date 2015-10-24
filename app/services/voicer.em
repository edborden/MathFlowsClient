service = Ember.inject.service
computed = Ember.computed
alias = computed.alias

class VoicerService extends Ember.Service

  session: service()
  me: alias 'session.me'

  widgetOptions: computed ->
    accent_color: '#e2753a'
    trigger_color: 'white'
    trigger_background_color: '#e2753a'   

  identificationOptions: computed ->
    email: @me.email
    name: @me.name
    created_at: @me.createdAt
    id: @me.id
    #//type:       'Owner', // Optional: segment your users by type
    #//account: {
    #//  id:           123, // Optional: associate multiple users with a single account
    #//  name:         'Acme, Co.', // Account name
    #//  created_at:   1364406966, // Unix timestamp for the date the account was created
    #//  monthly_rate: 9.99, // Decimal; monthly rate of the account
    #//  ltv:          1495.00, // Decimal; lifetime value of the account
    #//  plan:         'Enhanced' // Plan name for the account

  setup: ->
    UserVoice.push ['set', @widgetOptions]
    UserVoice.push ["setSSO", @me.uservoiceToken]
    UserVoice.push ['identify', @identificationOptions]
    UserVoice.push ['addTrigger', {mode: 'contact', trigger_position: 'bottom-left' }]

`export default VoicerService`