(use testament)
(import ../tempfiles :as temp)

(exercise! []
  (def myfile (-> (temp/random-name) (string ".txt") (temp/filename)))

  (def [f/path f] (temp/open-file (temp/random-name)))
  (defer (:close f) 
      (:write f "test text"))

  (deftest can-tempfile
  (var tempfile-path "")
  (temp/with-file f
      (:write f "test data")
      (set tempfile-path f/path))
  (assert-equivalent @"test data" (slurp tempfile-path))))
