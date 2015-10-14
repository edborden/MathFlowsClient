user = (user) ->
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