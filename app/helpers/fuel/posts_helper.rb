module Fuel
  module PostsHelper
    Fuel.configuration.helpers.each do |helper|
      include "::#{helper}".constantize
    end

    def markdown(text)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
          :autolink => true, :space_after_headers => true)
      raw markdown.render(text)
    end

    def method_missing method, *args, &block
      fuel.send(method, *args)
    end

    def embedded_svg filename, options={}
      file = File.read(Rails.root.join('app', 'assets', 'images', filename))
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'
      if options[:class].present?
        svg['class'] = options[:class]
      end
      doc.to_html.html_safe
    end

    def hide_published_at(post)
      @post.is_published ? '' : 'display:none;'
    end

  end
end