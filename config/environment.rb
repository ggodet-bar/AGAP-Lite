# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
AgapLiteApp::Application.initialize!

Haml::Template.options[:escape_html] = false
