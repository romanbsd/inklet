module InkHelper
  class ColumnsCapturer
    delegate :capture, :content_tag, :to => :@ctx

    def initialize(ctx, &block)
      @ctx = ctx
      @block = block
      @classes = ['columns']
    end

    def html_safe?
      true
    end

    def to_s
      content = capture(&@block)
      content = content_tag(:td, content) unless content =~ /\A\s*<td/i
      tr = content + content_tag(:td, nil, class: 'expander')
      classes = @last ? 'wrapper last' : 'wrapper'
      content_tag(:td, content_tag(:table, content_tag(:tr, tr), class: @classes.join(' ')), class: classes)
    end

    def method_missing(method, *args, &block)
      if method == :last
        @last = true
      else
        @classes.push method.to_s
      end
      @block ||= block
      self
    end
  end

  def container(options = {}, &block)
    name = options.delete(:name) || 'container'
    content_tag(:table, content_tag(:tr, content_tag(:td, options, &block)), class: name)
  end

  def row(options = {}, &block)
    classes = (options[:class].to_s.split(/\s+/) << 'row').compact.join(' ')
    content_tag(:table, content_tag(:tr, &block), class: classes)
  end

  def columns(&block)
    ColumnsCapturer.new(self, &block)
  end
end
