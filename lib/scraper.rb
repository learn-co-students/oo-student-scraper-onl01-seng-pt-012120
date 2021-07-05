require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

  def self.scrape_index_page(index_url)
    a = Nokogiri::HTML(open(index_url))
    b = a.css("div.student-card")
    c = []
    b.each do |x|
      c << {:name => x.css("h4.student-name").text,
      :location => x.css("p.student-location").text,
      :profile_url => x.css("a").first["href"]}
    end
    c
  end

  def self.scrape_profile_page(profile_url)
    a = Nokogiri::HTML(open(profile_url))
    c = a.css("div.social-icon-container")
    b = {}
    c.css("a").each do |x|
      if x['href'].include?("twitter")
        b[:twitter] = x['href']
      elsif x['href'].include?("linkedin")
        b[:linkedin] = x['href']
      elsif x['href'].include?("github")
        b[:github] = x['href']
      else
        b[:blog] = x['href']
      end
    end
    b[:profile_quote] = a.css("div.profile-quote").text
    b[:bio] = a.css("div.description-holder").text.strip.split("\n").first
    b
  end
end

