(defn spawn [position velocity hue]
  (var split-chance 0.04)
  (def death-chance (* split-chance 0.15))
  (toodle
    :position position
    :velocity velocity
    :color (hsv hue 1 1)
    (when (> (mag position) 400) (die))
    (maybe death-chance (die))
    (turn (rand 0.25))
    (maybe split-chance
      (*= split-chance split-chance)
      (spawn
        position
        (normalize (+ (get-velocity) (marsaglia)))
        (+ hue (rand 0.1))))))

(for i 0 10
  (spawn [0 0] (normalize (marsaglia)) (/ i 6)))

(fade 0.02)
