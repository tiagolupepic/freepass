module Api
  class Users < Roda
    include RequestHelper
    include TokenAuthenticable
    include FilterParams

    route do |r|
      r.post do
        r.on 'auth' do
          auth = AuthenticatorService.new('user', params[:password]).run
          response.status = 403 unless auth[:success]
          auth
        end

        r.is do
          user = User.create(user_params)
          response.status = user.persisted? ? 201 : 422
          user
        end
      end

      r.put ':id/activated' do |id|
        user = find_user(id)
        user.activate!
        user
      end

      r.put ':id/deactivated' do |id|
        user = find_user(id)
        user.deactivate!
        user
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
      User.find(id.to_s.gsub('%2D', '-'))
    rescue ActiveRecord::RecordNotFound
      halt_request(404, { error: 'User not found.' })
    end
  end
end
