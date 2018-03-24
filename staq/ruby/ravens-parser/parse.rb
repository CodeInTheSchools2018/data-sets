require "mechanize"
require "nokogiri"
require "pry"
require "csv"

agent = Mechanize.new

page = agent.get("https://en.wikipedia.org/wiki/2017_Baltimore_Ravens_season")
doc = Nokogiri::HTML(page.body)

table = doc.at('#mw-content-text > div > table:nth-child(29)')
rows = table.search('tr')

CSV.open("Ravens-Parser/file.csv", "w") do |csv|
  csv << ["Date", "Opponent", "Outcome", "Score", "Home?"]
  
  rows.each do |tr|
    cells = tr.search('td')
    next unless cells.length >= 5
  
    date = Date.parse("#{cells[0].text} 2017")
    opponent = cells[1].text
  
    outcome = cells[2].text[0]
    score = cells[2].text[2..-1]
  
    away = opponent.slice(0,2)
    if away == "at"
      at_home = false
      opponent.slice!(0,3)
    else
      at_home = true
    end
    csv << [date.to_s, opponent, outcome, score, at_home]
  end
  csv.close
end