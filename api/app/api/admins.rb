module Api
  class Admins < Roda
    include RequestHelper
    include TokenAuthenticable

    route do |r|
      r.post do
        r.is 'auth' do
          auth = AuthenticatorService.new('admin', params).run
          response.status = 403 unless auth[:success]
          auth
        end
      end
    end
  end
end
