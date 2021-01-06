# RSpec.configure do |c|
#     c.before(:suite) do # suite-level hook. This run before any suite that uses this configuration
#         Sequel.extension :migration # creates the tables in the schema
#         Sequel::Migrator.run(DB, 'db/migrations')
#         DB[:expenses].truncate # truncate cleans left over test data from the table 
#     end
# end
# Migrate data to the database 
RSpec.configure do |c|
    c.before(:suite) do
      Sequel.extension :migration
      Sequel::Migrator.run(DB, 'db/migrations')
      DB[:expenses].truncate
    end

    c.around(:example, :db) do |example|
      DB.transaction(rollback: :always) {example.run}
    end
end