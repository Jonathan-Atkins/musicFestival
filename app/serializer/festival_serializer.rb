class FestivalSerializer
  include JSONAPI::Serializer

  attribute :name

  attribute :attendee_count do |festival|
    festival
      .stages
      .flat_map(&:shows)
      .flat_map(&:users)
      .uniq
      .count
  end
end
