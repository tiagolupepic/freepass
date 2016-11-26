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
      holiday = Holiday.find(id)

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
      r.is do
        paginate Holiday.paginate(page: params[:page])
      end
    end
  end
end
