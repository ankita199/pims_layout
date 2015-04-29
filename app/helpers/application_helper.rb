module ApplicationHelper

  def me
  	current_user
  end

 def flash_class(level)
      case level
       when 'notice' then "alert alert-info"
       when 'success' then "alert alert-success"
       when 'error' then "alert alert-danger"
       when 'alert' then "alert alert-warning"
        end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def submit_button_tag(obj)
    if obj.new_record?
      submit_tag "Submit", :class => "btn btn-info",   data: {disable_with: "Saving..."}
    else
       submit_tag "Update", :class => "btn btn-info",   data: {disable_with: "Updating..."}
    end
  end
end
