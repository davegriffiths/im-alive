require 'rest_client'
require 'json'

module ImAlive
  class Log
    def initialize(task: task, app: app, url: url)
      @task = task
      @app = app
      @url = url
    end

    def send
      RestClient.put(url, payload.to_json)
    rescue RestClient::Exception
    end

    private

    attr_reader :task, :app, :url

    def rev
      payload = RestClient.get(url)
      JSON.parse(payload)['_rev']
    end

    def payload
      {
        "_rev" => rev,
        "app"=> app,
        "timestamp"=> Time.now.to_s,
        "js_timestamp" => Time.now.to_i,
        "task" => task
      }
    end
  end
end
