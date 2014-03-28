Jenkins-Dash
================

Having looked long and far it was very difficult to find a good dashboard to 
for display the statuses of your jenkins job. So I decided to create on of
my own.

How it works:

1. This is a Ruby backend so you need to have Ruby installed
2. Once ruby is installed, install the bundler gem 
 gem install bundler
3. Next run bundle install. 
4. Run the server: ruby jenkins_api_server_general.rb
5. Once the server is running you can open the 2 html files:
jenkins_jobs.html and jenkins_multi_job.html

#Set your Jenkins path
Under the app dir in the services.js file you need to update the
following lines of code to point to your Jenkins box:

```shell
.value('localUri', 'localhost:4567')
.value('baseUri', 'localhost:8080')
```

#jenkins_jobs.html vs. jenkins_multi_job.html 

The jenkins_jobs.html file will show all the jenkins job you have.

The jenkins_mutli_job.html file shows you all the multi-job you 
have setup in jenkins. In order to see this you must update the following code

```shell
get "/job_info/multi_jobs" do
  multi_job_names = ["JobName1","JobName2"]
```
  



