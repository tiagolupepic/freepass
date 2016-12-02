module Web::Controllers::Periods
  class New
    include Web::Action
    expose :period

    def call(params)
      @period = Period.new
    end
  end
end
