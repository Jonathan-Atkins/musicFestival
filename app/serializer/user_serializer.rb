class UserSerializer
  include JSONAPI::Serializer

  attributes :first_name, :last_name, :email, :username, :birthday

  attribute :schedule_id do |user|
    user.schedule&.id
  end
end
