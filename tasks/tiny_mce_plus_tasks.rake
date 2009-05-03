namespace :tiny_mce_plus do
  desc 'Install the tiny_mce_plus plugin'
  task :install do
    puts "** Installing tiny_mce_plus plugin ..."           

    source = File.join(RAILS_ROOT, '/vendor/plugins/tiny_mce_plus/assets/.')
    dest = RAILS_ROOT
    FileUtils.cp_r source, dest
         
    puts "** Successfully installed tiny_mce_plus plugin"
  end
  
  desc 'Install the tiny_mce_plus dependent plugins'
  task :plugins do
    puts "** Installing tiny_mce_plus dependent plugins ..."           

    source = File.join(RAILS_ROOT, '/vendor/plugins/tiny_mce_plus/plugins/.')
    dest = File.join(RAILS_ROOT, '/vendor/plugins/')
    FileUtils.cp_r source, dest
         
    puts "** Successfully installed tiny_mce_plus dependent plugins"
  end
  
  desc "Sync tiny_mce_plus files into the app"
  task :sync do
    puts "** Syncing tiny_mce_plus migration, initializer, and public files" 
    system "rsync -ruv vendor/plugins/tiny_mce_plus/db/migrate db"
    system "rsync -ruv vendor/plugins/tiny_mce_plus/config/initializers config"
    system "rsync -ruv vendor/plugins/tiny_mce_plus/public ."
    puts "** Successfully synced tiny_mce_plus files"
  end

end