Factory.define :user do |u|
  u.facebook_id "1"
  u.admin false
  u.researcher false
end

Factory.define :admin, :class => User do |u|
  u.facebook_id "1"
  u.admin true
  u.researcher false
end

Factory.define :reseacher, :class => User do |u|
  u.facebook_id "1"
  u.admin false
  u.researcher false
end