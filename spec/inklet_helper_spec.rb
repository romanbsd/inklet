require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string/output_safety'
require 'ink_helper'
require 'action_view'
require 'slim'

Slim::Engine.set_default_options pretty: true, use_html_safe: true

describe InkHelper do
  let(:html) { File.read(File.expand_path('../fixtures/template1.html', __FILE__)).
    gsub(/^\s+/,'').gsub(/\n/, '') }

  let(:scope) do
    Object.new.tap do |scope|
      scope.extend ActionView::Context
      scope.extend ActionView::Helpers::TagHelper
      scope.extend InkHelper
    end
  end

  context 'Slim' do
    subject { File.expand_path('../fixtures/template1.html.slim', __FILE__) }

    it 'renders proper HTML from slim' do
      result = Slim::Template.new(subject).render(scope)
      result.should eq(html)
    end
  end

  context 'ERB' do
    subject { File.expand_path('../fixtures/template1.html.erb', __FILE__) }
    RailsERB = ActionView::Template::Handlers::Erubis

    it 'renders proper HTML from erb' do
      result = RailsERB.new(File.read(subject)).evaluate(scope).gsub(/^\s+/,'').gsub(/\n/, '').gsub(/\s{2,}/,'')
      result.should eq(html)
    end
  end

end
