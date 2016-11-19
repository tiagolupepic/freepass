class Users < Roda
  include RequestHelper
  include TokenAuthenticable
  include FilterParams

  route do |r|
    r.post do
      r.is do
        user = User.create(user_params)
        response.status = user.valid? ? 201 : 422
        user
      end
    end

    r.is ":id" do |id|
      user = User.find(id)

      r.get do
        user
      end

      r.put do
        user.update_attributes(user_params)
        response.status = 422 unless user.valid?
        user
      end

      r.delete do
        user.destroy
      end
    end

    r.get do
      r.is do
        paginate User.paginate(page: params[:page])
      end
    end
  end
end
