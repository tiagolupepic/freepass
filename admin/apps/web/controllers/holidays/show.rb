module Web::Controllers::Holidays
  class Show
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :holiday

    def call(params)
      @holiday = Holiday.find(params[:id])
    end
  end
end
