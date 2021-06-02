# Mastermind!

Play it live!

https://replit.com/@abar161/mastermind

A console version of Mastermind written in Ruby as part of The Odin Project curriculum.  Can you create a code that the computer can't break? (No... but it does a lot of math very quickly.)  The unicode characters chosen to display numbers render pretty small in chrome.  Firefox is recommended to view the replit until a better solution can be found

Key learning concepts:
<ul>
  <li>Encapsulation: 
    <ul>
     <li>The secret code can't accessed while the game is running.</li>
     <li>Private variables for each turn results can be read but not changed.</li>
    </ul>
  </li>

  <li>Class design: 
   <ul>
    <li>Separate classes for game state, game logic, game display, and human/computer code breakers.</li>
    <li>Experimented with class functions where state was not important.  (MastermindPrinter class,  Mastermind.valid_code? function)</li>
   </ul>
  </li>

  <li>Enumeration methods
    <ul>
      <li>A lot of practice while creating this game.</li>
    </ul>
  </li>

  <li>Array methods
   <ul>
    <li>Learned about repeated_permutation method which saved a ton of time and a messy code block.</li>
    <li>Using & operator to intersect two arrays.</li>
   </ul>
  </li>

  <li>Use of Rubocop linter for (mostly) consistent code style.</li>
</ul>
