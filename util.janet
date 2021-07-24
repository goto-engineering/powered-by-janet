(defn save-to-file [data filename]
  (def f (file/open filename :w))
  (file/write f data)
  (file/flush f)
  (file/close f))

(defn ensure-dir [dir]
  (match (os/stat dir)
    nil (os/mkdir dir)
    {:mode :directory} nil
    _ (error (string `"` dir `" exists and is not a directory!`))))
