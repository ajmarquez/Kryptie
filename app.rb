require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './main/kryptic'


class Post < ActiveRecord::Base
end
