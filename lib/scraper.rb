require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      student_hash = {
        name: student.css("h4.student-name").text, 
        location: student.css("p.student-location").text, 
        profile_url: student.css("a").attribute("href").value 
      }
      students << student_hash
  end
  students 
end 

  def self.scrape_profile_page(profile_url)
    profiles_hash = {}
    profile = Nokogiri::HTML(open(profile_url))
    profile.css("div.social-icon-container a").each do |social|
       if social.attribute("href").value.include?("twitter")
         profiles_hash[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        profiles_hash[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        profiles_hash[:github] = social.attribute("href").value
      else
        profiles_hash[:blog] = social.attribute("href").value
      end 
      end 
      profiles_hash[:profile_quote] = profile.css("div.profile-quote").text 
      profiles_hash[:bio] = profile.css("div.description-holder p").text 
      profiles_hash 
  end

end

