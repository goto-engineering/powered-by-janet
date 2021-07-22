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


(each r (os/dir "repos")
  (when (has-project.janet? r)
    (def proj-env (dofile (project-path r) :env (load-jpm-env)))
    (def proj-decls (get-in proj-env ['*capture* :value]))
    # Data is a bit awkward atm.
    (when (> (length (proj-decls 'declare-project)) 1)
      (pp (proj-decls 'declare-project))
      (eprint "More than one declare-project call in " r "!"))
    (def proj-call (get-in proj-env ['*capture* :value 'declare-project 0 0]))
    (pp [r (get-kv proj-call :name)])
    ))

