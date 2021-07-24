(import ./packages)
(import ./util)

(defn update-repo [repo-name]
  (os/cd repo-name)
  (let [status (:wait (os/spawn @("git" "pull") :p))]
    (os/cd "..")
    (case status
      0 :noop
      (eprint "Failed 'git pull' with status code: " status " for repo: " repo-name))))

(defn clone-repo [url]
  (let [repo-name (util/strip-repo-url url)
        status (:wait (os/spawn @("git" "clone" "--depth" "1" url repo-name) :p))]
    (case status
      0 :noop
      128 (update-repo repo-name)
      (eprint "Failed 'git clone' with status code: " status " for repo: " url))))

(defn download-all []
  (util/ensure-dir "repos")
  (os/cd "repos")
  (os/setenv "GIT_TERMINAL_PROMPT" "0")
  (each url packages/packages
    (clone-repo url)))

(defn main [&] 
  (download-all))


(comment
  (util/ensure-dir "repos")
  (clone-repo "https://github.com/sepisoad/jurl.git")
  (download-all)
  (os/cwd)
  (os/dir ".")
  (os/stat "repos")
  (os/cd ".."))
