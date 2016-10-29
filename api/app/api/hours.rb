class Hours < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is do
        errors_or_object Hour.create(params)
      end
    end

    r.is ":id" do |id|
      hour = Hour.find(id)

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
        Hour.all
      end
    end
  end
end
