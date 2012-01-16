require "spec_helper"

describe 'Parsing Set-Cookie' do

  describe 'basic parsing' do

    def parse(set_cookie)
      CookieMonster.parse(set_cookie)
    end

    it "extracts cookie name" do
      cookie = parse('foo=bar')
      cookie.name.must_equal 'foo'

      cookie = parse('baz=quux')
      cookie.name.must_equal 'baz'
    end

    it "extracts cookie value" do
      cookie = parse('foo=bar')
      cookie.value.must_equal 'bar'

      cookie = parse('baz=quux')
      cookie.value.must_equal 'quux'
    end

    it "extracts path" do
      cookie = parse('foo=bar; path=/')
      cookie.path.must_equal '/'

      cookie = parse('foo=bar; Path=/foo')
      cookie.path.must_equal '/foo'
    end

    it "extracts expiry time" do
      cookie = parse('foo=bar; expires=Thu, 19-Dec-2013 17:24:17 GMT')
      cookie.expires.must_equal Time.utc(2013, 12, 19, 17, 24, 17)
    end

    it "should be expired when expires in past" do
      yesterday = (Date.today - 1).httpdate
      cookie = parse("foo=bar; expires=#{yesterday}")
      assert cookie.expired?
    end

    it "should not be expired when expires in future" do
      tomorrow = (Date.today + 1).httpdate
      cookie = parse("foo=bar; expires=#{tomorrow}")
      assert ! cookie.expired?
    end

    it "should not be expired when expires not set" do
      cookie = parse('foo=bar')
      assert ! cookie.expired?
    end

    it "sets httponly" do
      cookie = parse('foo=bar; httponly')
      assert cookie.http_only?
    end

    it "sets secure" do
      cookie = parse('foo=bar; secure')
      assert cookie.secure?
    end

    it "sets domain" do
      cookie = parse('foo=bar; domain=foo.com')
      cookie.domain.must_equal 'foo.com'
    end

    it "creates a session cookie when no expires is set" do
      cookie = parse('foo=bar')
      assert cookie.session?
    end

    it "creates a session cookie when expires parsing fails" do
      cookie = parse('foo=bar; expires=Not a date format GMT')
      assert cookie.session?
    end

  end
  
  describe 'multiple cookies' do
    
  end

end
