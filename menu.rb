#!/usr/bin/ruby

class Menu
  require 'handlers/request_handler'
  require 'handlers/request_method_handler'
  require 'handlers/response_handler'
  require './Util/prompt'
  require './Util/menu_option'
  require './Util/json_to_csv'
  attr_accessor :running
  attr_accessor :Reports
  @@selections = Array.new
  @@endpoints = Array.new
  def initalize
    @Reports = Array.new
    @Imports = Array.new
    init
    update
  end

  public
  def init
    @@selections << Prompt.new('mainMenu', "Welcome to the Brightpearl Console Utility\nPlease enter a valid menu selection by number (1,2,3,etc)\n1. Reports\n2. Imports\n-1. Exit", 'int')
    @@selections << Prompt.new('reportSelection', "Please enter your report export selection by number (1,2,3,4 etc)-1. Cancel", 'int')
    @@selections << Prompt.new('outputFile', "Please enter output file location(or press enter for default)", 'string')
    @@selections << Prompt.new('writetocsv', "Would you like to write to CSV(Y/N)?",'string')
    puts 'Please enter app Reference'
    appRef = gets.chomp.to_s
    puts 'Please enter app token'
    appToken = gets.chomp.to_s
    puts 'Please enter account ID'
    acctID = gets.chomp.to_s
    puts 'Please enter datacenter'
    dc = gets.chomp.to_s

    @requestHandler = RequestHandler.new(appRef,appToken,acctID,dc,'public-api')
    req = RequestMethodHandler.new()
    @getMethods = req.getRequestMethodsOfType('get')
    @responseHandler = ResponseHandler.new(@requestHandler.responseQueue)
    @getMethods.each_with_index do |x,index|
      @@endpoints << MenuOption.new("#{index}. #{x.name}",@requestHandler,x)
    end

  end

  public
  def update
    begin
      selection = getSelection('mainMenu').check
      case selection
        when 1
          reports
        when 2
          imports
        when -1
          save
          exit
      end
    end while !running
  end


  def reports
    @@endpoints.each do |x|
      x.displayText
    end
    selection = getSelection('reportSelection').check
    @@endpoints[selection].call unless @@endpoints[selection].nil?
    @requestHandler.update()
    @responseHandler.updateHash(@requestHandler.responseQueue)
    writeToCSV = getSelection('writetocsv').check
    case writeToCSV
      when 'Y' || 'y'
        puts 'Please input file name(Just the name, do not add a .csv)'
        fn = gets.chomp
        localizedFile = Util.getLocalizedFile("#{fn}.csv")
        Util.JsonToCSV(@responseHandler.responseHash.values.first.body,localizedFile)
      when 'N' || 'n'

    end

    @responseHandler.clearResponseHash
    return
  end

  def imports
    puts "Please enter your import selection #"
    puts "1. Warehouse Locations"
    puts "2. Addresses"
    puts "-1. Cancel"
    selection = gets.chomp.to_i

    case selection
      when 1
        puts "Please enter output file location(or press enter for default)"
        inputFile = gets.chomp
      when 2
        puts "Please enter output file location(or press enter for default)"
        inputFile = gets.chomp

        puts "Please enter which type of addresses to import"
        puts "1. Primary"
        puts "2. Invoice"
        puts "3. Delivery"

        addressChoice = gets.chomp.to_i

      when -1
        system("clear")
    end
  end

  def getSelection(name)
    @@selections.each do |x|
      if x.id == name
        return x
      end
    end
  end
  def save

  end
end

m = Menu.new
m.init
puts (m)
puts(m.running)
m.update