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
    next_day = page.css(".text-white").text[143..215]
    [today, tomorrow, next_day]
  end

  def self.squeeze(wave_ranges)
    wave_ranges.map do |day|
      day.squeeze
    end
  end


  def self.split_by_hour(squeezed_days)
    squeezed_days.map do |day|
      split_day = []
      hour = []
      day.chars.each_with_index do |char, index|
        if index % 6 != 0
          hour << char 
        else
          split_day << hour
          hour = []
        end 
      end
      split_day[1..-1]
    end
  end
end
