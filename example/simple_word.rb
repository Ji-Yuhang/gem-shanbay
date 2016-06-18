require 'shanbay'

api = Shanbay::Api.new
data = api.search "quiet"
ap data
