json.extract! meeting, :id, :title, :description, :image_url, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
