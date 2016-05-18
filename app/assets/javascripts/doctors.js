/*global angular*/
(function() {
  "use strict";

  angular.module("app").controller("doctorsCtrl", function($scope, $http) {
    $scope.insuranceMatch = "";
    
    $http.get(
      "https://api.betterdoctor.com/2016-03-01/insurances?limit=10&user_key=34e44183fc55b3cc6a106b6983eee243"
    ).then(function(response) {
      $scope.insurances = response.data.data;
      console.log($scope.insurances.data);
    });
    $scope.updateInsurance = function(inputString) {
      $scope.insuranceMatch = inputString;
    };

    window.$scope = $scope;
  });
})(); 