require 'open-uri'
require 'nokogiri'
require 'pry'



class Scraper


# name:         doc.css(".student-card")[0].css("h4").text
# location:     doc.css(".student-card")[0].css(".student-location").text

# profile_url:  doc.css(".student-card")[0].css('a')[0].values.join
#        -or-   doc.css(".student-card")[0].css('a').first.attributes['href'].value
#               doc.css(".student-card")[0].css('a')[0].attributes['href'].value

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_arr = []
    doc.css('.student-card').each do |student|
      student_hash = {
        :name => student.css('h4').text,
        :location => student.css(".student-location").text,
        :profile_url => student.css('a').first.attributes['href'].value
      }
      student_arr << student_hash
    end
    student_arr
  end

  # url:          doc.search('.social-icon-container')[0].children.css("a")[0].attributes['href'].value
  # social-asset: doc.search('.social-icon-container')[0].children.css(".social-icon")[0].attributes["src"].value
  # "../assets/img/twitter-icon.png".split(Regexp.union("../assets/img/","-icon.png")).reject(&:empty?).join

# social.children.children.first.attributes['src'].value.split(Regexp.union("../assets/img/","-icon.png")).reject(&:empty?).join

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    # doc.search
    profile_hash = {}
    
    # SOCIAL MEDIA ======================
    doc.css('.social-icon-container').children.each do |social|
      binding.pry
      social_media = social.children[1].search('.social-icon')[0].attributes['src'].value.split(Regexp.union("../assets/img/","-icon.png")).reject(&:empty?).join.to_sym
      social_url = social.children.css("a")[0].attributes['href'].value
      if social_media == 'rss'
        profile_hash[:blog] = social_url
      else
        profile_hash[social_media] = social_url
      end
    end
    
    # PROFILE QUOTE =============================
    profile_hash[:profile_quote] = doc.search(".profile-quote").text
    
    # FINAL RETURNED HASH =======================
    profile_hash
  end

end
