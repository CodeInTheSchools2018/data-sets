require "mechanize"
require "nokogiri"
require "pry"
require "csv"

agent = Mechanize.new

page = agent.get("http://www.baseball-almanac.com/teamstats/schedule.php?y=2017&t=BAL")
doc = Nokogiri::HTML(page.body)

table = doc.search(".boxed")
rows = table.search('tr')

CSV.open("Orioles-Parser/file.csv", "w") do |csv|
  rows.each do |tr|
    cells = tr.search('td')

    next unless cells.length == 6
    csv << [cells[0].text, cells[1].text, cells[2].text, cells[3].text, cells[4].text]
  end
  csv.close
end