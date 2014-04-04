Jenkins-Dash
================

Having looked long and far it was very difficult to find a good dashboard to 
for display the statuses of your jenkins job. So I decided to create on of
my own.

![Jenkins-Dash](https://github.com/SnapInteractive/jenkins-dash/raw/master/assets/screenshot.png)

How it works:

1. This is a Ruby backend so you need to have Ruby installed
2. Once ruby is installed, install the bundler gem 
 gem install bundler
3. Next run bundle install. 
4. Run the server: ruby jenkins_api_server_general.rb
5. Once the server is running you can open the 2 html files:
jenkins_jobs.html and jenkins_multi_job.html

### Set your Jenkins path
In `app/js/services.js` file you need to update the
following lines of code to point to your Jenkins box:

```javascript
// the host:port of the server running the ruby server
.value('localUri', 'localhost:4567')
// the host:port of the jenkins server
.value('baseUri', 'localhost:8080')
```

### jenkins_jobs.html vs. jenkins_multi_job.html 

The jenkins_jobs.html file will show all the jenkins job you have.

The jenkins_mutli_job.html file shows you all the multi-job you 
have setup in jenkins. In order to see this you must update the following code

```ruby
get "/job_info/multi_jobs" do
  multi_job_names = ["JobName1","JobName2"]
```

### Set the Jenkins IP for your server 
In file jenkins_api.rb the very first line, 
update with the ip of their Jenkins box

```ruby
$client = JenkinsApi::Client.new(:server_ip => '')
```

If the jenkins box requires username and password you can add that as well

```ruby
$client = JenkinsApi::Client.new(:server_ip => '',
        :username => 'somename', :password => 'secret password')
``` 
  
License: Apache 2.0
2014-03-28
Snap-Interactive Inc.


