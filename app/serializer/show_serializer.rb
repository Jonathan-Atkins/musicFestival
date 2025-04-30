class ShowSerializer
  include JSONAPI::Serializer
  attributes :artist, :location, :date, :time
end