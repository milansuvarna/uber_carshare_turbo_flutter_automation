# frozen_string_literal: true

require 'fileutils'

def run_tests_with_allure(platform)
  ENV['PLATFORM'] = platform
  Rake::Task[:run_with_allure].invoke
end

desc 'Run tests on Android and generate Allure report'
task :android do
  run_tests_with_allure('android')
end

desc 'Run tests on iOS and generate Allure report'
task :ios do
  run_tests_with_allure('ios')
end

task :run_with_allure do
  sh 'rspec spec --format AllureRspecFormatter'
end

task :report do
  sh 'allure generate report --clean -o report/allure-report'
  sh 'allure open report/allure-report'
end

task :clean_report do
  folder_report_allure = "#{Dir.pwd}/report"
  folder_report_minitest = "#{Dir.pwd}/test"
  FileUtils.rm_rf(Dir.glob("#{folder_report_allure}/*"))
  FileUtils.rm_rf(Dir.glob(folder_report_minitest.to_s))
end

task :default do
  puts 'Please specify a command:'
  puts '- rake android: Run tests on Android and generate Allure reports.'
  puts '- rake ios: Run tests on iOS and generate Allure reports.'
  puts '- rake report: Generate Allure reports without running tests.'
  puts '- rake clean_report: Clean allure-report and test folders.'
end
