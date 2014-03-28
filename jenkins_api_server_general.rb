#!/usr/bin/ruby193-ruby
require "rubygems"
require "sinatra"
require "sinatra/jsonp"
require 'rack/cache'
require "json"
require 'jenkins_api_client'
require_relative "jenkins_api.rb"

set :server, "webrick"
use Rack::Cache

before do
  cache_control :public, :max_age => 60
  sleep 2
end

get "/job_info/multi_jobs" do
  multi_job_names = ["GoingLive", "SeleniumFOF", "SeleniumAYIPayments", "MergeatronSha"]
  jobs = []
  for i in 0..multi_job_names.length-1
    job_name = multi_job_names[i]
    job_status = get_current_build_status_for_job(job_name)
    job_num = get_current_build_number_for_job(job_name)
    job_num = job_num.to_i
    job_details = get_job_details(job_name)
    downstream_jobs = get_downstream_jobs(job_details)
    main_job_hash = {"job_name" => job_name, "job_number" => job_num, "job_status" => job_status}
    # put the main job at the front of the array
    jobs << downstream_jobs.unshift(main_job_hash)
  end
  puts jobs
  JSONP jobs
end

get "/job_info/all_jobs" do
  job_names = get_all_jenkins_jobs
  count = job_names.length-1
  jobs = []
  for i in 0..count
    job_status = get_current_build_status_for_job(job_names[i])
    job_num = get_current_build_number_for_job(job_names[i])
    job_num = job_num.to_i
    job_details = get_job_details(job_names[i])
    jobs.push({"job_name" => job_names[i], "job_number" => job_num, "job_status" => job_status})
  end
  JSONP jobs
end
