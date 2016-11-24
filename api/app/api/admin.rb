class Admins < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is 'auth' do
        auth = AdminAuthenticator.new(params[:password])
        response.status = 403 unless auth.valid?
        { success: auth.valid?, user: auth.object }
      end
    end
  end
end
