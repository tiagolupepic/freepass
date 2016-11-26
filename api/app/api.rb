class FreePass < Roda
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
      r.run Api::Users
    end

    r.on 'holidays' do
      r.run Api::Holidays
    end

    r.on 'hours' do
      r.run Api::Hours
    end

    r.on 'cards' do
      r.run Api::Cards
    end

    r.on 'periods' do
      r.run Api::Periods
    end

    r.on 'admins' do
      r.run Api::Admins
    end
  end
end
