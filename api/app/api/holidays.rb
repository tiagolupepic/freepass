class Holidays < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is do
        errors_or_object Holiday.create(params)
      end
    end

    r.is ":id" do |id|
      holiday = Holiday.find(id)

      r.get do
        holiday
      end

      r.put do
        holiday.update_attributes(params) ? holiday : halt_request(422, { error: holiday.errors.full_messages })
      end

      r.delete do
        holiday.destroy
      end
    end

    r.get do
      r.is do
        Holiday.all
      end
    end
  end
end
