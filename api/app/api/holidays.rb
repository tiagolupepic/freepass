module Api
  class Holidays < Roda
    include RequestHelper
    include TokenAuthenticable
    include FilterParams

    route do |r|
      r.post do
        r.is do
          holiday = Holiday.create(holiday_params)
          response.status = holiday.persisted? ? 201 : 422
          holiday
        end
      end

      r.is ":id" do |id|
        holiday = find_holiday(id)

        r.get do
          holiday
        end

        r.put do
          holiday.update_attributes(holiday_params)
          response.status = 422 unless holiday.valid?
          holiday
        end

        r.delete do
          holiday.destroy
        end
      end

      r.get do
        r.on :param => 'q' do
          paginate Holiday.search(params[:q]).paginate(page: params[:page])
        end

        r.is do
          paginate Holiday.paginate(page: params[:page])
        end
      end
    end

    def find_holiday(id)
      Holiday.find(id)
    rescue ActiveRecord::RecordNotFound
      halt_request(404, { error: 'Holiday not found.' })
    end
  end
end
