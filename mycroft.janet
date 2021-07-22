(import path)

(def clean-env (table/clone (curenv)))

(defn load-jpm-env [] 
  (dofile "jpm-env.janet" :env (make-env)))

(def f (fiber/new load-jpm-env))
(def jpm-env (resume f))

(defn project-path [repo-dir]
  (path/join "repos" repo-dir "project.janet"))

(defn has-project.janet? [repo] (os/stat (project-path repo)))

(defn get-kv [args key]
  (if-let [idx (index-of key args)]
        (get args (+ 1 idx))
        nil))


(defn capture-declares [path] 
    (def *capture* @{})
    (defn append-capture [name & arg]
      (update *capture* name (fn [val] (array/push (or val @[]) ;arg))))

    (defn only-captures [form] 
      (when (string/has-prefix? "declare-" (string (form 0)))
        (append-capture (form 0) (slice form 1))
        form)
      nil)
    (dofile path :expander only-captures)
    *capture*)

(each r (os/dir "repos")
  (when (has-project.janet? r)
    (def *capture* @{})
    (defn append-capture [name & arg]
      (update *capture* name (fn [val] (array/push (or val @[]) ;arg))))

    (defn only-captures [form] 
      (when (string/has-prefix? "declare-" (string (form 0)))
        (append-capture (form 0) (slice form 1))
        form)
      nil)
    (dofile (project-path r) :expander only-captures)
    
    (pp (struct ;(tracev (get-in *capture* ['declare-project 0]))))
    ))

