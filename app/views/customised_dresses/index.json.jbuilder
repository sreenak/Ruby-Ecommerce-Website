json.array! @customised_dresses do |dress|
  json.user_id dress.user_id
  json.dress_id dress.dress_id
  json.details dress.details
  json.image dress.image_url(:medium)
end