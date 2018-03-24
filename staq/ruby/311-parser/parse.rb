require "typhoeus"
require "pathname"

request_url = "https://data.baltimorecity.gov/resource/2ddy-2uzt.csv"
api_token = "qq0tU1zDfSVSOkTotw3ckcfHK"
file_name = "311-data.csv"

headers = {
  "X-App-Token": api_token
}

params = {
  "$limit": 600000,
  "$where": "violdate between '2017-01-01T00:00:00' and '2017-12-31T23:59:59'"
}

request_options = {
  method: :get,
  followlocation: true,
  headers: headers,
  params: params
}

report_path = Pathname.new(file_name)
request = Typhoeus::Request.new(request_url,request_options)

report_path.open("wb") do |downloaded_file|
  request.on_body do |chunk|
    downloaded_file.write(chunk)
  end

  request.run
end

