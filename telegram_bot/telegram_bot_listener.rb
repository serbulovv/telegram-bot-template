require 'pry'
require 'telegram/bot'
require 'dotenv/load'
require_relative 'commands_handler'
require_relative 'callback_handler'

bot = Telegram::Bot::Client.new(ENV['TELEGRAM_API_KEY'])

bot.run do
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::InlineQuery
      CallbackHandler.new(bot, message).handle_inline_query
    when Telegram::Bot::Types::CallbackQuery
      CallbackHandler.new(bot, message).handle_callback(message.data)
    when Telegram::Bot::Types::Message
      case message.text.downcase
      when '/start', 'start'
        CommandsHandler.new(bot, message).start
      when '/inline_buttons', 'inline buttons'
        CommandsHandler.new(bot, message).inline_buttons
      when '/payments', 'payments'
        CommandsHandler.new(bot, message).payments
      when '/more_buttons', 'more buttons'
        CommandsHandler.new(bot, message).more_buttons
      when '/request_location', 'request location'
        # CommandsHandler.new(bot, message).request_location
      when '/inline_actions', 'inline actions'
        CommandsHandler.new(bot, message).inline_actions
      when '/inline_actions', 'inline actions'
        CommandsHandler.new(bot, message).inline_actions
      when '/text_formatting_options', 'text formatting options'
        CommandsHandler.new(bot, message).text_formatting_options
      when '/back', 'back'
        CommandsHandler.new(bot, message).back
      when '/additional_info', 'additional info'
        CommandsHandler.new(bot, message).additional_info
      end
    end
  end
end
