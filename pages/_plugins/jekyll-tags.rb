module Jekyll
  module Tags
    class RemoveEmptyLines < Liquid::Block

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        super.strip.gsub /^[\t\s]*$\n/, ''
      end

    end


    class CardBlock < Liquid::Block
      def initialize(tag_name, params, tokens)
        super
        @params = params.strip

        @attributes = {}
        params.scan(/(\w+)\s*=\s*((?-mix:(?-mix:"[^"]*"|'[^']*')|(?:[^\s,|'"]|(?-mix:"[^"]*"|'[^']*'))+))/) do |key, value|
          @attributes[key] = value.gsub(/^'|"/, '').gsub(/'|"$/, '')
        end
      end

      def render(context)
        card_text = '<div class="card">' + "\n"

        if @attributes['title']
          card_text += '<div class="card-header">' + "\n"
          card_text += '<div class="card-title">' + @attributes['title'] + '</div>' + "\n"
          card_text += '</div>' + "\n"
        end

        card_text += '<div class="card-body">' + "\n"
        card_text += super + "\n"
        card_text += '</div>' + "\n"
        card_text += '</div>'
      end
    end
  end
end

Liquid::Template.register_tag('removeemptylines', Jekyll::Tags::RemoveEmptyLines)
Liquid::Template.register_tag('card', Jekyll::Tags::CardBlock)