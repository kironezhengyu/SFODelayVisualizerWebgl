## Usage: ruby convert.rb data_file.json

require 'json'

data = JSON.parse(IO.read(ARGV[0]))

coordinates = []
scale_factor = 0.0000007

data['rows'].each do |row|
  coordinates << row["latitude"].to_f << row["longitude"].to_f << (row["downloads"] * scale_factor).to_f
end

File.open 'downloads.json', 'w' do |f|
  f.write [['2013', coordinates]].to_json
end