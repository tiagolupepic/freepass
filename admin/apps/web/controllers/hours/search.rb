module Web::Controllers::Hours
  class Search
    include Web::Action
    accept :html, :json
    expose :hours

    def call(params)
      @hours = Hour.where(q: params[:q])
    end
  end
end
