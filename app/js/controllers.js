'use strict';

/* Controllers */
angular.module('jenkins.controllers', [])
.controller('MultiJob', [ "$timeout", "generateUrl", "query", "pollInterval", function($timeout, generateUrl, query, pollInterval) {
	var self = this;

	function poller() {
		query("/job_info/multi_jobs").then(function(data) {
			angular.forEach(self.jobs || [], function(old_job, index) {
				angular.forEach(data, function(new_job, index) {
					if (old_job[0].job_number == new_job[0].job_number) {
						new_job.is_open = !!old_job.is_open;
					}
				});
			});
			self.jobs = data;
			$timeout(poller, pollInterval);
		}, function() {
			$timeout(poller, pollInterval);
		});
	}
	poller();

	this.navigate = function(job){
		document.location.href = generateUrl(job.job_name, job.job_number);
	};

	this.toggle = function($event, group) {
		$event.stopPropagation();
		group.is_open = !group.is_open;
	};
} ])
.controller('AllJobs', [ "$timeout", "generateUrl", "query", "pollInterval", function($timeout, generateUrl, query, pollInterval) {
	var self = this;
	function poller() {
		query("/job_info/all_jobs").then(function(data) {
			self.jobs = data;
			$timeout(poller, pollInterval);
		}, function() {
			$timeout(poller, pollInterval);
		});
	}
	poller();

	this.navigate = function(job){
		document.location.href = generateUrl(job.job_name, job.job_number);
	};
} ]);
