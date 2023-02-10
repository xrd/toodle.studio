(def franticness 0.01)

(def particles (seq [:range [0 100]]
  @{:p (* (marsaglia) 128)
    :v (* (marsaglia) 3)
    :h (rand 0 0.5)
    :w 1}))

(var centroid [0 0])
(defn calculate-centroid []
  (set centroid [0 0])
  (each particle particles
    (+= centroid particle.p))
  (/= centroid (length particles)))

(toodle :width 5 :speed 2 :color white :position [150 -50]
  (turn 0.005)
  (turn (* 0.035 (sin (/ age 30))))

  (start (eachp [i particle] particles
    (doodle
      (def speed (math/random))
      (forever
        (when (= i 0)
          (calculate-centroid))
        (def target position)
        (def start particle.p)

        (def attraction (- target start))
        (def repulsion (- start centroid))

        (def desired-v (+ (* (marsaglia) 10) (* attraction 0.05)))
        (set particle.v
          (mix desired-v particle.v franticness))

        (def amt (/ (pow (mag repulsion) 2)))

        (+= particle.v (* repulsion (* speed (min amt 10))))

        (def end (+ start particle.v))
        (yield [start end (hsv particle.h 1 1) particle.w])
        (set particle.p end))
      ))))

(fade 0.1)
