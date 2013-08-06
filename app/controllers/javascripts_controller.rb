class JavascriptsController < ApplicationController

def dynamic_fixtures
  @fixtures = Fixture.find(:all)
end

end
