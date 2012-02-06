require 'test/unit'
require './appstore'
require './app'

class TestAppstore < Test::Unit::TestCase
  def test_find_by_existing_app_name
    app = Appstore.find(:term => "whatsapp")
    assert_equal App, app.class
    assert_equal "software", app.kind
    assert app.description.include?("WhatsApp Messenger is a cross-platform s")
  end

  def test_find_a_non_existing_app_returns_nil
    app = Appstore.find(:term => "qwertyuiopzxcv")
    assert_nil app
  end
end

class TestApp < Test::Unit::TestCase
  def test_new_from_json_should_have_acessor_on_known_attrs
    app = App.new_from_json({"term" => "facebook", "description" => "hello"})
    assert_equal "facebook", app.term
    assert_equal "hello", app.description
  end

  def test_new_from_json_with_nil_param
    assert_nil App.new_from_json()
    assert_nil App.new_from_json({})
  end
end