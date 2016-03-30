module AthleteDashboard
  class LogClimbPanel
    include Capybara::DSL

    def initialize
      @log_a_climb_section = find 'article.log-a-climb'
    end

    def click
      @log_a_climb_section.first('.start').click
    end

    def try_to_click
      @log_a_climb_section.first('.start', visible: true).try(:click)
    end

    def choose_most_recent_gym
      recent_gyms_section.first('.gym-link').click
    end

    def choose_first_climb

      climb_links_element.first('.loggable-link').click
    end

    def trigger_geolocation
      try_to_click
      click_on 'find-me'
    end

    def has_current_location_of_user?
      @log_a_climb_section.has_button? 'refresh-my-location'
    end

    private

    def climb_links_element
      find '.climb-links'
    end

    def nearby_gyms_section
      @log_a_climb_section.find('section.nearby-gyms')
    end

    def recent_gyms_section
      @log_a_climb_section.find('section.recent-gyms')
    end
  end
end
