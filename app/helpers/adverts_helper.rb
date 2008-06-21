module AdvertsHelper
  def ad_link
  @advert = Advert.find(:first, :order => 'RAND()')
  @advert.increment!("ad_count")
  @part_a = link_to image_tag(@advert.image), @advert.url
  @part_b = @part_a + image_tag(@advert.imagetwo)
    if @advert.image.blank? and @advert.imagetwo.blank?
      @advert.url.to_s
    elsif @advert.imagetwo.blank?
      return @part_a
    else
      return @part_b
    end
  end
end
