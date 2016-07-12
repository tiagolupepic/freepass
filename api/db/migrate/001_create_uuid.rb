class CreateUuid < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"');
  end
end
