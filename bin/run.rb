require_relative '../config/environment'



def bike_info
  sleep(3)
  "Our data contains information on 10,405 individual bikes, making 377293 trips. They had an average speed of 7.75 MPH. \nThe busiest bikes were:\n id 30453 --> 115, \n id 30458 --> 111, \n id 30720 --> 108, \n id 30484 --> 107, \n id 30605 --> 104, \n id 29973 --> 102, \n id 30695 --> 102, \n id 30638 --> 99, \n id 30790 --> 99, \n id 30721 --> 98}"
end

def trip_data
  sleep(5)
  "Our dataset includes 377293 trips from the month of September, with the longest being from Nostrand Ave & Myrtle Ave to Cathedral Pkwy & Broadway, with a distance of 13.5 covered in 1.15 hours, resulting in an estimated speed of 11.73 MPH."
end

def station_info
  sleep(6)
  "\nOur data shows 612 stations, with 89462 unique combinations between them.\nThe theoretical posssible number combinations of these stations is 374544.\nThe most frequently used stations are:\nPershing Square North ----> 6899\nWest St & Chambers St ----> 5442\nE 17 St & Broadway ----> 5075\nW 21 St & 6 Ave ----> 4755\n12 Ave & W 40 St ----> 4704\nBroadway & E 22 St ----> 4648\n8 Ave & W 31 St ----> 4485\nGrand Army Plaza & Central Park S ----> 4439\nBroadway & E 14 St ----> 4375\n8 Ave & W 33 St ----> 4267\n"
end

def demo_test(gender)
if gender == 1
  sleep(4)
  "\n151598 trips taken by Female riders between 25 and 45 years old:\n\nTotaling approximately 252341.2 miles traveled over 32320.92 hours \nexceeding Google's predicted time of 25366.77 hours by 6954.15 hours\naveraging a speed of 7.81 MPH\n\n\n58221 unique routes taken by Female riders between 25 and 45 years old:\nbetween 611 unique stations with the most frequently used being\n\nDEPARTURES:\nPershing Square North ----> 1627\n8 Ave & W 31 St ----> 1107\n8 Ave & W 33 St ----> 1047\nE 17 St & Broadway ----> 991\nBroadway & E 22 St ----> 980\nW 38 St & 8 Ave ----> 977\nW 41 St & 8 Ave ----> 957\nW 21 St & 6 Ave ----> 953\nBroadway & E 14 St ----> 889\nChristopher St & Greenwich St ----> 806\n\n\nARRIVALSs:\nPershing Square North ----> 1547\nBroadway & E 22 St ----> 1133\n8 Ave & W 31 St ----> 1054\nE 17 St & Broadway ----> 1050\nW 21 St & 6 Ave ----> 989\nE 47 St & Park Ave ----> 960\n8 Ave & W 33 St ----> 940\nW 38 St & 8 Ave ----> 925\nWest St & Chambers St ----> 923\nBroadway & E 14 St ----> 880\n"
else
  sleep(4)
  "\n54788 trips taken by Male riders between 25 and 45 years old:\n\nTotaling approximately 94132.1 miles traveled over 14089.65 hours \nexceeding Google's predicted time of 9522.07 hours by 4567.58 hours\naveraging a speed of 6.68 MPH\n\n\n31911 unique routes taken by Male riders between 25 and 45 years old:\nbetween 609 unique stations with the most frequently used being\n\nDEPARTURES:\nE 17 St & Broadway ----> 405\nW 21 St & 6 Ave ----> 398\nWest St & Chambers St ----> 359\nBroadway & E 22 St ----> 321\nBroadway & E 14 St ----> 300\nCarmine St & 6 Ave ----> 296\nCleveland Pl & Spring St ----> 289\nE 13 St & Avenue A ----> 282\n12 Ave & W 40 St ----> 277\nPershing Square North ----> 267\n\n\nARRIVALSs:\nW 21 St & 6 Ave ----> 469\nWest St & Chambers St ----> 457\nE 17 St & Broadway ----> 445\nBroadway & E 22 St ----> 390\nBroadway & E 14 St ----> 334\nCarmine St & 6 Ave ----> 303\n12 Ave & W 40 St ----> 296\nGreat Jones St ----> 292\nW 20 St & 11 Ave ----> 284\nW 18 St & 6 Ave ----> 275\n"
end
end

run
