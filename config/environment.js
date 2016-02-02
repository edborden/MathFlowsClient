/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'math-flows-client',
    environment: environment,
    baseURL: '/',
    onLine: true,
    locationType: 'auto',
    apiHostName: 'http://localhost:3000',
    redirectUri: 'http://localhost:4200',
    torii: {providers: {}},
    APP: {},
    EmberENV: {FEATURES: {}},

    keenProjectId: "54dcf35546f9a747ff1d341c",
    keenWriteKey: "1461f8c799fbb5f0837cdc93e08a20a4bcaf9f429dc24dd113e94b62df6abdfbe91994fc38514ae25bab938c2b180570a3484959f75d7e16193ebbb5b9f6322a4dfed4fd8786df7bdef5464290e44cac96568bf301a1c7396eff9304553a232a8132c7067e7157b7866aa90698e31476",

    fbAppId: '559198070898964'
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.apiHostName = 'http://www.stackflows.com',
    ENV.redirectUri = 'http://mathflows.com',
    ENV.fbAppId = '559189347566503'
  }

  ENV.torii.providers['google-oauth2'] = {
    redirectUri: ENV.redirectUri,
    scope: 'email profile',
    accessType: 'offline',
    approvalPrompt: 'force',
    apiKey: '432493008033-vfsneq433m69ssvdbao0maq89iu19avh.apps.googleusercontent.com'
  };

  return ENV;
};
