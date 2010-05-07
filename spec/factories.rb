Factory.define :user do |u|
  u.facebook_id = "1"
  u.admin = false
  u.researcher = false
end

Factory.define :admin_user do |u|
  u.facebook_id = "1"
  u.admin = true
  u.researcher = false
end

Factory.define :reseacher do |u|
  u.facebook_id = "1"
  u.admin = false
  u.researcher = false
end