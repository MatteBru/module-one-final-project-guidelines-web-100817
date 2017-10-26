require 'pry'

# demo_info = Demographics.data
# bike_info = Bike.data
# trip_info= Trip.data
# station_info = Station.data


def welcome
  puts  "Welcome to the CitiBike Usage platform. Use this application to analyze data about CitiBike usage."
end

def menu
  puts "Please select a category. Choose from:
      D = Rider Demographics
      T = Trip Information
      S = Station Information
      B = Bike Information
      Or type exit to exit program."
      input = gets.chomp
end



# input = ""
#  while input
#    case input
#    when 'D'
#      demo_info
#    when 'T'
#     trip_info
#   when 'S'
#      station_info
#    when 'B'
#       station_info
#    when 'exit'
#      break
#    else
#      menu
#    end
# end
