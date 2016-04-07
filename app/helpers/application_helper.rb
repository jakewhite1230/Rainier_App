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

end
