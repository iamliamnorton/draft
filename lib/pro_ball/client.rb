require 'net/http'
require 'json'

module ProBall
  class Client
    HOST = 'https://probasketballapi.com'
    KEY = "hObUVEQ98yxR1wTAaDPXdJ7utelkq0cZ"

    def self.scrape_teams(opts = {})
      uri = URI.parse("#{HOST}/teams")

      response = Net::HTTP.post_form(uri, opts.merge("api_key" => KEY))
      JSON.parse(response.body)
    end

    def self.scrape_players(opts = {})
      uri = URI.parse("#{HOST}/players")

      response = Net::HTTP.post_form(uri, opts.merge("api_key" => KEY))
      JSON.parse(response.body)
    end

    def self.scrape_games(opts = {})
      uri = URI.parse("#{HOST}/games")

      response = Net::HTTP.post_form(uri, opts.merge("api_key" => KEY))
      JSON.parse(response.body)
    end

    def self.scrape_stats(opts = {})
      uri = URI.parse("#{HOST}/stats/players")

      response = Net::HTTP.post_form(uri, opts.merge("api_key" => KEY))
      JSON.parse(response.body)
    end
  end
end
