json.array!(@uploads) do |upload|
  json.extract! upload, :id, :name, :key, :project_id
  json.url upload_url(upload, format: :json)
end
