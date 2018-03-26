require 'line/bot'
class DangmooController < ApplicationController
  protect_from_forgery with: :null_session

def webhook
    #設定回復文字
    reply_text = keyword_reply(received_text)

    # 傳送訊息
    response = reply_to_line(reply_text)
      
    # 回應 200
    head :ok
end

def received_text
    message = params['events'][0]['message']    
    message['text'] unless message.nil?
end

def keyword_reply(received_text)
    keyword_mapping = {
        '裸足' => 'Summer'
        '君名' => '希望'
    }

    #查表
    keyword_mapping[received_text]
end

    #傳送訊息到Line
def reply_to_line(reply_text)
    return nil if reply_text.nil?
    #取得reply token
    reply_token = params['event'][0]['replyToken']

    # 設定回覆訊息
    message = {
        type: 'text',
        text: reply_text
    }

    #傳送訊息
        line.reply_message(reply_token,message)
    end

    # Line Bot API 物件初始化
    def line
        @line ||= Line::Bot::Client.new { |config|
        config.channel_secret = 'e55f897882eea3d7a0a3874600e1eeed'
        config.channel_token = '2nuY4aNLo3XuxA7vQZyLaYnGg77cI5wRJj4IQq1KeB6jIbVGsEbDGDKxkQDjTpdgj524NnFhl4m0aAa3y3gjtE9UcYSceuLs7PYhV8OKLr6Mla+civUW1VGnPtuxxtAnTt/BiFXb/1KqWNQF8+zLDgdB04t89/1O/w1cDnyilFU='
    }
    end

    def eat
        render plain: "痴痴痴"
    end

    def request_headers
        render plain: request.headers.to_h.reject{ |key, value|
            key.include? '.'
        }.map{ |key, value|
            "#{key}: #{value}"
        }.sort.join("\n")
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
        uri = URI('http://localhost:3000/dangmoo/eat')
        http = Net::HTTP.new(uri.host, uri.port)
        http_request = Net::HTTP::Get.new(uri)
        http_response = http.request(http_request)

        render plain: JSON.pretty_generate({
            request_class: request.class,
            response_class: response.class,
            http_request_class: http_request.class,
            http_response_class: http_response.class
        })
    end
end
