class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
  
  if req.path.match(/cart/)
     if @@cart.empty?
       resp.write "Your cart is empty"
     else
       @@cart.each do |cart_item|
         resp.write "#{cart_item}\n"
       end
     end
   elsif req.path.match(/add/)
     item = req.params["item"]
     if @@items.include?(item)
       @@cart << item
       resp.write "added #{item}"
     else
       resp.write "We don't have that item"
     end
  else
      resp.write "Path Not Found"
    end
  end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end


  # def add_search(search_term_in_cart)
  #   if @@cart.include?(search_term_in_cart)
  #     @@cart << search_term_in_cart
  #     return "added #{search_term_in_cart} in cart"
  #   else
  #     return "We don't have that item"
  #   end
  # end
end
