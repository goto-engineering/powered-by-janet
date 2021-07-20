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
  Some projects don't have the declare-project form first,
  which breaks `parse`, others have invalid stuff e.g. in
  their dependencies.

  This should prevent crashing when the project.janet has
  an unexpected shape.
  """
  [form repo]

  (if (= (first form) 'declare-project)
    (let [metadata (tuple/slice form 1)]
      (if (even? (length metadata))
        (struct ;metadata)
        (print "Metadata malformed for repo '" repo "'")))
    (print "Cannot parse 'project.janet' in repo '" repo "'")))

# try using jpm/pm/require-jpm instead of `parse` once bakpakin pushes the necessariy Janet version
(defn metadata-for-repo [repo]
  (-> 
    (string "repos/" repo "/project.janet")
    slurp
    parse
    (sanitize-metadata repo)))

(defn all-metadata []
  (reduce
    (fn [acc repo]
      (let [metadata (metadata-for-repo repo)]
        (put acc repo metadata)))
    @{}
    (list-janet-projects has-project.janet?)))

(defn save-to-file [data filename]
  (def f (file/open filename :w))
  (file/write f data)
  (file/flush f)
  (file/close f))

(defn names-and-descriptions []
  (map (fn [{:name name :description description}] (string name " - " description)) (values (all-metadata))))

(comment 
  (os/cd "..")
  (os/cwd)
  (metadata-for-repo "mago") # works
  (metadata-for-repo "janet-brew-ls") # metadata broken
  (all-metadata)
  (names-and-descriptions)
  (save-to-file (string/format "%j" (all-metadata)) "metadata.txt")
  (list-janet-projects has-project.janet?)
  (list-janet-projects lacks-any-janet-files?)
  (list-janet-projects lacks-project.janet?))
