# Angular front end test

### App

You will find 11 words with keyphrases and spanish translation hardcoded in words AngularJS value in *public/js/services.js*.  

1. On every round one random word is chosen - question asked to the player. We show player english word with english keyphrase.  
2. We also provide 3 answers - shown to user in  Spanish - chosen randomly from 11 words provided (one of them is translation of previously randomly chosen word).   
3. The game consists of 3 rounds. If
the user chooses the wrong answer the game is finished.
4. When the game is finished the
 user can enter his name. If he does, the score is sent to the server, and will appear on "High score" subpage of the app. This subpage will download highscore list, using $http AngularJS service.

_Tip:
No need to use 
any database persistence on server-side - keeping data in NodeJS memory is sufficient for this test._

### Running the app

    npm install
    bower install
    nodemon app.js

then go to [http://localhost:3000](http://localhost:3000) 

### Running the tests

    ./scripts/e2e-test.sh
    ./scripts/test.sh

### Test

Your code will be assessed on:   
- clean app structure (you are welcome to change files organisation)  
- code formatting and naming  
- object-oriented design and implementation

In particular for this test you can ignore:  
- How the app looks. -W
e included Bootstrap to make development process faster  
- Performance-W
e do optimise our apps, but productivity 
takes priority

##### Additional tasks
I added the following to the app:  
- U
nit tests 
- Add timing to game

### Areas for improvement
- Extend test coverage
- Add styling
- Improve UX. E.g. notify user of correct answers, show current score
