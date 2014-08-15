require 'pg'
require 'rspec'

require 'ringmaster'
require 'student'
require 'teacher'


DB = PG.connect({:dbname => 'aerial_playground_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM students *;")
    DB.exec("DELETE FROM teachers *;")
  end
end

