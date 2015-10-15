StructureService = Ember.Service.extend

  structuredUser: (user) ->
    id: parseInt user.id
    guest: user.guest
    name: user.name
    created_at: user.createdAt
    pic: user.pic
    email: user.email
    tests_count: parseInt user.testsCount
    tests_quota: parseInt user.testsQuota
    premium: user.premium
    referred_by: user.referredBy
    invitation_id: user.invitationId

  structuredBlock: (block) ->
    if block?

      page = block.page or null

      console.log @structuredPage?

      hash = 
        id: parseInt block.id
        row: parseInt block.row
        col: parseInt block.col
        row_span: parseInt block.rowSpan
        col_span: parseInt block.colSpan
        kind: block.kind
        content_invalid: block.contentInvalid
        page: @structuredPage page

  structuredPage: (page) ->
    if page?

      test = page.test or null

      hash =
        id: parseInt page.id
        number: parseInt page.number
        test: @structuredTest test

  structuredTest: (test) ->
    if test?

      folder = test.folder or null

      hash =
        id: parseInt test.id
        name: test.name
        folder: @structuredFolder folder

  structuredFolder: (folder) ->
    if folder?

      containingFolder = folder.folder or null

      hash =
        id: parseInt folder.id
        name: folder.name
        folder: @structuredFolder containingFolder

  structuredImage: (image) ->
    if image?

      block = image.block or null

      hash =
        id: parseInt image.id
        height: parseInt image.height
        width: parseInt image.width
        cloudinary_id: image.cloudinaryId
        block_position: parseInt image.blockPosition
        block: @structuredBlock block

  structuredTable: (table) ->
    if table?

      block = table.block or null

      hash =
        id: parseInt table.id
        rows_count: parseInt table.rows.length
        cols_count: parseInt table.cols.length
        block_position: parseInt table.blockPosition
        block: @structuredBlock block     

`export default StructureService`