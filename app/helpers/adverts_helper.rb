module AdvertsHelper
  # change RANDOM to RAND if using mysql.
  def ad_link
    @advert = Advert.find(:first, :order => 'RANDOM()')
    unless @advert.blank?
      @advert.increment!("ad_count")

      @part_a = link_to image_tag(@advert.image), @advert.url
      @part_b = @part_a + image_tag(@advert.imagetwo)

      if @advert.image.blank? and @advert.imagetwo.blank?
        @advert.url.to_s
      elsif @advert.imagetwo.blank?
        return @part_a ||= Advert.new
      else
        return @part_b ||= Advert.new
      end
    end
  end
end
