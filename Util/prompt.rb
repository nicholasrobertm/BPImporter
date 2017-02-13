class Prompt

  attr_reader :id
  attr_reader :result
  attr_reader :promptText

  def initialize(uniqueIdentifier,promptText,datatype = nil)
    @id = uniqueIdentifier
    @promptText = promptText
    @datatype = datatype
  end

  def check
    puts "#{promptText}"

    case @datatype
      when "int"
        return gets.chomp.to_i
      when "string"
        return gets.chomp.to_s
      else
        return gets.chomp
    end
  end


end