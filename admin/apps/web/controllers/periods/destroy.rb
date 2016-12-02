module Web::Controllers::Periods
  class Destroy
    include Web::Action

    def call(params)
      period = Period.find(params[:id])
      period.destroy
      redirect_to routes.periods_path
    end
  end
end
