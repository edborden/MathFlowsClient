`import growl from 'math-flows-client/utils/growl'`

modeler =

  saveModel: (model) ->
    return new Ember.RSVP.Promise (resolve,reject) =>
      if model.hasDirtyAttributes and not model.isSaving
        model.save().then(
          (success) => 
            growl model.modelName + " saved.", "muted"
            resolve(success)
          (errors) => 
            console.log errors
            errors errors.errors
            reject(errors)
        )
      else
        resolve()

  destroyModel: (model) ->
    return new Ember.RSVP.Promise (resolve,reject) =>
      model.destroyRecord().then(
        (success) => 
          growl model.modelName + " destroyed.", "muted"
          resolve(success)
        (errors) =>
          errors errors.errors
          reject(errors)
      )

  errors: (errors) -> 
    growl "Failed because #{error.detail}" for error in errors

`export default modeler`