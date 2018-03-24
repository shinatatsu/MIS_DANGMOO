class DangmooController < ApplicationController
    protect_from_forgery with: :null_session
    def eat
        # render plain: "痴痴痴"
    end

    def request_headers
        render plain: request.headers
    end

    def response_headers
        response.headers['5566'] = 'QQ'
        render plain: response.headers.to_h.map{ |key, value|
            "#{key}: #{value}"
        }.sort.join("\n")
    end

    def request_body
        render plain: request.body
    end
    
    def show_response_body
        puts "===這是設定前的response.body:#{response.body}==="
        render plain: "虎哇花哈哈哈"
        puts "===這是設定後的response.body:#{response.body}==="
    end

    def sent_request
        uri = URI('http://localhost:3000/dangmoo/response_body')
        response = Net::HTTP.get(uri)
        render plain: response
    end

    def webhook
        head :ok
    end

end
