structure = 

  user: (user) ->
    id: parseInt user.id
    guest: user.guest
    name: user.name
    createdAt: user.createdAt
    pic: user.pic
    email: user.email
    testsCount: parseInt user.testsCount
    testsQuota: parseInt user.testsQuota
    premium: user.premium
    referredBy: user.referredBy

  block: (block) ->
    row: parseInt block.row
    col: parseInt block.col
    rowSpan: parseInt block.rowSpan
    colSpan: parseInt block.colSpan
    kind: col.kind

`export default structure`