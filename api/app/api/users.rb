module Api
  class Users < Roda
    include RequestHelper
    include TokenAuthenticable
    include FilterParams

    route do |r|
      r.post do
        r.is do
          user = User.create(user_params)
          response.status = user.persisted? ? 201 : 422
          user
        end
      end

      r.is ":id" do |id|
        user = find_user(id)

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
        r.on :param => 'q' do
          paginate User.search(params[:q]).paginate(page: params[:page])
        end

        r.is do
          paginate User.paginate(page: params[:page])
        end
      end
    end

    def find_user(id)
      User.find(id)
    rescue ActiveRecord::RecordNotFound
      halt_request(404, { error: 'User not found.' })
    end
  end
end
