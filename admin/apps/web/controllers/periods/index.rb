module Web::Controllers::Periods
  class Index
    include Web::Action
    expose :periods

    def call(params)
      @periods = Period.all
    end
  end
end
