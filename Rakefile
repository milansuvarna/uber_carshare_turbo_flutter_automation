# frozen_string_literal: true

require 'fileutils'

task :rspec do
  sh 'rspec spec --format AllureRspecFormatter'
end

task :generate_report do
  sh 'allure generate report --clean -o report/allure-report'
end

task :open_report do
  sh `allure open report/allure-report`
end

task :clean_folder do
  folder_report_allure = "#{Dir.pwd}/report"
  folder_report_minitest = "#{Dir.pwd}/test"
  FileUtils.rm_rf(Dir.glob("#{folder_report_allure}/*"))
  FileUtils.rm_rf(Dir.glob(folder_report_minitest.to_s))
end
