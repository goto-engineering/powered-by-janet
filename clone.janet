(import sh)

(use ./packages)

(defn ensure-dir []
  (let [repos-stat (os/stat "repos")]
    (when (not (= :directory (get repos-stat :mode)))
      (os/mkdir "repos"))))

# Should do `git pull` if repo already exists, not no-op
(defn clone-repo [url]
  (let [status (os/execute @("git" "clone" "--depth" "1" url) :p)]
    (case status
      0 (print "Success!")
      128 (print "Repo already cloned.")
      (print "Failed with status code: " status))))

(defn download-all []
  (ensure-dir)
  (os/cd "repos")
  (os/setenv "GIT_TERMINAL_PROMPT" "0")
  (each url packages
    (clone-repo url)))


(comment
  (ensure-dir)
  (clone-repo "https://github.com/sepisoad/jurl.git")
  (download-all)
  (os/cwd)
  (os/dir ".")
  (os/stat "repos")
  (os/cd ".."))
