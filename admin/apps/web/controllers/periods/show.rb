module Web::Controllers::Periods
  class Show
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :period

    def call(params)
      @period = Period.find(params[:id])
    end
  end
end
