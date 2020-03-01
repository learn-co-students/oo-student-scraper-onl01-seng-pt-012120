require 'nokogiri'
require 'open-uri'
require 'pry'

# {:name=>"Ryan Johnson",
#  :location=>"New York, NY",
#  :profile_url=>
#   "https://learn-co-curriculum.github.io/students/ryan-johnson.html"}

  class Scraper

    def self.scrape_index_page(index_url)
      students =[]
      html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/")
      index = Nokogiri::HTML(html)
      index.css("div.roster-cards-container").each do |student|
        student.css(".student-card a" ).each do |details|
          # binding.pry
       student_details = {}
        student_details[:name] = details.css(".student-name").text
         student_details[:location] = details.css(".student-location").text
      #   profile_path = student.css("a").attribute("href").value
        student_details[:profile_url] = details.attr("href")
        students << student_details
    end

      end
       return students
    end


  #   def self.scrape_index_page(index_url)
  #     students_hash = []
  #     html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/")
  #     doc = Nokogiri::HTML(html)
  #     doc.css(".student-card").each do |student|
  #       hash = {}
  #       hash[location:]= student.css("p.student-location").text,
  #       hash[name:] student.css("h4.student-name").text,
  #       hash[profile_url:]= "https://learn-co-curriculum.github.io/" + student.css("a").attribute("href")
   #
  #     students_hash << hash
  #    end
  #    students_hash
  #  end




  def self.scrape_profile_page(profile_url)

    student_profile = {}
        html = open(profile_url)
        profile = Nokogiri::HTML(html)

        # Social Links

        profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
          if social.attribute("href").value.include?("twitter")
            student_profile[:twitter] = social.attribute("href").value
          elsif social.attribute("href").value.include?("linkedin")
            student_profile[:linkedin] = social.attribute("href").value
          elsif social.attribute("href").value.include?("github")
            student_profile[:github] = social.attribute("href").value
          else
            student_profile[:blog] = social.attribute("href").value
          end
        end

        student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
        student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

        student_profile
      end
    end
