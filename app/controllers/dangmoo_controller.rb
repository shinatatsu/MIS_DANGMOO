require 'line/bot'
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
        #設定回復文字
        reply_text = keyword_reply(received_text)

        # 傳送訊息
        response = reply_to_line(reply_text)

        # 取得 reply token
            reply_token = params['events'][0]['replyToken']
                p "=====reply_token"
                p reply_token
                p "====="
          
        # 回應 200
            head :ok
    end
    
    def received_text
        params['event'][0]['message']['text']
        if message.nil?
            nil
        else
            message['text']
        end
    end
    
    def keyword_reply(received_text)
        keyword_mapping = {
            '裸足' => 'Summer'
            '君名' => '希望'
        }

        #查表
        keyword_mapping[received_text]
    end

        # Line Bot API 物件初始化
    def line
        @line ||= Line::Bot::Client.new { |config|
        config.channel_secret = 'e55f897882eea3d7a0a3874600e1eeed'
        config.channel_token = '2nuY4aNLo3XuxA7vQZyLaYnGg77cI5wRJj4IQq1KeB6jIbVGsEbDGDKxkQDjTpdgj524NnFhl4m0aAa3y3gjtE9UcYSceuLs7PYhV8OKLr6Mla+civUW1VGnPtuxxtAnTt/BiFXb/1KqWNQF8+zLDgdB04t89/1O/w1cDnyilFU='
      }
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

end
