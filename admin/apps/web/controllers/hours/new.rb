module Web::Controllers::Hours
  class New
    include Web::Action
    expose :hour

    def call(params)
      @hour = Hour.new
    end
  end
end
