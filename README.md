# tempfiles

A very small library for cross-platform tempfiles.

## Examples

```
(import tempfiles :as temp)

(pp (temp/dir)) # => "/tmp" on linux

(def myfile (-> (temp/random-name) (string ".txt") (temp/filename)))

(with [tfile (temp/open-file (temp/random-name))]
    (:write tfile "test text"))

(var tempfile-path "")
(temp/with-file f
    (:write tfile "test data")
    (set tempfile-path f/path))

```

## Installation

First, have [janet installed](https://github.com/janet-lang/janet/releases)
Then, `jpm install https://github.com/yumaikas/janet-tempfiles` should install tempfiles as `tempfiles`

