class Admins < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is 'auth' do
        response.status = 403 if params[:password].blank?
        { success: params[:password].present? }
      end
    end
  end
end
