#require_relative 'jqgrid-rails3'
#require '2dc_jqgrid'
#require 'jqgrid-rails3'
#$: << File.join(Rails.root, 'lib')

$:.unshift(File.join(File.expand_path('./')) + '/lib/jqgrid-rails3')

require '2dc_jqgrid'

Array.send :include, JqgridJson
ActionView::Base.send :include, Jqgrid
ActionController::Base.send :include,JqgridFilter
