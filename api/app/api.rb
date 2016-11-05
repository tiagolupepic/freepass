class Api < Roda
  include RequestHelper

  use Rack::Cors do
    allow do
      origins '*'
      resource '*',
        headers: :any,
        methods: [:get, :post, :delete, :put, :patch, :options, :head],
        expose: ['X-Total-Pages', 'X-Total-Count', 'X-Per-Page']
    end
  end

  route do |r|
    r.root do
      { name: 'Freepass' }
    end

    r.on 'users' do
      r.run Users
    end

    r.on 'holidays' do
      r.run Holidays
    end

    r.on 'hours' do
      r.run Hours
    end

    r.on 'cards' do
      r.run Cards
    end

    r.on 'periods' do
      r.run Periods
    end

    r.on 'admins' do
      r.run Admins
    end
  end
end
