class MenuOption
  def initialize(menuText,requestHandler,requestMethod)
    @menuText = menuText
    @requestHandler = requestHandler
    @requestMethod = requestMethod
  end

  public
  def displayText()
    puts @menuText
  end

  public
  def call
    entering = true
    params = Array.new()
    while entering do
      param = -1
      puts "Please enter any parameters,-1 to stop"
      param = gets.chomp
      entering = false if param == -1 || param == "-1" || param.nil?
      params << param if param.to_i != -1

    end
    @requestHandler.call(@requestHandler.buildRequestURL(@requestMethod.uri,'get',params),'get',params,nil)
  end

  private
  def paramPrompt
    puts "Please enter any parameters,-1 to stop"
    return gets.chomp
  end
end