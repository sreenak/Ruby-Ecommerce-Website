json.id @dress.id
json.name @dress.name
json.angle_0 @dress.angle_0.url
json.angle_90 @dress.angle_90.url
json.angle_180 @dress.angle_180.url
json.angle_270 @dress.angle_270.url
json.currency @cart.currency
json.base_price @dress.base_price.exchange_to(@cart.currency).to_f
json.fabric_groups @dress.fabric_parts_groups do |fabric_part_group|
  json.id fabric_part_group.id
  json.name fabric_part_group.name
  json.type fabric_part_group.type
  json.svg_group_id fabric_part_group.svg_group_id
  json.parts fabric_part_group.parts do |part|
    json.id part.id
    json.name part.name
    json.svg_path_id part.svg_path_id
    json.brocade_parts part.brocade_parts do |brocade_part|
      json.brocade_id brocade_part.brocade.id
      json.name brocade_part.brocade.name
      json.swatch brocade_part.brocade.swatch.url
      json.image brocade_part.image.url
      json.price brocade_part.price.exchange_to(@cart.currency).to_f
      json.size ::MiniMagick::Image.open(brocade_part.image.path)[:dimensions]
    end
  end
  json.fabric_colors fabric_part_group.fabric_group_colors do |fabric_group_color|
    json.fabric_id fabric_group_color.fabric_color.fabric.id
    json.fabric_name fabric_group_color.fabric_color.fabric.name
    json.id fabric_group_color.fabric_color.id
    json.name fabric_group_color.fabric_color.name
    json.swatch fabric_group_color.fabric_color.swatch.url
    json.price fabric_group_color.price.exchange_to(@cart.currency).to_f
    json.size ::MiniMagick::Image.open(fabric_group_color.fabric_color.swatch.path)[:dimensions]
  end
end
json.embelishment_groups @dress.embellishment_parts_groups do |embellishment_part_group|
  json.id embellishment_part_group.id
  json.name embellishment_part_group.name
  json.type embellishment_part_group.type
  json.svg_group_id embellishment_part_group.svg_group_id
  json.parts embellishment_part_group.parts do |part|
    json.id part.id
    json.name part.name
    json.svg_path_id part.svg_path_id
    json.embellishment_parts part.embellishment_parts do |embellishment_part|
      json.id embellishment_part.embellishment_id
      json.name embellishment_part.embellishment.name
      json.name embellishment_part.embellishment.image.url
      json.image embellishment_part.image.url
      json.size ::MiniMagick::Image.open(embellishment_part.image.path)[:dimensions]
    end
  end
end