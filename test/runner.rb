# encoding: utf-8

require 'simplecov'
SimpleCov.start do
  add_filter "test"
end

Dir[File.expand_path("../*_test.rb", __FILE__)].each {|test| require test}