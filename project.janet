(declare-project
  :name "powered-by-janet"
  :description "A collection of all things written in Janet"
  :license "MIT"
  :url "https://github.com/goto-engineering/powered-by-janet"
  :repo "https://github.com/goto-engineering/powered-by-janet.git"
  :dependencies ["https://github.com/janet-lang/spork.git"
                 "https://github.com/swlkr/janet-html.git"])

(import ./clone)
(phony "clone" []
       (clone/download-all))

(import ./generate-html)
(phony "generate-html" []
       (generate-html/generate-all!))
