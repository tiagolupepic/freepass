module Web::Controllers::Hours
  class Destroy
    include Web::Action
    include AdminAuthenticator
    before :authenticate!

    def call(params)
      hour = Hour.find(params[:id])
      hour.destroy
      redirect_to routes.hours_path
    end
  end
end
