module Web::Controllers::Hours
  class Show
    include Web::Action
    expose :hour

    def call(params)
      @hour = Hour.find(params[:id])
    end
  end
end
