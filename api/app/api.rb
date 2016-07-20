class Api < Roda
  include RequestHelper

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
  end
end
