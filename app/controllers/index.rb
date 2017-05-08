get '/' do 
  page = ParseHelper.parse_page
  @today_wave_range = ParseHelper.today_wave_height(page)
  @today_temp = ParseHelper.today_sea_temp(page)
  waves_range = ParseHelper.wave_heights_by_hour(page)
  squeezed_days = ParseHelper.squeeze(waves_range)
  @split_squeezed_days = ParseHelper.split_by_hour(squeezed_days)
  erb :index
end

post '/details' do
  day_num = params[:day]
  page = ParseHelper.parse_page
  waves_range = ParseHelper.wave_heights_by_hour(page)
  squeezed_days = ParseHelper.squeeze(waves_range)
  split_squeezed_days = ParseHelper.split_by_hour(squeezed_days)
  p day = split_squeezed_days[day_num.to_i]
  html = erb :hour_by_hour, layout: false, locals: {day: day}
  {html: html, day_num: day_num}.to_json
end

# get '/show' do
#   page = ParseHelper.parse_page
#   waves_range = ParseHelper.wave_heights_by_hour(page)
#   squeezed_days = ParseHelper.squeeze(waves_range)
#   split_squeezed_days = ParseHelper.split_by_hour(squeezed_days)
#   @day = split_squeezed_days[1]
#   erb :'hour_by_hour'
# end

