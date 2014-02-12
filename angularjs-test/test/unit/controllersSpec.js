'use strict';

describe('myApp.controllers', function() {

  describe('AppCtrl', function(){

    beforeEach(module('myApp'));

    it('.reset should set score to zero', inject(function(scoreKeeper, $controller) {
      var scope = {},
          ctrl = $controller('AppCtrl', {$scope:scope});
      scope.reset;
      expect(scoreKeeper.score).toBe(0);
    }));
  });

  describe('GameCtrl', function(){

    beforeEach(module('myApp'));

    var scope, ctrl;

    beforeEach(inject(function($controller) {
      scope = {},
      ctrl = $controller('GameCtrl', {$scope:scope});
    }));

    it('.words creates model with 4 words', function() {
      expect(scope.words.length).toBe(4);
    });

    it('.answer to be contained in words', function() {
      expect(scope.words).toContain(scope.answer);
    });

    it('.check redirects to highscore when game is won', inject(function($location, scoreKeeper) {
      spyOn($location, 'path')

      scoreKeeper.score = 2
      scope.check(scope.answer);

      expect($location.path).toHaveBeenCalledWith('/highscore');
    }));

    it('.check redirects to highscore when game is lost', inject(function($location, scoreKeeper) {
      spyOn($location, 'path')

      scoreKeeper.score = 1
      scope.check();

      expect($location.path).toHaveBeenCalledWith('/highscore');
    }));

    it('.check increments score on correct guess', inject(function(scoreKeeper) {
      scoreKeeper.score = 1
      scope.check(scope.answer);

      expect(scoreKeeper.score).toEqual(2);
    }));
  });

  describe('ScoreCtrl', function(){

    beforeEach(module('myApp'));

    var scope, ctrl, $httpBackend;

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('high_scores/high_scores.json').
          respond([{name: 'Tom', score: 2}, {name: 'Dick', score: 3}]);
      scope = $rootScope.$new();
      ctrl = $controller('ScoreCtrl', {$scope: scope});
    }));

    it('should create a high score list xhr', function() {
      expect(scope.highScores).toBeUndefined();
      $httpBackend.flush();
      expect(scope.highScores).toEqual([{name: 'Tom', score: 2}, {name: 'Dick', score: 3}]);
    });

    it('should set the default value of orderProp model', function() {
      expect(scope.orderProp).toBeUndefined();
      $httpBackend.flush();
      expect(scope.orderProp).toBe('-score');
    });
  });
});