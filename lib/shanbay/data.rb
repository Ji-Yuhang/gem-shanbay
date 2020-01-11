#{
#"msg": "SUCCESS",
#"status_code": 0,
#"data": {
#"pronunciations": {
#"uk": "'saɪləns",
#"us": "'saɪləns"
#},
#"en_definitions": {
#"v": [
#"cause to be quiet or not talk",
#"keep from expression, for example by threats or pressure"
#],
#"n": [
#"the state of being silent (as when no one is speaking)",
#"the absence of sound",
#"a refusal to speak when expected"
#]
#},
#"content_id": 5499,
#"audio_addresses": {
#"uk": [
#"https://words-audio.oss.aliyuncs.com/uk%2Fs%2Fsi%2Fsilence.mp3",
#"http://words-audio.cdn.shanbay.com/uk/s/si/silence.mp3"
#],
#"us": [
#"https://words-audio.oss.aliyuncs.com/us%2Fs%2Fsi%2Fsilence.mp3",
#"http://words-audio.cdn.shanbay.com/us/s/si/silence.mp3"
#]
#},
#"en_definition": {
#"pos": "v",
#"defn": "cause to be quiet or not talk; keep from expression, for example by threats or pressure"
#},
#"uk_audio": "http://media.shanbay.com/audio/uk/silence.mp3",
#"has_audio": true,
#"conent_id": 5499,
#"pronunciation": "'saɪləns",
#"audio_name": "silence",
#"content": "silence",
#"pron": "'saɪləns",
#"num_sense": 1,
#"object_id": 5499,
#"content_type": "vocabulary",
#"definition": " n. 沉默,寂静\nv. 使沉默,使安静\nvt. 使安静,使沉默",
#"sense_id": 0,
#"audio": "http://media.shanbay.com/audio/us/silence.mp3",
#"id": 5499,
#"cn_definition": {
#"pos": "",
#"defn": "n. 沉默,寂静\nv. 使沉默,使安静\nvt. 使安静,使沉默"
#},
#"us_audio": "http://media.shanbay.com/audio/us/silence.mp3"
#}
#}
require "tempfile"
require "em-http-request"
require "time"

module Shanbay
  class Data
    attr_accessor :pronunciations #{uk: "saɪləns", us: "saɪləns"}
    attr_accessor :uk_pronunciation
    attr_accessor :us_pronunciation
    attr_accessor :en_definitions #{"v": ["cause to be quiet or not talk", "keep from expression, for example by threats or pressure"], "n": ["the state of being silent (as when no one is speaking)", "the absence of sound", "a refusal to speak when expected"]}
    attr_accessor :audio_address
    attr_accessor :en_definition
    attr_accessor :uk_audio
    attr_accessor :has_audio
    attr_accessor :pronunciation
    attr_accessor :audio_name
    attr_accessor :content
    attr_accessor :pron
    attr_accessor :num_sense
    attr_accessor :definition
    attr_accessor :sense_id
    attr_accessor :audio
    attr_accessor :cn_definition
    attr_accessor :us_audio

    attr_accessor :local_us_audio
    attr_accessor :raw

    def initialize
    end

    def content=(word)
      @content = word
      @local_us_audio = ::Tempfile.new([content.to_s, ".mp3"])
    end

    def pre_download_us_audio
      return if local_us_audio.size > 0
      ::EM.run do
        url = us_audio

        http = ::EM::HttpRequest.new(url).get
        http.callback {
          local_us_audio.write(http.response)
          local_us_audio.rewind
          ::EM.stop
        }
        http.errback {
          ::EM.stop
        }
      end
    end

    def which(cmd)
      exts = ENV["PATHEXT"] ? ENV["PATHEXT"].split(";") : [""]
      ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable?(exe) && !File.directory?(exe)
        }
      end
      return nil
    end

    def play_us_audio
      # if local_us_audio.size > 0
      #   # if ENV["_system_name"] == "OSX"
      #   if which("afplay")
      #     fork { exec "afplay", local_us_audio.path }
      #   elsif which("ffplay")
      #     # fork { exec "ffplay", " -nodisp", " -autoexit ", local_us_audio.path, " >/dev/null 2>&1" }
      #     fork {
      #       system("ffplay -nodisp -autoexit #{local_us_audio.path} >/dev/null 2>&1 ")
      #     }
      #   end
      # end
      if us_audio
        if which("afplay")
          fork { exec "afplay", us_audio }
        elsif which("ffplay")
          # fork { exec "ffplay", " -nodisp", " -autoexit ", us_audio, " >/dev/null 2>&1" }
          fork {
            system("ffplay -nodisp -autoexit #{us_audio} >/dev/null 2>&1 ")
          }
        end

        pre_download_us_audio
      end
    end

    def to_hash
      @raw
    end

    def to_json
      @raw.to_json
    end
  end
end
