=begin
  Important: This module will change in future when Hydra will get launched.
  Only thing that will change is from where we will read the data and minor tweaks around the JSON field names.
=end

module SeoPageContent
  class SeoSnapshot
    attr_accessor :title, :meta_description, :meta_keywords, :header_title, :intro, :section2, :section3, :end_para

    def initialize (source_file, geo_obj, agent_data = nil, params = {})
      binding.pry
      @source_file = source_file
      @current_geo = geo_obj
      @seo_params  = params
      @agent_data  = agent_data
      set_data
    end

    private

    def set_data
      if !@source_file.nil?
        json_source = File.read(Rails.root.join(@source_file))
        @hash_obj   = Hashie::Mash.new(JSON.parse(json_source))
        if !@hash_obj.Content.nil?
          set_page_title
          set_page_meta_description
          set_page_meta_keywords
          set_h1_tag
          set_page_intro
          set_page_section2
          set_page_section3
          set_page_end_para
        end
      end
    end

    def set_page_title
      if !@hash_obj.Content.Title.nil?
        set_meta_tags(@hash_obj.Content.Title, Defaults::SEO_PAGE_TITLE_TAG)
      end
    end

    def set_page_meta_description
      if !@hash_obj.Content.MetaDescription.nil?
        set_meta_tags(@hash_obj.Content.MetaDescription, Defaults::SEO_PAGE_META_DESCRIPTION)
      end
    end

    def set_page_meta_keywords
      if !@hash_obj.Content.MetaKeyword.nil?
        set_meta_tags(@hash_obj.Content.MetaKeyword, Defaults::SEO_PAGE_META_KEYWORDS)
      end
    end

    def set_h1_tag
      if !@hash_obj.Content.H1.nil?
        set_meta_tags(@hash_obj.Content.H1, Defaults::SEO_PAGE_HEADER_TAG)
      end
    end

    def set_page_intro
      if !@hash_obj.Content.Intro.nil?
        set_meta_tags(@hash_obj.Content.Intro, Defaults::SEO_PAGE_INTRO_TAG)
      end
    end

    def set_page_section2
      if !@hash_obj.Content.Section2.nil?
        set_meta_tags(@hash_obj.Content.Section2, Defaults::SEO_PAGE_SECTION2_TAG)
      end
    end

    def set_page_section3
      if !@hash_obj.Content.Section3.nil?
        set_meta_tags(@hash_obj.Content.Section3, Defaults::SEO_PAGE_SECTION3_TAG)
      end
    end

    def set_page_end_para
      if !@hash_obj.Content.End.nil?
        set_meta_tags(@hash_obj.Content.End, Defaults::SEO_PAGE_END_PARA_TAG)
      end
    end

    def set_meta_tags(meta_tag, tag_to_update)
      random_token = meta_tag.is_a?(Array) ? meta_tag.sample(1).first : meta_tag
      case tag_to_update
      when Defaults::SEO_PAGE_TITLE_TAG
        @title = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_META_DESCRIPTION
        @meta_description = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_META_KEYWORDS
        @meta_keywords = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_HEADER_TAG
        @header_title = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_INTRO_TAG
        @intro = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_SECTION2_TAG
        @section2 = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_SECTION3_TAG
        @section3 = subsitute_defaults(random_token)
      when Defaults::SEO_PAGE_END_PARA_TAG
        @end_para = subsitute_defaults(random_token)
      end
    end

    # This takes care of 2 variations : geo search vs name search.
    def subsitute_defaults(item)
      binding.pry
      if !@current_geo.nil?
        # first replace city-state : if present
        if @current_geo.CityState.present? && @current_geo.CityState.City.present?
          item = item.gsub('[CITY]', @current_geo.CityState.City).gsub('[STATEABRV]', @current_geo.CityState.StateID)
        end

        # Postal code is only present if its a postal search.
        if @current_geo.PostalCodeSearch && @current_geo.PostalCode.present?
          item = item.gsub('[ZIP]', @current_geo.PostalCode)
        end
      elsif @seo_params.has_key?(:name)
        item = item.gsub('[AGENTNAME]', @seo_params[:name].titleize)
      elsif !@agent_data.nil? && @agent_data.try(:agent_name).present?
        item = item.gsub('[AGENTNAME]', @agent_data.agent_name.titleize).gsub('[CITY_STATE]', @agent_data.address.to_s)
      elsif !@agent_data.nil? && @agent_data.try(:company_name).present?
        item = item.gsub('[COMPANYNAME]', @agent_data.company_name).gsub('[CITY_STATE]', @agent_data.company_address.to_s).gsub('[CITY]', @agent_data.company_address.city.to_s)
      end

      item
    end

  end
end
