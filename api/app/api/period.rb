class Periods < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is do
        errors_or_object Period.create(params)
      end
    end

    r.is ":id" do |id|
      hour = Period.find(id)

      r.get do
        hour
      end

      r.put do
        hour.update_attributes(params) ? hour : halt_request(422, { error: hour.errors.full_messages })
      end

      r.delete do
        hour.destroy
      end
    end

    r.get do
      r.is do
        paginate Period.paginate(page: params[:page])
      end
    end
  end
end
