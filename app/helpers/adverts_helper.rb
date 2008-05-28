module AdvertsHelper
  def ad_link
    @advert = Advert.find(:first, :order => 'RAND()')
    @part_a = link_to image_tag(@advert.image), @advert.url
    @part_b = @part_a + image_tag(@advert.imagetwo)
        if @advert.image.nil? and @advert.imagetwo.nil?
          @advert.url.to_s
        elsif @advert.imagetwo.nil?
          return @part_a
        else
          return @part_b
        end
      end
end
