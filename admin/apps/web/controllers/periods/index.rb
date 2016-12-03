module Web::Controllers::Periods
  class Index
    include Web::Action
    expose :periods

    def call(params)
      @periods = params[:q].present? ? Period.where(q: params[:q]) : Period.all
    end
  end
end
