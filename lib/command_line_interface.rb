require 'pry'
# def bike_info
#   puts "here's your trip info"
# end
#
# def trip_info
#   "here's your trip info"
# end
#
# def station_info
#   "here's your station info"
# end
#
# def demo_test(stats)
#   Demographic.find_by(stats)
# end

def demo_info
  puts "To learn more about the demographics of CitiBike rider, please specify membership, gender, and age range"

  puts "Select Gender as 'Male' or 'Female'"
  gender = gets.chomp
    if gender == "Female"
      gender = 1
    else gender = 2
    end

  puts "Select Membership Type as 'Subscriber' or 'Customer'"
  membership = gets.chomp
    if membership == "Subscriber"
      membership = true
    else
      membership = false
    end

  puts "Select age range
  A. 1 - 17 years of age
  B. 18 - 24 years of age
  C. 25 - 45 years of age
  D. 46 - 64 years of age
  E. 65 - 100 years of age"

  age_range = gets.chomp
  age_range.upcase

  if age_range == 'A'
    min_age = 1
    max_age = 17
  elsif age_range == 'B'
    min_age = 18
    max_age = 24
  elsif age_range == 'C'
    min_age = 25
    max_age = 45
  elsif age_range == 'D'
    min_age = 45
    max_age = 64
  else
    min_age = 65
    max_age = 100
  end
  stats = {gender: gender, is_member: membership, min_age: min_age, max_age: max_age}
  demo_test(gender)
end

def welcome
  puts  "Welcome to the CitiBike Usage platform. Use this application to analyze data about CitiBike usage."
end

def exit_program
  puts "Goodbye"
end

def menu
  puts "Please select a category. Choose from:
      D = Rider Demographics
      T = Trip Information
      S = Station Information
      B = Bike Information

    Type 'exit' to exit program or 'menu' to return to menu"
end

def get_topic
  topic = gets.chomp.upcase
end

def run
  puts""
  puts""
  welcome
  menu
  input = ""
  while input
    input = get_topic
    case input
      when 'D'
       puts demo_info
      when 'T'
       puts trip_data
      when 'S'
        puts station_info
      when 'B'
        puts bike_info
      when 'MENU'
        menu
      when 'EXIT'
        exit_program
        break
      else
        menu
    end
  end
end
