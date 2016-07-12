class Api < Roda
  include RequestHelper

  route do |r|
    r.root do
      { name: 'Freepass' }
    end
  end
end
