class Weather
  @@jp_places = %w(東京 岩手 渋谷 三鷹 盛岡)
  @@en_places = %w(Tokyo Iwate Shibuya-ku Mitaka-shi Morioka-shi)
  class << self
    def present?(text)
      for pattern in @@jp_places
        return true if text.match(/#{pattern}/)
      end
      false
    end
  end

  attr_reader :place

  def initialize(text)
    @place = set_place(text) if Weather.present?(text)
  end

  def jp_place
    index = @@en_places.index(@place)
    @@jp_places[index]
  end

  private
  def set_place(text)
    @@en_places[get_place_num(text)]
  end

  def get_place_num(text)
    @@jp_places.each_with_index do |pattern, i|
      return i if text.match(/#{pattern}/)
    end
  end
end
