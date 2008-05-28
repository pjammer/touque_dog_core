module Admin::ProductsHelper
  def product_link()
    if @product.image == nil
      image_tag(@product.url)
    else
    return link_to image_tag(@product.image), @product.url
  end
  end
end
