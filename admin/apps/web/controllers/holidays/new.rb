module Web::Controllers::Holidays
  class New
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :holiday

    def call(params)
      @holiday = Holiday.new
    end
  end
end
