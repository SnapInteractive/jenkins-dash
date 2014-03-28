'use strict';

/* Services */

angular.module('jenkins.services', [])
.value('version', '0.1')
.value('pollInterval', 2000)
.value('localUri', 'localhost:4567')
.value('baseUri', 'localhost:8080')
.factory('generateUrl', [ "baseUri", function(baseUri) {
	return function(job_name, job_number) {
		return "http://" + baseUri + "/job/" + job_name + "/" + job_number + "/console";
	};
} ])
.factory('query', [ "$q", "localUri", function($q, localUri) {
	return function(path) {
		var deferred = $q.defer();
		$.ajax({
			url: "http://" + localUri + path,
			dataType: 'jsonp',
			jsonpCallback: 'test',
			success: function(jobs) {
				deferred.resolve(jobs);
			},
			error : function() {
				deferred.reject();
			},
			timeout: 90000
		});
		return deferred.promise;
	};
} ]);
