class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  helper :all
  
  require 'rubygems'
  require 'google_chart'
  
end
