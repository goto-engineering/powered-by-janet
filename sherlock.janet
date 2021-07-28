(import ./util)
(import ./packages)

(defn run
  "Runs a command and returns the stdout"
  [& commands]
  (def p (os/spawn commands :p {:in :pipe :out :pipe}))
  (let [output (:read (p :out) :all)]
    (:wait p)
    output))

(defn has-project.janet? [repo]
  (truthy? (os/stat (string repo "/project.janet"))))

(defn lacks-project.janet? [repo]
  (not (has-project.janet? repo)))

(defn lacks-any-janet-files? [repo]
  (nil? (run "fd" ".janet" repo)))

(defn has-any-janet-files? [repo]
  (not (lacks-any-janet-files? repo)))

(defn list-janet-projects [prd]
  (os/cd "repos")
  (let [repos (os/dir ".")
        results (filter prd repos)]
    (os/cd "..")
    results))

(defn sanitize-metadata
  """
  Some projects have invalid project metadata
  """
  [captures repo]

  (def project-meta (get-in captures ['declare-project 0]))
  (if (even? (length project-meta))
    (struct ;project-meta)
    (do 
      (print "Invalid declare-project for '" repo "'"))))

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

(defn project-data-for-repo [repo]
  (-> 
    (string "repos/" repo "/project.janet")
    capture-declares
    (sanitize-metadata repo)))

(defn last-commit-date-for-repo [repo-name]
  (os/cd (string "repos/" repo-name))
  (let [result (string/trim (run "git" "show" "-s" "--format=%cr"))]
    (os/cd "../..")
    result))

(defn all-metadata []
  (reduce
    (fn [acc repo]
      (let [project-data (project-data-for-repo repo)]
        (def metadata (if (not (nil? project-data))
          (put (table ;(kvs project-data)) :last-commit (last-commit-date-for-repo repo))))
        (put acc repo metadata)))
    @{}
    (list-janet-projects has-project.janet?)))

(defn names-and-descriptions []
  (map (fn [metadata] {:name (metadata :name) :description (metadata :description)}) (values (all-metadata))))

(defn deps-for-repo [repo]
  ((project-data-for-repo repo) :dependencies))

(defn sanitize-repo-name [repo]
  (if (struct? repo)
    (sanitize-repo-name (repo :repo))
    (string/replace ".git" "" repo)))

(defn all-deps-from-all-repos []
  (map sanitize-repo-name (filter |(not (nil? $)) (flatten (map |($ :dependencies) (all-metadata))))))

(defn missing-deps []
  (distinct (filter |(nil? (index-of $ packages/packages)) (all-deps-from-all-repos))))

(comment 
  (os/cd "..")
  (os/cwd)
  (project-data-for-repo "git.sr.ht-~subsetpark-mago") # works
  (project-data-for-repo "github.com-heycalmdown-janet-brew-ls") # metadata broken
  (all-metadata)
  (last-commit-date-for-repo "git.sr.ht-~subsetpark-mago")
  (deps-for-repo "github.com-heycalmdown-janet-whooing-helper")
  (all-deps-from-all-repos)
  (missing-deps)
  (names-and-descriptions)
  (util/save-to-file (string/format "%j" (all-metadata)) "metadata.txt")
  (list-janet-projects has-project.janet?)
  (list-janet-projects lacks-any-janet-files?)
  (list-janet-projects lacks-project.janet?))
