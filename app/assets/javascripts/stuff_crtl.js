/*global angular*/
(function() {
  "use strict";

  angular.module("app").controller("stuffCtrl", function($scope) {
    $scope.message = "Hello";

    window.$scope = $scope;
  });
})();  