require "test_helper"

class ProductTest < ActiveSupport::TestCase

  def setup
    @product = Product.new(name: "Nike", description: "Test description" )
  end

  test "Should not save without name" do
    product = Product.new
    assert_not product.save, "Saved the product without name"
  end

  test "Should be valid" do 
    assert @product.valid?, "Check if the product information is valid"
  end
end
