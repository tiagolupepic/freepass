class Users < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is do
        errors_or_object User.create(params)
      end
    end

    r.is ":id" do |id|
      user = User.find(id)

      r.get do
        user
      end

      r.put do
        user.update_attributes(params) ? user : halt_request(422, { error: user.errors.full_messages })
      end

      r.delete do
        user.destroy
      end
    end
  end
end
