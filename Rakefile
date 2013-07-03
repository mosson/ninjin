#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

LogViewerApp::Application.load_tasks


namespace :server do
	task :start do
		puts "Starting unicorn server..."
	end
	task :stop do
		puts "Stopping uniorn server..."
	end
	task :restart do
		puts "Restarting unicorn server..."
	end
end