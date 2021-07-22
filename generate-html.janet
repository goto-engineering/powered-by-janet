(import janet-html :as h)

(import ./sherlock)
(import ./util)


(defn- page [& content]
  [:html {:lang "en-US"}
   [:head
    [:meta {:charset "UTF-8"}]
    [:title "Powered by Janet"]
    [:link {:rel "stylesheet" :href "style.css"}]
    [:script {:type "text/javascript" :src "script.js"}]]
   [:body 
    [:div.content
     content]]])

(defn- header [package-count]
  [:div.header 
   [:div.title  "Powered by Janet"]
   [:div.subtitle  "A collection of all (" package-count ") things written in "
    [:a {:href "https://janet-lang.org"} "Janet"]]])

(defn- search []
  [:div.search
   [:input {:id "search-box" :type "text" :autofocus "autofocus" :placeholder "Search.."}]])

(defn- list-item [metadata]
  [:li
   [:div.package
    [:p.title (metadata :name)]
    [:p.description (or (metadata :description) "No description")]
    [:p.author "Author: " (metadata :author)]
    [:p.license "License: " (metadata :license)]
    [:p.url "URL: " [:a {:href (metadata :url)} (metadata :url)]]
    [:p.repo "Repo: " (metadata :repo)]]])

(defn- submit-package []
  [:div.submit-package
   [:a {:href "https://github.com/goto-engineering/powered-by-janet/pulls" :target "blank"}
    [:div "Know a Janet package that's missing? Submit a PR to add it!"]]])

(defn generate-index [metadata]
  (h/html
    (h/doctype :html5)
    (page
      (header (length metadata))
      (submit-package)
      (search)
      [:ul.package-list
       (map list-item metadata)])))

(defn generate-all! []
  (let [metadata (sherlock/all-metadata)
        index (generate-index metadata)]
    (util/save-to-file index "index.html")))

(comment
  (generate-all!))
