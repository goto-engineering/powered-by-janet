(import ./packages)
(import ./util)
(import spork/path)

(defn update-repo [repo-root repo-name]
  (os/cd (path/join repo-root repo-name))
  (let [status (:wait (os/spawn @("git" "pull") :p))]
    (case status
      0 :noop
      (eprint "Failed 'git pull' with status code: " status " for repo: " repo-name))))

(defn clone-repo [repo-root url]
  (let [repo-name (util/strip-repo-url url)
        _ (os/cd repo-root)
        status (:wait (os/spawn @("git" "clone" "--depth" "1" url repo-name) :p))]
    (case status
      0 :noop
      128 (update-repo repo-root repo-name)
      (eprint "Failed 'git clone' with status code: " status " for repo: " url))))


(defn ev/par-each [items f &keys {:dop dop}]
  (default dop 2)
  (def dop (min (length items) dop))
  (def sup-chan (ev/chan)) 
  (each i (range dop)
    (def item (items i))
    (ev/go (fiber/new |(f item) :tep) nil sup-chan))
  (each item (slice items dop)
    (def [status fib] (ev/take sup-chan))
    (unless (= status :ok)
      (propagate (fiber/last-value fib) fib))
    (ev/go (fiber/new |(f item) :tep) nil sup-chan)))

(defn download-all []
  (util/ensure-dir "repos")
  (os/cd "repos")
  (def repo-root (path/abspath (os/cwd)))
  (os/setenv "GIT_TERMINAL_PROMPT" "0")
  (def start (os/time))
  (ev/par-each packages/packages |(clone-repo repo-root $) :dop 10)
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
