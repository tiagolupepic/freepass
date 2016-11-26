class Periods < Roda
  include RequestHelper
  include TokenAuthenticable
  include FilterParams

  route do |r|
    r.post do
      r.is do
        period = Period.create(period_params)
        response.status = period.persisted? ? 201 : 422
        period
      end
    end

    r.is ":id" do |id|
      period = Period.find(id)

      r.get do
        period
      end

      r.put do
        period.update_attributes(period_params)
        response.status = 422 unless period.valid?
        period
      end

      r.delete do
        period.destroy
      end
    end

    r.get do
      r.is do
        paginate Period.paginate(page: params[:page])
      end
    end
  end
end
