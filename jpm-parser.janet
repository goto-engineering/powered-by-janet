(comment
  # This is a command for taking a given version of JPM, 
  # and generating an environment that can be used to intercept various JPM calls
  # It needs to be run from an instance of `jpm debug-repl` that isn't in
  # a folder with a project.janet
  ((fn [] 
     (def fout {:write (fn [self arg] (buffer/push (self :buf) arg)) :buf @"" })

     (defer (do (spit "40.48 powered-by-janet/jpm-env.janet" (string (fout :buf))))
       (defn s. [& args] (string ;args))
       (defn fmt. [spec & args] (string/format spec ;args))

       (defn emit-header [bout]
         (:write bout "(def *capture* @{})\n")
         (:write bout "(defn- append-capture [name & arg]\n")
         (:write bout "(update *capture* name (fn [val] (array/push (or val []) arg))))\n"))

       (defn emit-value [bout name val] 
         (:write bout (s. "(var " name " nil)\n")))
       (defn emit-empty-macro [bout fname] 
         (:write bout (s. "(defmacro "  fname " [& args] nil)\n")))
       (defn emit-capture-macro [bout fname] 
         (:write bout (s. "(defmacro " fname " [& args]\n"))
         (:write bout (s. "    (append-capture '" (s. fname) " args)\n"))
         (:write bout (s. "    nil)\n")))
       (emit-header fout)
       (loop [[k v] :in (pairs (curenv))
              :when (not= k 'env)]  
         (def is-declare (string/has-prefix? "declare-" (string k)))
         (match [is-declare (get-in v [:value])] 
           [true] (emit-capture-macro fout k)
           [false (e (function? e))] (emit-empty-macro fout k)
           [false info] (emit-value fout k info)
           _ (error (string/format "Didn't handle %v => %v" k v))
           )))))
