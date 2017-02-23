module SeoPageContent
  class BallbyballPageSeoData
    attr_accessor :content

    def initialize (match_data)
      binding.pry
      @match_data = match_data
      set_ballbyball_seo_tags
    end

    private

    def set_ballbyball_seo_tags
      binding.pry
      @content = SeoPageContent::SeoSnapshot.new(source, nil, @match_data , {})
    end

    def source
      "lib/seo_configuration/ballbyball/#{Defaults::BALLBYBALL_SEO_JSON}"
    end

  end

end
