# Crawl the webapp to grab all the internal urls we can
# in order to do some stress testing on the app

require 'rubygems'
require 'nokogiri'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'highline/import'
require 'net/sftp'
require 'net/ssh'
require 'mechanize'
require 'fileutils'

module Crawler

# Crawler skips any URLS that match the following regexp
# EXCLUDE = Regexp.new( /.cts/)

  def Crawler::statify(domain, pattern_system_short_name, logger)
    stack = ["http://#{domain}/pattern_systems/#{pattern_system_short_name}/"]
    
    logger.info "Crawler will statify from URL: #{stack[0]}"
    visited = Hash.new
    agent = WWW::Mechanize.new
    hsh = Hash.new{ |hh,kk| hh[kk] = Array.new }
    fragments = Hash.new
    counter = 1
    visited[stack[0]] = 'index'
    
    while stack.size > 0
        url = stack.shift
        rtry = true
        address = nil
        begin
            logger.debug "Parsing #{url}......."
            page = agent.get(url)
            
            until page.content.sub!("|", "").nil? do end # On supprime les caractères "|", qui servent de séparateur entre les liens dynamiques (supprimés de la version statique)
            
            frag = Nokogiri::HTML(page.content)
            # html=page.content
            
            # until html.sub!("|", "").nil? do end 
                        
            frag.xpath("//*[@href]").each{ |node|
                next unless node['class'] == "crawlable"
                
                if node['href'].include?("http")
                    next unless node['href'].include?(domain)
                    address = node['href']
                else
                    address = "http://#{domain}#{node['href']}"
                end
                
                next if address.nil?
                
                if visited.has_key?( address )
                    hsh[address].push url
                else
                    stack.push address
                    hsh[address].push url
                    visited[address] = 'pattern_' + counter.to_s
                    counter += 1
                end
            
              }

            logger.debug "\tAdapting references to filesystem"
            frag.xpath("//*[@href]").each{ |node|
                add = node['href'].to_s
                node['href'] = add[1..add.length]
            }
            
            logger.debug "\tRemoving dynamic (i.e., non crawlable) references"
            frag.xpath("//a[not(@class='crawlable')]").each{ |node|
                node.remove()
            }
            
            logger.debug "\tChanging image source references"
            frag.xpath("//img").each{|node|
               add = node['src'].to_s
               if add[0..1] == '..'   # Cas des modifs d'URL par tinyMCE
                 node['src'] = add[12..add.length]
               else
                 node['src'] = add[1..add.length]
               end
            }
            
            # On prend également en compte les images dans les styles background des dl !
            frag.xpath("//dl").each{|node|
              style = node['style'].to_s
              
              node['style'] = style.sub('/images', 'images')
            }

            fragments[url] = frag

        rescue Timeout::Error => e
            Kernel.sleep(5)
            if rtry
                rtry = false
                retry
            else
                logger.error "ERROR: Failed on "#{url}"
            end
        end
    end
    
    base_path = "#{RAILS_ROOT}/tmp/PatternSystem"
    project_path = "#{RAILS_ROOT}/public"
    
    # Nettoyage des fichiers temporaires (à supprimer)
    FileUtils.rm_r base_path if File.exists?(base_path)
    
    # On écrit l'ensemble de la hiérarchie
    File.makedirs "#{base_path}/images/common_images"
    
    fragments.each_key{|key|
      newFrag = fragments[key]
      newFrag.xpath("//a").each{|node|
        # On parcourt l'ensemble des références de la page pour 
        # les remplacer par la référence locale
        fragments.each_key{|scannedKey|
          if scannedKey.include? node['href']
            node['href'] = visited[scannedKey] + ".html"
          end
        } 
      }
      
      logger.debug "Writing #{key} to #{visited[key]}.html"

      
      f = File.new("#{base_path}/#{visited[key]}.html", "w+")
      logger.debug f.path
      f.puts(newFrag)
      f.close()
    }
    
    logger.debug "\n--- DONE! Wrote " + fragments.length.to_s + " patterns ---\n\n"
    

    
    logger.debug "Copying images and stylesheets"

    # Copie des données dans le dossier temporaire
    FileUtils.cp_r project_path + "/images/common_images", base_path + "/images"
    FileUtils.cp_r project_path + "/images/#{pattern_system_short_name}", base_path + "/images/#{pattern_system_short_name}"
    FileUtils.cp_r project_path + "/stylesheets", base_path + "/stylesheets"
    
    logger.debug "\n--- DONE! ---\n\n"
    
    logger.debug "Compressing files into archive"
    archive_path = "#{RAILS_ROOT}/tmp/PatternSystem.zip"
    FileUtils.rm archive_path, :force  => true
    
    Zip::ZipFile.open(archive_path, 'w') do |zipfile|
      rec_compress(zipfile, base_path, base_path)
    end
    
    logger.debug "\n--- DONE! ---\n\n"
  end

  # Suppose que l'accès est garanti au site, via échanges de clés sécurisées par ex.
  def Crawler::ssh_send_to(distant_site, login, distant_path)
    local_path = "#{RAILS_ROOT}/tmp/PatternSystem.zip"
    
    unless File.exists?(local_path)
      raise "Archive file not present!"
    end
      
    puts "Sending to #{destination_path}"
#    distant_path = "/www/godetg/PatternSystem/PatternSystem.zip"
    
    # thePassword = ask("Enter tripet password"){|q| q.echo = '*'}
    
    Net::SSH.start(distant_site, login) do |ssh|
      ssh.sftp.connect do |sftp|
        sftp.upload! archive_path, distant_path
      end
      puts "Finished uploading data"
    
      channel = ssh.open_channel do |ch|
        ch.exec "/usr/bin/unzip -o #{distant_path}/PatternSystem.zip -d #{distant_path}" do |ch, success|
               raise "could not execute command" unless success
            # "on_data" is called when the process writes something to stdout
               ch.on_data do |c, data|
                 print data
               end
    
               # "on_extended_data" is called when the process writes something to stderr
               ch.on_extended_data do |c, type, data|
                 print data
               end
    
               ch.on_close { puts "done!" }
        end
      end
      
      channel.wait
      ssh.exec "rm #{distant_path}/PatternSystem.zip"
      puts ssh.exec "ls -a #{distant_path}"
    
    end
  end



protected
  def Crawler::rec_compress(aZipFile, aBasePath, anInitialPath)
      Dir[aBasePath + '/**'].each do |file|
          puts 'Compressing : ' + file
          aZipFile.add(file.sub(anInitialPath + '/', ''), file)
          if File.directory?(file)
            rec_compress(aZipFile, file, anInitialPath)
          end
      end
  end
end