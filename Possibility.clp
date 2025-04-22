;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "Possibility" - Expanded Two-Choice Adventure in CLIPS
;; Includes NPCs, branching paths, and multiple endings.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           Abdallah Amr Hegazy - عبدالله عمرو حجازي
;;          Abdullah Majid Muhammad - عبدالله ماجد محمد
;;           Alaa Muhammad Al-Qutb - علاء محمد القطب
;;              Omar Ahmad Saleh - عمر احمد صالح
;;          Karim Qadri Abdelqader - كريم قدري عبدالقادر
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Initial facts to begin the adventure
(deffacts start
   "Initial fact to begin the adventure"
   (status start)
)

;; ============================
;; Helper function: Start Game
;; ============================
(deffunction kick ()
   (clear)
   (reset)
   (run)
)

;; ============================
;; Level 1: The Dark Forest
;; ============================
(defrule play-level1
   "The player chooses between left or right."
   (status start)
   =>
   ;; GUI Header for Level 1
   (printout t crlf 
     "======================================================" crlf
     "||               THE DARK FOREST AWAITS...          ||" crlf
     "======================================================" crlf
     crlf
     "You wake up in a dim, flickering world with no memory." crlf
     "A single whisper echoes:" crlf
     "\"Choose... or fade.\" You see two paths ahead: LEFT and RIGHT." crlf
     crlf
     "Which path will you take? (left/right): ")
   (bind ?choice (read))
   (if (eq ?choice left) then
       (assert (status safe-path))
       (printout t crlf 
         "____________________________________________________" crlf
         "You follow the LEFT path. The air feels lighter," crlf
         "and you sense temporary safety—for now." crlf
         "____________________________________________________" crlf)
   else
       (assert (status danger-path))
       (printout t crlf 
         "____________________________________________________" crlf
         "You follow the RIGHT path. Shadows grow darker," crlf
         "and a creeping silence surrounds you. THE SILENCE IS NEAR." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Level 2: Meeting Hegazy
;; ============================
(defrule meet-hegazy
   "Player meets Hegazy after choosing a path."
   (not (game-over))
   (or (status safe-path)
       (status danger-path))
   =>
   ;; GUI Header for Level 2
   (printout t crlf 
     "======================================================" crlf
     "||                   MEET HEGAZY                    ||" crlf
     "======================================================" crlf
     crlf
     "A man named Hegazy appears. He looks paranoid and warns" crlf
     "you not to trust anyone. He asks if he can guide you" crlf
     "deeper into the forest. Do you accept his help? (yes/no): ")
   (bind ?choice (read))
   (if (eq ?choice yes) then
       (assert (status guided-by-hegazy))
       (printout t crlf 
         "____________________________________________________" crlf
         "Hegazy nods nervously and begins leading you through" crlf
         "the forest. His steps are quick, but deliberate." crlf
         "____________________________________________________" crlf)
   else
       (assert (status alone-in-forest))
       (printout t crlf 
         "____________________________________________________" crlf
         "Hegazy frowns deeply and vanishes into the shadows." crlf
         "You continue alone, feeling more isolated than ever." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Level 3: Meeting Abdallah
;; ============================
(defrule meet-abdallah
   "Player meets Abdallah after Hegazy."
   (not (game-over))
   (or (status guided-by-hegazy)
       (status alone-in-forest))
   =>
   ;; GUI Header for Abdallah's Introduction
   (printout t crlf 
     "======================================================" crlf
     "||                  MEET ABDALLAH                   ||" crlf
     "======================================================" crlf
     crlf
     "As you continue through the forest, you stumble upon" crlf
     "Abdallah, sitting by a fire. He looks weary but kind." crlf
     "\"I've been waiting for someone like you,\" he says." crlf
     "\"Will you join me? Together, we might escape this place.\" (yes/no): ")
   (bind ?choice (read))
   (if (eq ?choice yes) then
       (assert (status joined-abdallah))
       (printout t crlf 
         "____________________________________________________" crlf
         "Abdallah smiles warmly and hands you a torch." crlf
         "\"Stay close,\" he whispers. The two of you press on." crlf
         "His presence gives you strength." crlf
         "____________________________________________________" crlf)
   else
       (assert (status abandoned-abdallah))
       (printout t crlf 
         "____________________________________________________" crlf
         "Abdallah sighs deeply and fades into the darkness." crlf
         "You feel a pang of guilt as you walk away alone." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Level 4: Alaa's Offer
;; ============================
(defrule alaa-offers-help
   "Alaa offers comfort but seems off."
   (not (game-over))
   (or (status joined-abdallah)
       (status abandoned-abdallah))
   =>
   ;; GUI Header for Level 3
   (printout t crlf 
     "======================================================" crlf
     "||                  ALAA'S OFFER                    ||" crlf
     "======================================================" crlf
     crlf
     "A calm figure named Alaa approaches you. He smiles warmly" crlf
     "and says, \"Let me help you find safety. Trust me, I know" crlf
     "the way.\" Do you trust him? (yes/no): ")
   (bind ?choice (read))
   (if (eq ?choice yes) then
       (assert (status followed-alaa))
       (printout t crlf 
         "____________________________________________________" crlf
         "Alaa leads you down a glowing path. The air feels" crlf
         "lighter, but something about him seems... unnatural." crlf
         "____________________________________________________" crlf)
   else
       (assert (status rejected-alaa))
       (printout t crlf 
         "____________________________________________________" crlf
         "Alaa sighs softly and melts into the mist. Shadows" crlf
         "grow stronger as you press on without his guidance." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Level 5: Kareem's Plea
;; ============================
(defrule encounter-kareem
   "Kareem begs for help, offering a shortcut."
   (not (game-over))
   (or (status followed-alaa)
       (status rejected-alaa))
   =>
   ;; GUI Header for Level 4
   (printout t crlf 
     "======================================================" crlf
     "||                  KAREEM'S PLEA                   ||" crlf
     "======================================================" crlf
     crlf
     "In a hallway of mirrors, you meet Kareem, a broken man" crlf
     "crying silently. He pleads," crlf
     "\"Help me destroy these mirrors, they remind me of my" crlf
     "mistakes. In return, I'll show you a shortcut.\" Will you" crlf
     "help him? (yes/no): ")
   (bind ?choice (read))
   (if (eq ?choice yes) then
       (assert (status helped-kareem))
       (printout t crlf 
         "____________________________________________________" crlf
         "Kareem smashes the mirrors with gratitude. As promised," crlf
         "he shows you a secret passage." crlf
         "____________________________________________________" crlf)
   else
       (assert (status abandoned-kareem))
       (printout t crlf 
         "____________________________________________________" crlf
         "Kareem screams in despair as the mirrors shatter around" crlf
         "him. Shadows creep closer as you walk away." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Level 7: Omar's Deal
;; ============================
(defrule deal-with-omar
   "Omar offers a dark deal near the end."
   (not (game-over))
   (or (status helped-kareem)
       (status abandoned-kareem))
   =>
   ;; GUI Header for Level 5
   (printout t crlf 
     "======================================================" crlf
     "||                  OMAR'S DEAL                     ||" crlf
     "======================================================" crlf
     crlf
     "A mysterious figure named Omar blocks your path. He says," crlf
     "\"I can end this nightmare, but only if you sacrifice" crlf
     "someone dear to you. Agree to the deal? (yes/no): ")
   (bind ?choice (read))
   (if (eq ?choice yes) then
       (assert (status made-deal-with-omar))
       (printout t crlf 
         "____________________________________________________" crlf
         "Omar grins wickedly as the world shifts around you." crlf
         "You feel... different." crlf
         "____________________________________________________" crlf)
   else
       (assert (status refused-omar))
       (printout t crlf 
         "____________________________________________________" crlf
         "Omar chuckles darkly and steps aside. \"Then good luck" crlf
         "finding your own way,\" he whispers." crlf
         "____________________________________________________" crlf)
   )
)

;; ============================
;; Endings
;; ============================

;; Ending: The Silence Consumes
(defrule ending-the-fade
   "The Silence consumes those who hesitate too often."
   (declare (salience 100))
   (not (game-over))
   (status danger-path)
   (status abandoned-kareem)
   =>
   ;; GUI Header for Ending 1
   (printout t crlf 
     "======================================================" crlf
     "||                  THE FADE ENDING                 ||" crlf
     "======================================================" crlf
     crlf
     "The creeping shadows close in. You hesitate one moment" crlf
     "too long. THE SILENCE CONSUMES YOU." crlf
     crlf)
   (assert (game-over))
   (halt)               
)

;; Ending: The Time Loop
(defrule ending-the-loop
   "Following Omar traps you in a time loop."
   (declare (salience 100))
   (not (game-over))
   (status made-deal-with-omar)
   =>
   ;; GUI Header for Ending 2
   (printout t crlf 
     "======================================================" crlf
     "||                  THE LOOP ENDING                 ||" crlf
     "======================================================" crlf
     crlf
     "You awaken in the same dim forest, haunted by déjà vu." crlf
     "YOU ARE NOW OMAR. THE LOOP CONTINUES..." crlf
     crlf)
   (assert (game-over))
   (halt)               
)

;; Ending: The Escape
(defrule ending-the-escape
   "Making honest decisions grants freedom."
   (declare (salience 100))
   (not (game-over))
   (status helped-kareem)
   (status refused-omar)
   =>
   ;; GUI Header for Ending 3
   (printout t crlf 
     "======================================================" crlf
     "||                  THE ESCAPE ENDING               ||" crlf
     "======================================================" crlf
     crlf
     "You emerge from the forest into sunlight. Blinking against" crlf
     "the brightness, you realize you're lying in a hospital bed." crlf
     "WAS IT ALL A DREAM?" crlf
     crlf)
   (assert (game-over))
   (halt)               
)

;; Ending: Becoming Part of The Silence
(defrule ending-the-merge
   "Defying all rules merges you with The Silence."
   (declare (salience 100))
   (not (game-over))
   (status rejected-alaa)
   (status abandoned-kareem)
   =>
   ;; GUI Header for Ending 4
   (printout t crlf 
     "======================================================" crlf
     "||                  THE MERGE ENDING                ||" crlf
     "======================================================" crlf
     crlf
     "The world glitches violently. Shadows consume everything," crlf
     "including you. YOU HAVE BECOME PART OF THE SILENCE." crlf
     crlf)
   (assert (game-over))
   (halt)               
)
