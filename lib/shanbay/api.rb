require "uri"
require "open-uri"
require "json"

module Shanbay
  class Api
    def search(word)
      getwordui = "https://api.shanbay.com/bdc/search/?word=#{URI.escape(word)}"

      open(URI(getwordui)) do |io|
        jsonstr = io.read
        json = JSON.parse(jsonstr)
        data = json["data"]
        return parse_data data
      end
    end

    def parse_data(raw)
      data = Data.new
      data.raw = raw
      data.cn_definition = raw["cn_definition"]
      data.en_definition = raw["en_definition"]
      data.content = raw["content"]
      data.pron = raw["pron"]
      data.us_audio = raw["us_audio"]
      data.uk_audio = raw["uk_audio"]

      #data.pre_download_us_audio
      data
    end
  end
end
