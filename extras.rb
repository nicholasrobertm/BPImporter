case selection #From menu_option.rb
  when 1
    @requestHandler.call('/warehouse-service/warehouse','get')
    @requestHandler.update(1)
    @responseHandler.updateHash(@requestHandler.responseQueue)
    resp = @responseHandler.getResponsesByURI(@requestHandler.buildRequestURL('/warehouse-service/warehouse','get',nil))
    Util.JsonToCSV(resp[0].body,'C:\\Users\\Rob\\Desktop\\test.csv')
  when 2
    Util.JToCSV(Util.getLocalizedFile('test2.json'),Util.getLocalizedFile('test.csv'))
  when 3
    Util.JToCSV(Util.getLocalizedFile('test.json'),Util.getLocalizedFile('test.csv'))
  when 4

  when -1
    system("clear")
end