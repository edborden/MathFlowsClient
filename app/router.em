`import config from './config/environment'`

class Router extends Ember.Router
  location: config.locationType

Router.map ->
  @route 'me'
  @route 'group'
  @route 'intro'
  @route 'login'
  @route 'invitations'
  @route 'preferences', ->
    @route 'display'
    @route 'headers'
  @route 'invitation', {path: '/invitation/:invitation_id'}
  @route 'google', {path: '/google/:id/:keyword/:adgroupid'}
  @route 'facebook'
  @route 'privacy'
  @route 'terms'

`export default Router`