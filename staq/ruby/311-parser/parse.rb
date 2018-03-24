# https://dev.socrata.com/foundry/data.baltimorecity.gov/9agw-sxsr

require "typhoeus"
require "csv"

#request_url = "https://data.baltimorecity.gov/resource/9agw-sxsr.csv"
request_url = "https://data.baltimorecity.gov/resource/2ddy-2uzt.csv"
api_token = "qq0tU1zDfSVSOkTotw3ckcfHK"

headers = { "X-App-Token": api_token }
params = { "$limit": 600000, "$where": "violdate between '2017-01-01T00:00:00' and '2017-12-31T23:59:59'" }
response = Typhoeus.get request_url,headers: headers,params: params

options = {
  header_converters: :symbol,
  headers: true,
  skip_blanks: true
}

CSV.parse(response.body,options) do |row|
  puts row.to_hash
end