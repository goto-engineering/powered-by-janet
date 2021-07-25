(import ./util)

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
      (pp project-meta)
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

# try using jpm/pm/require-jpm instead of `parse` once bakpakin pushes the necessariy Janet version
(defn metadata-for-repo [repo]
  (-> 
    (string "repos/" repo "/project.janet")
    capture-declares
    (sanitize-metadata repo)))

(defn all-metadata []
  (reduce
    (fn [acc repo]
      (let [metadata (metadata-for-repo repo)]
        (put acc repo metadata)))
    @{}
    (list-janet-projects has-project.janet?)))

(defn names-and-descriptions []
  (map (fn [metadata] {:name (metadata :name) :description (metadata :description)}) (values (all-metadata))))

(comment 
  (os/cd "..")
  (os/cwd)
  (metadata-for-repo "mago") # works
  (metadata-for-repo "janet-brew-ls") # metadata broken
  (all-metadata)
  (names-and-descriptions)
  (util/save-to-file (string/format "%j" (all-metadata)) "metadata.txt")
  (list-janet-projects has-project.janet?)
  (list-janet-projects lacks-any-janet-files?)
  (list-janet-projects lacks-project.janet?))
