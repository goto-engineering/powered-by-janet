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


(defn ev/par-each [items f &keys {:dop dop}]
  (def sup-chan (ev/chan))
  (each i (range dop)
    (ev/go (fiber/new |(f (items i)) :tep) nil sup-chan))
  (each item (slice items dop)
    (pp item)
    (def [status fib] (ev/take sup-chan))
    (unless (= status :ok)
      (propagate (fiber/last-value fib) fib))
    (ev/go (fiber/new |(f item) :tep) nil sup-chan)))

(defn download-all []
  (util/ensure-dir "repos")
  (os/cd "repos")
  (os/setenv "GIT_TERMINAL_PROMPT" "0")
  (def start (os/time))
  (ev/par-each packages/packages |(clone-repo $) :dop 4)
  (def end (os/time))
  (print "It took" (- end start) " seconds to clone"))

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
