module ApplicationHelper
  def active_link text, url
    link_class = active_class url
    link_to text, url, class: link_class
  end

  def active_class url
    current_page?(url) ? 'active' : ''
  end
  
  def current_or_null_user
    if current_user == nil
      User.new
    else
      current_user
    end
  end

  def user_avatar user
    if user.image.present?
      image_tag user.image_url :thumbnail
    else
      image_tag 'default.png'
    end
  end

  def deep_active_class url
    request.original_url.starts_with?(url) ? 'active' : ''
  end

  def bootstrap_class_for flash_type
    {success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x', class: "close", data: {dismiss: 'alert'})
               concat message.html_safe
             end)
    end
    nil
  end

  def horizontal_simple_form_for(path, options = {}, &block)
    options = options.deep_merge(html: {class: 'form-horizontal'}, wrapper: :horizontal_small_form)
    simple_nested_form_for(path, options, &block)
                                        end


end
