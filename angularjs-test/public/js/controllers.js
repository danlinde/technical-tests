'use strict';

/* Controllers */

angular.module('myApp.controllers', [])
  .controller('AppCtrl', function($scope, $http, scoreKeeper) {

    $http({
      method: 'GET',
      url: '/api/name'
    }).
    success(function(data, status, headers, config) {
      $scope.name = data.name;
    }).
    error(function(data, status, headers, config) {
      $scope.name = 'Error!'
    });
    $scope.reset = function(score) {
      scoreKeeper.score = 0;
    }

  }).controller('GameCtrl', function($scope, $location, $route, words, scoreKeeper) {
    // write Ctrl here
    $scope.words = _.shuffle(words).slice(0,4);
    $scope.answer = _.sample($scope.words)

    $scope.check = function(word) {
      clearInterval(counter)
      if (word == $scope.answer) {
        scoreKeeper.incrementScore()
        console.log(scoreKeeper.score)
        if (scoreKeeper.score == 3) {
          $location.path("/highscore")
        } else {
          $route.reload();
        }
      } else {
        $location.path("/highscore")
        }
      }

    var count = 10,
        counter = setInterval(timer, 1000);

    function timer() {
      count -= 1;
      if (count <= 0) {
         clearInterval(counter);
         $location.path("/highscore").replace();
         $scope.$apply();
         return;
      }
     document.getElementById("timer").innerHTML = count + " seconds";
    }
  }).controller('ScoreCtrl', function($scope, $http, scoreKeeper) {
    $scope.setPlayer = function(player) {
      $scope.player = player;
      $scope.highScores.push({player: player, score: scoreKeeper.score})
      // $http({
      //     method : 'POST',
      //     url : '/highscore',
      //     data : {player: player, score: scoreKeeper.score}
      // })
    }

    $http.get('high_scores/high_scores.json').success(function(data) {
      $scope.highScores = data;
      $scope.orderProp = '-score';
    });     
  });

