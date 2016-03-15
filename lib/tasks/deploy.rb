namespace :heroku do

  desc "install toolbelt"
  task :install => :environment do
    puts `wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh`
    puts ""
    puts "----------------"
    puts "Please create a app with 'contactsearch' name on heroku and then"
    puts "login to your heroku account from command line using:"
    puts "heroku login"
    puts "then run heroku:setup"
  end

  desc "setup heroku"
  task :setup => :environment do
    puts `heroku git:remote -a contactsearch`
  end

  desc "Logout from Heroku"
  task :logout => :environment do
    puts `heroku logout`
  end

  desc "Deploy app to heroku"
  task :deploy => :environment do
    puts 'Deploying site to Heroku ...'
    puts `git push heroku --verbose`

    puts 'Running database migrations ...'
    puts `heroku run rake db:migrate`

    release_name = "release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push --tags heroku`

    puts 'All done!'
  end

  desc "Rollback app from heroku"
  task :rollback => :environment do
    releases = `git tag`.split("\n").select { |t| t[0..7] == 'release-' }.sort
    current_release = releases.last
    previous_release = releases[-2] if releases.length >= 2
    if previous_release
      puts "Rolling back to '#{previous_release}' ..."
      puts `git push -f heroku #{previous_release}:master`
      puts "Deleting rollbacked release '#{current_release}' ..."
      puts `git tag -d #{current_release}`
      puts `git push heroku :refs/tags/#{current_release}`
      puts 'All done!'
    else
      puts "No release tags found - can't roll back!"
      puts releases
    end
  end
end