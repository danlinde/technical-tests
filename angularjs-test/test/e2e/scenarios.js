'use strict';

describe('myApp', function() {

    describe('Home view', function() {

    beforeEach(function() {
      browser().navigateTo('/home');
    });  

    it('should start game on button click', function() {
      element('.start').click();
      browser().navigateTo('/game');
      expect(browser().location().path()).toBe('/game')
    });
  });

  describe('Game view', function() {

    beforeEach(function() {
      browser().navigateTo('/game');
    });  

    it('should show 4 choices that can be selected as answers', function() {
      expect(repeater('.answers').count()).toBe(4);
    });

    it('should show a word with definition', function() {
      expect(binding('answer.en')).not().toBe(null);
      expect(binding('answer.def')).not().toBe(null);
    });
  });

  describe('Highscore view', function() {

    beforeEach(function() {
      browser().navigateTo('/highscore');
      // pause();
    });  

    it('should show the name entered by player', function() {
      input('player').enter('name');
      expect(binding('player')).toBe('name')
    });

    it('should add player to highscore list', function(){
      expect(repeater('.scores').count()).toEqual(3);
      
      input('player').enter('name');
      element('button').click();

      expect(element('li.scores:eq(3)').text()).toContain('name')
      expect(repeater('.scores').count()).toEqual(4);
    });
  });
});
