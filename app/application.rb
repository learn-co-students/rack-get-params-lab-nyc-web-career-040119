class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    resp.write req.path.match(/items/) ?
                @@items.each { |item| resp.write "#{item}\n" }
             : req.path.match(/search/) ?
                [search_term = req.params["q"], handle_search(search_term)]
             : req.path.match(/cart/) ?
                @@cart.empty? ?
                    "Your cart is empty"
              : @@cart.each { |item| resp.write "#{item}\n" }
             : req.path.match(/add/) ?
                [item = req.params["item"], !@@cart.include?(item) ?
                  [@@cart << item, "added #{item}"]
              : item_search(item)]
             : "Path Not Found"
    resp.finish
  end

## ^^^ HONESTLY, I CAN'T BELIEVE THAT WORKS! LOL ^^^ ##

  def handle_search(search_term)
    @@items.include?(search_term) ?
      "#{search_term} is one of our items"
      : "Couldn't find #{search_term}"
  end

  def item_search(item_term)
    @@items.include?(item_term) ?
      "#{item_term} is one of our items"
      : "We don't have that item"
  end

end
