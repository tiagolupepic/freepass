module Web::Controllers::Holidays
  class Index
    include Web::Action
    expose :holidays

    def call(params)
      @holidays = Holiday.all
    end
  end
end
