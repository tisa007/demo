
class Product
  include DataMapper::Resource

  property :id, Serial
  property :url, String
  property :title, String
  property :name, String
  property :price, String
  property :image_mid, String
  property :image_small, String
  property :shop, String
  property :create_at, String

  def self.parse(url)
    ret = new(Parser.parse(url))
    puts ret.inspect
    ret
  end
end
