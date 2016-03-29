puts ''
puts '== Running database seeds =='
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  start = Time.new
  load seed
  stop = Time.new
  puts "-- #{seed}"
  puts "   -> #{stop - start}s"
end
