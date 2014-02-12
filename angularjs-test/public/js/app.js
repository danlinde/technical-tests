'use strict';

// Declare app level module which depends on filters, and services

var myApp = angular.module('myApp', [
  'myApp.controllers',
  'myApp.filters',
  'myApp.services',
  'myApp.directives',
  'ngRoute'
]).config(function($routeProvider, $locationProvider) {
  $routeProvider.when('/home', {
    templateUrl: 'partials/home.html',
    controller: 'AppCtrl'
  }).when('/game', {
    templateUrl: 'partials/partial1.html',
    controller: 'GameCtrl'
  }).when('/highscore', {
    templateUrl: 'partials/partial2.html',
    controller: 'ScoreCtrl'
  }).otherwise({
    redirectTo: '/home'
  });

  $locationProvider.html5Mode(true);
});