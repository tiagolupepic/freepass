module Web::Controllers::Holidays
  class New
    include Web::Action
    expose :holiday

    def call(params)
      @holiday = Holiday.new
    end
  end
end
