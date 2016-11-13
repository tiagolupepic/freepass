class Users < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is do
        user = User.create(params)
        response.status = 422 unless user.valid?
        user
      end
    end

    r.is ":id" do |id|
      user = User.find(id)

      r.get do
        user
      end

      r.put do
        user.update_attributes(params)
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
