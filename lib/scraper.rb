require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = Nokogiri::HTML(open(index_url))
    
    cards = html.css("div.student-card")
    cards.each do |student|
      profiles = {}
        profiles[:name] = student.css(".student-name").text
        profiles[:location] = student.css(".student-location").text 
        profiles[:profile_url] = student.css("a").attribute("href").value
        students << profiles
      end 
      students 
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    page.css(".social-icon-container a").each do |site|
      if site.attribute("href").value.include?("twitter")
        profile[:twitter] = site.attribute("href").value
      elsif site.attribute("href").value.include?("linkedin")
        profile[:linkedin] = site.attribute("href").value
      elsif site.attribute("href").value.include?("github")
        profile[:github] = site.attribute("href").value
      else 
        profile[:blog] = site.attribute("href").value 
      end
    end 
      profile[:profile_quote] = page.css("div.vitals-text-container .profile-quote").text 
      profile[:bio] = page.css("div.main-wrapper.profile .description-holder p").text 
      
      profile 
    end 

end

