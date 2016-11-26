class Hours < Roda
  include RequestHelper
  include TokenAuthenticable
  include FilterParams

  route do |r|
    r.post do
      r.is do
        hour = Hour.create(hour_params)
        response.status = hour.persisted? ? 201 : 422
        hour
      end
    end

    r.is ":id" do |id|
      hour = Hour.find(id)

      r.get do
        hour
      end

      r.put do
        hour.update_attributes(hour_params)
        response.status = 422 unless hour.valid?
        hour
      end

      r.delete do
        hour.destroy
      end
    end

    r.get do
      r.is do
        paginate Hour.paginate(page: params[:page])
      end
    end
  end
end
