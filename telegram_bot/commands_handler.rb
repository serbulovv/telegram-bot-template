class CommandsHandler
    def initialize(bot, message = nil)
        @bot =  bot
        @message = message
    end

    def start
        reply_markup = generate_main_markup
        @bot.api.send_message(chat_id: @message.chat.id, text: "Hello, #{@message.from.first_name}")
        sleep(0.5)
        introduction_message = "_This bot was created to showcase the maximum number of features that can be implemented in a Telegram bot using the_ [telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby) _gem. You will have access to a keyboard that contains all the possible functions that the bot can perform._"
        @bot.api.send_message(chat_id: @message.chat.id, text: introduction_message, parse_mode: "Markdown", reply_markup: reply_markup)
    end

    def inline_buttons
      header_message = "Inline buttons are a unique category of menu buttons that allow you to perform actions without the need to send messages in the chat. Simply by clicking on these buttons, you can execute tasks."
      url = "https://youtube.com/"
      callback_data = ["callback_data_1", "callback_data_2"]
      inline_keyboard_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(
        inline_keyboard: [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Link to the another source', url: url),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Button with callback data', callback_data: callback_data.first),
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'More menu inline buttons', callback_data: callback_data.last),
          ]
        ]
      )
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Choose an option:', reply_markup: inline_keyboard_markup)
    end

    def payments
      @bot.api.send_invoice(chat_id: @message.chat.id,
                          title: "Baseball bat",
                          description: "Swing for the fences with our high-quality baseball bats. Made from durable materials and designed for optimal performance, our bats will help you hit home runs like a pro.",
                          payload: "Test payload",
                          provider_token: "1661751239:TEST:332438085",
                          currency: "UAH",
                          prices: [Telegram::Bot::Types::LabeledPrice.new(label: "test_label", amount: 19999)],
                          photo_url: "https://m.media-amazon.com/images/I/61UuJ+YPURL._AC_SX679_.jpg",
                          photo_height: 400,
                          photo_width: 600)
    end

    def more_buttons
      reply_markup = generate_secondary_markup
      more_buttons_message = "More buttons"
      @bot.api.send_message(chat_id: @message.chat.id, text: more_buttons_message, reply_markup: reply_markup)
    end

    def inline_actions
      inline_keyboard_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(
        inline_keyboard: [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Inline action', switch_inline_query_current_chat: ""),
          ]
        ]
      )
      @bot.api.send_message(chat_id: @message.chat.id, text: "Choose the company", reply_markup: inline_keyboard_markup)
    end

    def text_formatting_options
      formated_text = '*You can format text using plain HTML or Markdown*
      _am libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus_
      [inline URL](http://www.example.com/)
      [inline mention of a user](tg://user?id=123456789)
      `inline fixed-width code`
      ```
      puts "Some code here"
      ```
      Or you can specify programming language
      ```ruby
      class MainFrame
          def initialize
              @a = a
          end
      end
      ```'
      @bot.api.send_message(chat_id: @message.chat.id, text: formated_text, parse_mode: "Markdown")
    end

    def back
      reply_markup = generate_main_markup
      @bot.api.send_message(chat_id: @message.chat.id, text: "Back to main menu", reply_markup: reply_markup)
    end

    def additional_info
      formated_text = "*This bot was developed by* [SocialVlad](https://t.me/SocialVlad).\n\n1. _When you use inline keyboards, dont forget to use the_ [answerCallbackQuery](https://core.telegram.org/bots/api#answercallbackquery) _method. In the event that you do not use this, telegram will send you messages that you do not give users an answer to their inline messages.\n 2.In order not to write a command to the chat every time, you can create an auxiliary menu so that commands are highlighted for you when you start typing. To do this, go to @BotFather and set up the Menu item there._"
      @bot.api.send_message(chat_id: @message.chat.id, text: formated_text, parse_mode: "Markdown")
    end

    private 

    def generate_main_markup
        keyboard_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
          keyboard: [
            [{ text: 'Inline buttons' }],
            [{ text: 'Payments' }, { text: 'Telegram passport' }],
            [{ text: 'Inline actions' },{ text: 'More buttons' }],
            [{ text: 'Adittional info' }]
          ],
          one_time_keyboard: true,
          resize_keyboard: true
        )
    end

    def generate_secondary_markup
      keyboard_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: [
          [{ text: "Request location", request_location: true }, { text: "Text formatting options" }],
          [{ text: "Back"}]
        ],
        one_time_keyboard: true,
        resize_keyboard: true
      )
    end
end
