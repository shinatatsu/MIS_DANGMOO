class DangmooController < ApplicationController
    def eat
        render plain: "痴痴痴"
    end

    def request_headers
        render plain: request.headers.to_h.map{ |key, value|
            key+":"+value.class.to_s}.sort.join("\n")
    end

    def response_headers
        response.headers['5566'] = 'QQ'
        render plain: response.headers.to_h.map{ |key, value|
            "#{key}: #{value}"}.sort.join("\n")
    end

    def request_body
        render plain: request.body
    end

    def show_response_body
        puts "===設定前:#{response.body}==="
        render plain:　"HIHIHIHIHI"
        puts "==設定後:#{response.body}==="
    end
end
