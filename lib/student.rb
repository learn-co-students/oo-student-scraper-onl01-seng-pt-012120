class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) #looping through students and adding attributes to individual students
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value) #assigns newly created student attributes key value pairs using send
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash| #takes in an array of hashes
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value) #assigns key/value pairs
  end
    self
  end

  def self.all #returns contents of the @@all array
    @@all
  end
end
