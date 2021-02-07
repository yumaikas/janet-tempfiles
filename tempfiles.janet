(import path)

(def- alphabet (string 
    "abcdefghijklmnopqrstuvwxyz"
    "0123456789"))

(defn random-name
  ```
  Gives a randome filename fo a given length, in characters, defaulting to 10 chars
  ```
  [&opt len] 
    (default len 10)
    (string/from-bytes  
      ;(seq [x :range (0 len)]
         (alphabet (math/trunc (* 35 (math/random)))))))

(defn dir
  ```
  Gives the location of temp/dir as an absolute path.
  ```
    [] 
    (def osw (os/which))
    (or 
        (and (= osw :windows) 
            (or 
                (os/getenv "TMP")
                (os/getenv "TEMP")
                (os/getenv "USERPROFILE")))
        (and (= osw :osx)  (os/getenv "TMPDIR"))
        (and (= osw :linux)  "/tmp")
        (error "Could not find a temp dir!")))

(defn filename
  ```
  Gives the path of the file in the temdir
  ```
  [& name] 
    (path/join (dir) (string (splice name))))

(defn open-file 
  ```
  Opens a file for writing in (temp/dir) with the given name.
  ```
  [name]
    (def tpath (path/join (dir) name))
    (def f (file/open tpath :w))
    [tpath f])


(defmacro with-file [binding & body]  

  ~(upscope 
     (def ,(symbol binding "/path") (,random-name 20))
     # (pp ,(symbol binding "/path"))
     (with [,binding (,file/open ,(symbol binding "/path") :w)]
       # (pp ,binding)
       ,;body)))

