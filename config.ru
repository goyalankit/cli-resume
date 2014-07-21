require 'bundler'
Bundler.require
require 'active_support/all'

$: << File.dirname(__FILE__)

ENV['RACK_ENV'] ||= 'development'

require 'resume-cli'
run ResumeCli::App

