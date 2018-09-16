require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

	def setup
		@category = Category.new(name: "sport")
	end

	test "category should be valid" do #check model is present or not
		assert @category.valid?
	end

	test "category name should be present" do
		@category.name = " "
		assert_not @category.valid?
	end

	test "category name should be uniqe" do
		@category.save
		@category1 = Category.new(name: "sport")
		assert_not @category1.valid?
	end

	test "category name length should minimum 3 char" do
		@category.name = "aa"
		assert_not @category.valid?
	end

	test "category name length should maximum 25 char" do
		@category.name = "a" * 26
		assert_not @category.valid?
	end
end