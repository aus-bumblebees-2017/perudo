require 'nokogiri'
require 'open-uri'
 
module ParseHelper

  def self.parse_page 
    page = Nokogiri::HTML(open("http://magicseaweed.com/Holyoke-Surf-Report/389/")) 
  end

  def self.today_wave_height(page)
    page.css(".rating-text").text
  end

  def self.today_sea_temp(page)
    page.css("p.nomargin-bottom strong").text[2..3]
  end

  def self.wave_heights_by_hour(page)
    today = page.css(".text-white").text[0..71]
    tomorrow = page.css(".text-white").text[72..143]
    next_day = page.css(".text-white").text[142..215]
    [today, tomorrow, next_day]
  end

  def self.squeeze(wave_ranges)
    wave_ranges.map do |day|
      day.squeeze
    end
  end


  def self.split_by_hour(squeezed_days)
    squeezed_days.map do |day|
      day.split("ft")
    end
  end

  def self.print_pretty(day)
    day.map do |hour|
      p hour
      if hour.length < 3 || hour.length > 6
        if hour.length == 1
          "#{hour[0]} ft"
        elsif hour[1] == "F"
          "Flat"
        elsif hour[1] == "0"
          "Flat"
        else
          "#{hour[1]} ft"
        end
      else 
        "#{hour[1]}-#{hour[3]} ft"
      end
    end
  end
end
