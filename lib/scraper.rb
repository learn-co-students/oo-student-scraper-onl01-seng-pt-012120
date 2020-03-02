require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = page.css(".student-card a")
    students.collect do |element|
      {:name => element.css(".student-name").text,
      :location => element.css(".student-location").text, :profile_url => element.attr("href")}
    end
  end
    
    

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    return_hash = {}
    attributes = page.css(".vitals-container .social-icon-container a")
    attributes.each do |element|
      if element.attr("href").include?("twitter")
        return_hash[:twitter] = element.attr('href')
      elsif element.attr('href').include?("linkedin")
        return_hash[:linkedin] = element.attr('href')
      elsif element.attr('href').include?("github")
        return_hash[:github] = element.attr('href')
      elsif element.attr('href').end_with?("com/")
        return_hash[:blog] = element.attr('href')
      end
    end
    return_hash[:profile_quote] = page.css(".vitals-container .vitals-text-container .profile-quote").text
    return_hash[:bio] = page.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

    return_hash
   
    
  end

end