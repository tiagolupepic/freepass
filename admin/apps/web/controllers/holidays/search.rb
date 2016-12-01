module Web::Controllers::Holidays
  class Search
    include Web::Action
    accept :html, :json
    expose :holidays

    def call(params)
      @holidays = Holiday.where(q: params[:q])
    end
  end
end
