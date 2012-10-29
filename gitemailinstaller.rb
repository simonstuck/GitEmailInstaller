#!/usr/bin/ruby

require 'optparse'

# Script to enable email notifications when users push changes to a common
# git repository
#
# Currently only works once and doesn't replace old information. 
# Also only works with a fresh config file.

# Only works on Debian based system for now as those have an email commit
# hook preinstalled

options = {}

optparse = OptionParser.new do |opts|
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end

  opts.on('-r', '--repository PATH', "Path to the repository") do |f|
    options[:repository] = f
  end

  options[:mailinglist] = ""
  opts.on('-l', '--list EMAILS', "List of all the email addresses") do |f|
    options[:mailinglist] = f
  end

  options[:prefix] = "[Git] "
  opts.on('-p', '--prefix STRING', "The email prefix") do |f|
    options[:prefix] = f
  end
end

optparse.parse!

if options[:repository].nil?
  puts "No repository given. Need repository."
  puts "Pass -h or --help for help."
  exit
end


if !File.exist?(options[:repository] + ".git/")
  puts "Not a valid repository."
  exit
end


# Enable the email commit hook in the post-receive hook
# This gets called when a client pushes new changes to the 
# repository
File.open(options[:repository] + ".git/hooks/post-receive", 'a') do |f|
  f.write("/usr/share/doc/git-core/contrib/hooks/post-receive-email")
end

# Writes your meta info for the emails to the config file
File.open(options[:repository] + ".git/config", 'a') do |f|
  f.puts("[hooks]")
  f.puts("\tmailinglist = \"#{options[:mailinglist]}\"")
  f.puts("\temailprefix = \"#{options[:prefix]}\"")
end

puts "All done. Good luck with your project!"
