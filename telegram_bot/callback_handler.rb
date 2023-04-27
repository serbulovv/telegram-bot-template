
class CallbackHandler
    def initialize(bot, message)
        @bot = bot
        @message = message
    end

    def handle_callback(callback_data)
        return false if callback_data.nil?

        case callback_data
        when "callback_data_1"
            callback_data_1
        when "callback_data_2"
            callback_data_2
        end
    end

    def handle_inline_query
      results = []
      companies = ["Apple Inc", "Microsoft Corporation", "Amazon.com, Inc", "Alphabet Inc. (Google)", "Facebook, Inc"]
      companies.each_with_index do |company, index|
        result = Telegram::Bot::Types::InlineQueryResultArticle.new(
          id: (index + 1).to_s,
          title: company,
          input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: company)
        )
        results << result
      end
  
      @bot.api.answer_inline_query(
        inline_query_id: @message.id,
        results: results,
        cache_time: 1,
        is_personal: true
      )
    end

    private

    def callback_data_1
        @bot.api.send_message(chat_id: @message.from.id, text: "Callback data is : #{@message.data}") 
    end

    def callback_data_2
        message_header = "You can display your inline buttons as a menu.\n\n1.Cat\n2.Dog\n3.Lion\n4.Fish"
        inline_keyboard_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(
            inline_keyboard: [
              [
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '⬆️', callback_data: "up"),
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '⬇️', callback_data: "down"),
              ],
              [
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '⬅️', callback_data: "left"),
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '➕', callback_data: "plus"),
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '➖', callback_data: "minus"),
                Telegram::Bot::Types::InlineKeyboardButton.new(text: '➡️', callback_data: "right")
              ]
            ]
          )
        @bot.api.send_message(chat_id: @message.from.id, text: message_header, reply_markup: inline_keyboard_markup) 
    end
end