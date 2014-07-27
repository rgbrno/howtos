#!/usr/bin/env ruby
# some source originated from https://github.com/gummesson/jekyll-rake-boilerplate

require 'yaml'
#
# executes a system command
def execute(command)
  system "#{command}"
end

# loads the configuration file
CONFIG = YAML.load_file("_config.yml")

# get branch from first command line parameter or default from config
branch = ARGV[0] || CONFIG["git"]["branch"] || "gh-pages"

# builds jekyll site into destination
execute("jekyll build")

# copies result files from destination to current dir
nojekyll = File.exist?(".nojekyll")
if nojekyll
  destination = CONFIG["destination"]
  execute("cp #{destination}/* . -r")
end

# commits and pushes to origin
execute("git add .")
execute("git commit")
execute("git push origin #{branch}")
