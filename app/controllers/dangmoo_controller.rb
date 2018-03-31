require 'line/bot'
class DangmooController < ApplicationController
  protect_from_forgery with: :null_session

def webhook
    #學說話
    room_id = room(received_text)


    # #設定回復文字
    # reply_text = keyword_reply(received_text) if reply_text.nil?

    #記錄對話
    save_to_received(channel_id,received_text)
    save_to_reply(channel_id,reply_text)
    save_dangmoo(room_id,received_text)

    # 傳送訊息
    response = reply_to_line(reply_text)
      
    # 回應 200
    head :ok
end

#擷取房號
def room_id(received_text)
    #如果開頭不是 ; 就跳出
    return nil unless received_text[0] == ';'

    #擷取房號
    roomid = received_text[1..-1]
    # semicolon_index = received_text.index(";")

    #找不到分號就跳出
    # return nil if semicolon_index.nil?

    # keyword = received_text[0..semicolon_index-1]
    # message = received_text[semicolon_index+1..-1]

    #KeywordApping.create(keyword: keyword,message: message)
    #將房號存入

    RoomId.create(roomid: roomid)
    '登入成功!請輸入彈幕'
    return roomid
end

def save_dangmoo(room_id,received_text)
    return if received_text.nil?
    if received_text[0] == ';'
        return nil
    else
        dangmoo = received_text;
    end
    Dangmoo.create(room_id,dangmoo)
end

def channel_id
    source = params['events'][0]['source']
    source['groupId'] || source['roomId'] || source['userId']
end

def save_to_received(channel_id,received_text)
    return if received_text.nil?
    Received.create(channel_id: channel_id, text: received_text)
end

def save_to_reply(channel_id, reply_text)
    return if reply_text.nil?
    Reply.create(channel_id: channel_id, text: reply_text)
end

def received_text
    message = params['events'][0]['message']
    if message.nil?
        nil
    else
        message['text']
    end
end

# def keyword_reply(received_text)
#     mapping = KeywordApping.where(keyword: received_text).last
#     if mapping.nil?
#         nil
#     else
#         mapping.message
#     end
# end

    #傳送訊息到Line
def reply_to_line(reply_text)
    return nil if reply_text.nil?
    #取得reply token
    reply_token = params['events'][0]['replyToken']

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
