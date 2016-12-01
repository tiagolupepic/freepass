module Web::Controllers::Hours
  class Edit
    include Web::Action
    expose :hour

    def call(params)
      @hour = Hour.find(params[:id])
    end
  end
end
