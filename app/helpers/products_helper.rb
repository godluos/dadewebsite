module ProductsHelper
  def render_product_status(product)
    if product.is_hidden
      content_tag(:span, "", :class => "fa fa-arrow-down")
    else
      content_tag(:span, "", :class => "fa fa-arrow-up")
    end
  end
end
