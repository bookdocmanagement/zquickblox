module ZQuickblox
  module Dialog
    class CreateMessageRequest < Request
      def initialize(params)
        super()
        @uri    = "/chat/Message.json"
        @method = :post
        @params = params
      end
    end
  end
end
