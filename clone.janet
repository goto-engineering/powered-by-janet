(use ./packages)

(defn ensure-dir []
  (match (os/stat "repos")
    nil (os/mkdir "repos")
    {:mode :directory} nil
    _ (error `"repos" exists and is not a directory!`)))

# TODO: Do `git pull` if repo already exists, not no-op
# TODO: Clone into fully qualified folders, there might be name collisions 
(defn clone-repo [url]
  (let [status (:wait (os/spawn @("git" "clone" "--depth" "1" url) :p))]
    (case status
      0 (eprint "Success!")
      128 (eprint "Repo already cloned.")
      (eprint "Failed with status code: " status))))

(defn download-all []
  (ensure-dir)
  (os/cd "repos")
  (os/setenv "GIT_TERMINAL_PROMPT" "0")
  (each url packages
    (clone-repo url)))

(defn main [&] 
  (download-all))


(comment
  (ensure-dir)
  (clone-repo "https://github.com/sepisoad/jurl.git")
  (download-all)
  (os/cwd)
  (os/dir ".")
  (os/stat "repos")
  (os/cd ".."))
