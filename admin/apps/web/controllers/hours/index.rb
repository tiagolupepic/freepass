module Web::Controllers::Hours
  class Index
    include Web::Action
    expose :hours

    def call(params)
      @hours = params[:q].present? ? Hour.where(q: params[:q]) : Hour.all
    end
  end
end
