$: << File.expand_path("../lib", File.dirname(__FILE__))
require "bundler/setup"

require "infer"

require "test/unit"
require "wrong"
require "shoulda-context"

Wrong.config.color

class Test::Unit::TestCase
  include Wrong
end
