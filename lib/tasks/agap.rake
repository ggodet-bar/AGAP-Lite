require 'rake/packagetask'

namespace :agap do
  
  desc "Create some basic formalisms (GAMMA, P-SIGMA)"
  task :create_formalisms => :environment do
    gamma = {
      :name => "Gamma formalism",
      :author => "Erich Gamma, Richard Helm, Ralph Johnson & John Vlissides",
      :version => "1.0.0"  
    }
    gamma_pattern_formalism = {
      :name => "Software architecture pattern",
    }
    gamma_field_descriptors = [ 
      {
        :name => "Also known as",
        :section => "interface",
        :field_type => "string",
        :description => "Synonyms for the pattern name"
      },
      {
        :name => "Motivation",
        :section => "interface",
        :field_type => "text",
        :description => "Presents an example that highlights the requirements for the pattern"
      },
      {
        :name => "Applicability",
        :section => "interface",
        :field_type => "text",
        :description => "Describes the situtations for which the pattern would be relevant"
      },
      {
        :name => "Structure",
        :section => "solution",
        :field_type => "modelset",  # A set of commented models
        :description => "Describes formal software architecture solutions"
      },
      {
        :name => "Participants",
        :section => "solution",
        :field_type => "text",
        :description => "A textual solution that describes the entities of the formal solution"
      },
      {
        :name => "Collaborations",
        :section => "solution",
        :field_type => "text",
        :description => "A textual solution that describes the interactions between the entities of the formal solution"
      },
      {
        :name => "Consequence",
        :section => "solution",
        :field_type => "text",
        :description => "Presents the consequences related to the application of the pattern"
      },
      {
        :name => "Implementation",
        :section => "solution",
        :field_type => "text",
        :description => "Presents pragmatic, software-related elements related to the implementation of the solution's software architecture"
      },
      {
        :name => "Sample code",
        :section => "solution",
        :field_type => "text",
        :description => "Presents some code samples that illustrate the implementation of the pattern"
      },
      {
        :name => "Known uses",
        :section => "solution",
        :field_type => "text",
        :description => "Describes some actual uses of the pattern, taken from existing applications"
      },
      {
        :name => "Related patterns",
        :section => "solution",
        :field_type => "text",
        :description => "Enumerates some patterns from the system that are somehow related to the current pattern"
      }
    ]
    system = SystemFormalism.create(gamma)
    system.pattern_formalisms.create(gamma_pattern_formalism)
    pattern_formalism = system.pattern_formalisms.first
    pattern_formalism.field_descriptors.build(gamma_field_descriptors)

    if pattern_formalism.save
      print "Gamma formalism was successfully created"
    else
      print "Could not load the formalism. Check the logs for errors."
    end
  end

  desc  "Deploy the pattern system to remote site"
  task  :deploy  => [:backup] do
    contents = IO.read(File.dirname(__FILE__) + '/../crawler.rb')
    eval(contents)
  end
  
  desc "Backup the database"
  task  :backup do
    # Backup of the pattern system(s)
    system("sqlite3 #{File.dirname(__FILE__)}/../../db/RadAGAP_development.sqlite3 .dump > #{File.dirname(__FILE__)}/../../db/symphony_patterns_bak.sql")
    print "DB should have been backed up\n"
  end
  
  desc "Backup the system"
  task  :backup_system => [:backup, :package] do
  end
  
  Rake::PackageTask.new("backup_#{Time.now.strftime('%y%m%d_%H%M')}", :noversion) do |pack|
    pack.need_zip = true
    pack.package_dir = "#{RAILS_ROOT}/backups"
    unless ENV['names'].nil?
      ENV['names'].split(',').each do |a_name|
        if File.exist?("public/images/#{a_name}")
          pack.package_files.include("public/images/#{a_name}/**/*")
        else
          print "DIR #{a_name} does not exist!"
        end
      end
    end
    pack.package_files.include("db/symphony_patterns_bak.sql")
  end
end
