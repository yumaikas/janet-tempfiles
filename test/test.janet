(use testament)
(import ../tempfiles :as temp)

(defsuite!
  (def myfile (-> (temp/random-name) (string ".txt") (temp/filename)))

  (def [f/path f] (temp/open-file (temp/random-name)))
  (defer (:close f) 
      (pp f/path)
      (pp f)
      (:write f "test text"))

  (deftest can-tempfile
  (var tempfile-path "")
  (temp/with-file f
      (:write f "test data")
      (set tempfile-path f/path))
  (assert-equal "test data" (slurp tempfile-path))))
