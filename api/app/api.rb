class Api < Roda
  include RequestHelper

  route do |r|
    r.root do
      { name: 'Freepass' }
    end

    r.on 'users' do
      r.run Users
    end
  end
end
