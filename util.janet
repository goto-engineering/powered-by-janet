(defn save-to-file [data filename]
  (def f (file/open filename :w))
  (file/write f data)
  (file/flush f)
  (file/close f))
