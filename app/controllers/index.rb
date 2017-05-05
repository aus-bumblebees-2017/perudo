get '/' do 
  page = ParseHelper.parse_page
  @today_wave_range = ParseHelper.today_wave_height(page)
  @today_temp = ParseHelper.today_sea_temp(page)
  waves_range = ParseHelper.wave_heights_by_hour(page)
  squeezed_days = ParseHelper.squeeze(waves_range)
  @split_squeezed_days = ParseHelper.split_by_hour(squeezed_days)
  erb :index
end


