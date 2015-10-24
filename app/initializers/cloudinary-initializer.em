initializer =

  initialize: ->

    if cloudinary?
      cloudinary.setCloudName 'hmb9zxcjb'
      $.cloudinary.config {cloud_name: 'hmb9zxcjb'}

`export default initializer`