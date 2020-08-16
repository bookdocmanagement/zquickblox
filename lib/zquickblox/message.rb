require_relative "message/create_message_request"

module ZQuickblox
  module Message
    class << self

      def create(login, password, params)
        message = Message.new(params)
        params = message.build_params
        request = ZQuickblox::Message::CreateMessageRequest.new(params)
        run_request(login, password, request)
        message = Message.new(ZQuickblox::Util.symbolize_keys(request.response_body))
        return message
      end

      def run_request(login, password, request)
        session = ZQuickblox::Session.create(login, password)
        request.header("QB-Token", session.token)
        request.execute
      end
    end

    class Message
      attr_accessor :id, :chat_dialog_id, :message,
                    :send_to_chat, :markable

      def initialize(params)
        @id                       = params[:_id]
        @chat_dialog_id           = params[:chat_dialog_id]
        @message                  = params[:message]
        @send_to_chat             = params[:send_to_chat]
        @markable                 = params[:markable]
      end

      def build_params
        {
            "chat_dialog_id":     @chat_dialog_id,
            "message":            @message,
            "send_to_chat":       @send_to_chat,
            "markable":           @markable
        }
      end
    end
  end
end
