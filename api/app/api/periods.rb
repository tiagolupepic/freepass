module Api
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
        period = find_period(id)

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

    def find_period(id)
      Period.find(id)
    rescue ActiveRecord::RecordNotFound
      halt_request(404, { error: 'Period not found.' })
    end
  end
end
