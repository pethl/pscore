module ApplicationHelper

    def last_fixture_updated
      @current = Game.where(:current => true)
      @fixtures = Fixture.where('fixresultgap IS NOT NULL').sort_by { |h| h[:updated_at] }.reverse
      return @fixtures.first
      
    end
end
