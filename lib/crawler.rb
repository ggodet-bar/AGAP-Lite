# Crawl the webapp to grab all the internal urls we can
# in order to do some stress testing on the app

# Crawler is limited to this domain
DOMAIN = "0.0.0.0:3000"
# Crawler skips any URLS that match the following regexp
EXCLUDE = Regexp.new( /.cts/)

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'highline/import'
require 'net/sftp'
require 'net/ssh'

def rec_compress(aZipFile, aBasePath, anInitialPath)
    Dir[aBasePath + '/**'].each do |file|
        puts 'Compressing : ' + file
        aZipFile.add(file.sub(anInitialPath + '/', ''), file)
        if File.directory?(file)
          rec_compress(aZipFile, file, anInitialPath)
        end
    end
end


stack = ["http://0.0.0.0:3000/pattern_systems/266846998"]
visited = Hash.new
hsh = Hash.new{ |hh,kk| hh[kk] = Array.new }
fragments = Hash.new
agent = WWW::Mechanize.new
counter = 1
visited["http://0.0.0.0:3000/pattern_systems/266846998"] = 'index'
while stack.size > 0
    url = stack.shift
    
#    puts "selected url: " + url
    rtry = true
    address = nil
    begin
        page = agent.get url
        html=page.content
        
        until html.sub!("|", "").nil? do end  # On supprime les caractères "|", qui servent de séparateur entre les liens dynamiques (supprimés de la version statique)
          
        html.each do |uri|
            uri.each_line do |uline|
                tmp = uline.scan( /href=.*?\>/ )
                tmp.each{ |href|
                    next if href =~ EXCLUDE
                    next unless href.include?("crawlable")
                    
                    if href.include?( "http" )
                        next unless href.include?( DOMAIN )
                        address = href.split( "href=" )[1].split("\"")[1]
                        
                    else
                        address = "http://#{DOMAIN}#{href.split( "href=" )[1].split("\"")[1]}"
                    end
 #                   puts 'full address : ' + address
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
            end
        end
        puts "Parsing #{url}......."
        frag = Nokogiri::HTML(html)
        
        puts "\tAdapting references to filesystem"
        frag.xpath("//*[@href]").each{ |node|
            add = node['href'].to_s
            node['href'] = add[1..add.length]
        }
        
        puts "\tRemoving dynamic (i.e., non crawlable) references"
        frag.xpath("//a[not(@class='crawlable')]").each{ |node|
            node.remove()
        }
        
        puts "\tChanging image source references"
        frag.xpath("//img").each{|node|
           add = node['src'].to_s
           if add[0..1] == '..'   # Cas des modifs d'URL par tinyMCE
             node['src'] = add[6..add.length]
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
            puts "ERROR: Failed on "#{url}"
        end
    end
end

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
  puts "Writing #{key} to #{visited[key]}.html"
  f = File.new("/Users/godetg/Desktop/PatternSystem/#{visited[key]}.html", "w+")
  f.puts(newFrag)
  f.close()
}

puts "\n--- DONE! Wrote " + fragments.length.to_s + " patterns ---\n\n"

base_path = "/Users/godetg/Desktop/PatternSystem"
project_path = "/Users/godetg/Documents/RadAgap/public/"

puts "Copying images and stylesheet"
FileUtils.rm_r base_path + "/images"
FileUtils.rm_r base_path + "/stylesheets"
FileUtils.cp_r project_path + "images", base_path + "/images"
FileUtils.cp_r project_path + "stylesheets", base_path + "/stylesheets"

puts "\n--- DONE! ---\n\n"

puts "Compressing files into archive"
archive_path = "/Users/godetg/Desktop/PatternSystem.zip"
FileUtils.rm archive_path, :force  => true

Zip::ZipFile.open(archive_path, 'w') do |zipfile|
  rec_compress(zipfile, base_path, base_path)
end

puts "\n--- DONE! ---\n\n"

puts "Sending to tripet"
distant_path = "/www/godetg/PatternSystem/PatternSystem.zip"

# thePassword = ask("Enter tripet password"){|q| q.echo = '*'}

Net::SSH.start('tripet.imag.fr', 'godetg') do |ssh|
  ssh.sftp.connect do |sftp|
    sftp.upload! archive_path, distant_path
  end
  puts "Finished uploading data"

  channel = ssh.open_channel do |ch|
    ch.exec "/usr/bin/unzip -o /www/godetg/PatternSystem/PatternSystem.zip -d /www/godetg/PatternSystem/" do |ch, success|
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
  ssh.exec "rm /www/godetg/PatternSystem/PatternSystem.zip"
  puts ssh.exec "ls -a /www/godetg/PatternSystem"

end


# hsh.each_key do |key|
#     val = hsh[key]
#     puts key
#     val.each{ |url| puts "\t" + url }
# end