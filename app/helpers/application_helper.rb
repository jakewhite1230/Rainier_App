module ApplicationHelper
 def gravatar_url(email)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
def tenant_name(tenant_id)
	Tenant.find(tenant_id).name
end

def s3_link(tenant_id, upload_key)
	link_to upload_key, "#{upload_key}", target: 'new'
end

def nav_link(link_text, link_path)
  class_name = current_page?(link_path) ? 'active' : ''

  content_tag(:li, :class => class_name) do
    link_to link_text, link_path
  end
end

end
