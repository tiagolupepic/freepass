module Web::Controllers::Hours
  class Index
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :hours

    def call(params)
      @hours = params[:q].present? ? Hour.where(q: params[:q]) : Hour.all
    end
  end
end
