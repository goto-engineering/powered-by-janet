(defn run
  """
  Runs a command and returns the stdout
  """
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

(comment 
  (os/cd "..")
  (os/cwd)
  (list-janet-projects lacks-any-janet-files?)
  (list-janet-projects lacks-project.janet?))
