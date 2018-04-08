require 'line/bot'
class DangmooController < ApplicationController
  protect_from_forgery with: :null_session
  $roomid_p         #全域變數儲存房號

def webhook
    # room_id = room(received_text)
    reply_text = room(received_text)

    #記錄對話
    save_to_received(channel_id,received_text)
    save_to_reply(channel_id,reply_text)

    #儲存彈幕和房號
    save_dangmoo(received_text)

    # 傳送訊息
    response = reply_to_line(reply_text)
      
    # 回應 200
    head :ok
end


def room(received_text)
    #如果開頭不是 ; 就跳出
    return nil unless received_text[0] == ';'

    #擷取房號
    roomid = received_text[1..-1]

    RoomId.create(roomid: roomid)
    '登入成功!請輸入彈幕'
    return roomid
end

#將房號與收到的訊息帶入並存入
def save_dangmoo(received_text)
    return if received_text.nil?

    #如果開頭為";" 則跳出
    if received_text[0] == ';'
        roomid = received_text[1..-1]
        $roomid_p = roomid

        reply_token = params['events'][0]['replyToken']
    # 設定回覆訊息
        message = {
            type: 'text',
            text: '請開始輸入彈幕'
        }
    #傳送訊息
        line.reply_message(reply_token,message)
    else
        dangmoo = received_text;
    end
    Dangmoo.create(roomid: $roomid_p,dangmoo: dangmoo)
end

def channel_id
    source = params['events'][0]['source']
    source['groupId'] || source['roomId'] || source['userId']
end

# def save_to_received(channel_id,received_text)
#     return if received_text.nil?
#     Received.create(channel_id: channel_id, text: received_text)
# end

# def save_to_reply(channel_id, reply_text)
#     return if reply_text.nil?
#     Reply.create(channel_id: channel_id, text: reply_text)
end

def received_text
    message = params['events'][0]['message']
    if message.nil?
        nil
    else
        message['text']
    end
end

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
    #line.reply_message(reply_token,message)
end

    # Line Bot API 物件初始化
def line
        @line ||= Line::Bot::Client.new { |config|
        config.channel_secret = 'e55f897882eea3d7a0a3874600e1eeed'
        config.channel_token = '2nuY4aNLo3XuxA7vQZyLaYnGg77cI5wRJj4IQq1KeB6jIbVGsEbDGDKxkQDjTpdgj524NnFhl4m0aAa3y3gjtE9UcYSceuLs7PYhV8OKLr6Mla+civUW1VGnPtuxxtAnTt/BiFXb/1KqWNQF8+zLDgdB04t89/1O/w1cDnyilFU='
    }
end
end
