module Api
  class Events < Roda
    include RequestHelper
    include TokenAuthenticable

    route do |r|
      r.get do
        Event.order('created_at DESC').all
      end
    end
  end
end
