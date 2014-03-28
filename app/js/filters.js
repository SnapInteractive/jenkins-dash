'use strict';

/* Filters */

angular.module('jenkins.filters', [])
.filter('ucWords', [ function() {
	return function(text) {
		return String(text).replace(/(^|\s)([a-z])/g, function(word, space, letter) {
			return space + letter.toUpperCase();
		});
	};
} ]);
