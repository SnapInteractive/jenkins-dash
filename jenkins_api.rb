$client = JenkinsApi::Client.new(:server_ip => '')

def get_current_build_status_for_job(job_name)
  return $client.job.get_current_build_status(job_name)
end

def get_current_build_number_for_job(job_name)
  return $client.job.get_current_build_number(job_name)
end

def get_job_details(job_name)
  return $client.job.list_details(job_name)
end

def get_job_build_details(job_name, job_number)
  return $client.job.get_build_details(job_name, job_number)
end

def get_downstream_jobs(job_info)
  downstream_jobs = job_info['downstreamProjects']
  puts downstream_jobs
  downstream_jobs_array = []
  downstream_jobs.each  { |x| jobs_hash = { "job_name" => x['name'],
                              "job_number" => get_current_build_number_for_job(x['name']),
                              "job_status" => get_current_build_status_for_job(x['name'])
                            }
                            downstream_jobs_array.push(jobs_hash)
                        }
  return downstream_jobs_array
end

def print_out_status_of_downstream_jobs(job_list)
	job_list.each { |x| puts x
  puts get_current_build_number_for_job(x) 
  puts get_current_build_status_for_job(x) 
  puts "\n"
}
end

def get_all_jenkins_jobs
  return $client.job.list_all
end
