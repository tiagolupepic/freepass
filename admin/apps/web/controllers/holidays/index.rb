module Web::Controllers::Holidays
  class Index
    include Web::Action
    include AdminAuthenticator
    before :authenticate!
    expose :holidays

    def call(params)
      @holidays = params[:q].present? ? Holiday.where(q: params[:q]) : Holiday.all
    end
  end
end
