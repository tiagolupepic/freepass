module Web::Controllers::Periods
  class New
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :period

    def call(params)
      @period = Period.new
    end
  end
end
