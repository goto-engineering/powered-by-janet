(import janet-html :as h)

(import ./sherlock)
(import ./util)


(defn- page [includes & content]
  (h/html
    (h/doctype :html5)
    [:html {:lang "en-US"}
     [:head
      [:meta {:charset "UTF-8"}]
      [:title "Powered by Janet"]
      ;includes
      [:body 
       [:div.content
        content]]]]))

(defn- header []
   (def home "https://goto-engineering.github.io/powered-by-janet/")
  [:div.header 
   [:a {:href home} [:div.title  "Powered by Janet"]]
   [:div.subtitle  ["A collection of all things written in "]
    [:a {:href "https://janet-lang.org"} "Janet"]]])

(defn- search [num-pkgs]
  [:div.search
   [:div.background-content. "Currently showing " [:span {:id "package-count"} num-pkgs] " repositories"]
   [:input {:id "search-box" :name "search-box" :type "text" :autofocus "autofocus" :placeholder "Search.."}]
   ])

# TODO: don't show empty values,
(defn- index-item [repo-name metadata]
  [:li
   [:div.package
    [:div.left
     [:p.title
      [:a {:href (string "package/" repo-name ".html")} (metadata :name)]
      [:p.description (or (metadata :description) "No description")]]]
    [:div.right
     (when (metadata :author) [:div.detail
      [:div.top "Author"]
      [:div.bottom {:title (metadata :author)} (metadata :author)]])
     (when (metadata :license) [:div.detail
      [:div.top "License"]
      [:div.bottom (metadata :license)]])]]])

(defn- submit-package []
  [:div.submit-package
   [:a {:href "https://github.com/goto-engineering/powered-by-janet/pulls" :target "blank"}
    [:div "Know a Janet package that's missing? Submit a PR to add it!"]]])

# TODO: show count
(defn generate-index [metadata]
  (page [[:link {:rel "stylesheet" :href "common.css"}]
         [:link {:rel "stylesheet" :href "index.css"}]
         [:script {:type "text/javascript" :src "script.js"}]]
        (header)
        (submit-package)
        (search (length metadata))
        [:ul.package-list
         (map |[(index-item $ (metadata $)) "\n"] (keys metadata))]))

(defn generate-detail [metadata]
  (page [[:link {:rel "stylesheet" :href "../common.css"}]
         [:link {:rel "stylesheet" :href "../detail.css"}]]
        (header)
        [:div.package
         [:h1.title (metadata :name)]
         [:p.description (or (metadata :description) "No description")]
         [:p.author "Author: " (metadata :author)]
         [:p.license "License: " (metadata :license)]
         [:p.url "URL: " [:a {:href (metadata :url)} (metadata :url)]]
         [:p.url "Last commit: " (metadata :last-commit)]]))

# TODO: use `pairs`
(defn generate-details [metadata]
  (map (fn [key] [key (generate-detail (metadata key))]) (keys metadata)))

(defn generate-all! []
  (let [metadata (sherlock/all-metadata)
        index (generate-index metadata)
        details (generate-details metadata)]
    (util/ensure-dir "docs/package") 
    (util/save-to-file index "docs/index.html")
    (each [filename content] details
      (ev/spawn
        (util/save-to-file content (string "docs/package/" (string filename ".html")))))))

(defn main [&]
  (generate-all!))

(comment
  (generate-all!))
