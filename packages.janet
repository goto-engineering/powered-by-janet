(def packages
  ["https://git.sr.ht/~bakpakin/temple"
   "https://git.sr.ht/~icylisper/janet-lambda-runtime"
   "https://git.sr.ht/~pepe/andy"
   "https://git.sr.ht/~pepe/chidi"
   "https://git.sr.ht/~pepe/eleanor"
   "https://git.sr.ht/~pepe/good-place"
   "https://git.sr.ht/~pepe/kamilah"
   "https://git.sr.ht/~pepe/michael"
   "https://git.sr.ht/~pepe/neil"
   "https://git.sr.ht/~pepe/shawn"
   "https://git.sr.ht/~pepe/trevor"
   "https://git.sr.ht/~skuzzymiglet/typeup-janet"
   "https://git.sr.ht/~statianzo/janet-nanoid"
   "https://git.sr.ht/~subsetpark/bagatto"
   "https://git.sr.ht/~subsetpark/ec"
   "https://git.sr.ht/~subsetpark/fugue"
   "https://git.sr.ht/~subsetpark/janet-rl"
   "https://git.sr.ht/~subsetpark/mago"
   "https://git.sr.ht/~subsetpark/the-brzozowski-variations"
   "https://git.sr.ht/~subsetpark/whist"
   "https://github.com/AlecTroemel/junk-drawer"
   "https://github.com/AlecTroemel/phalanx-core"
   "https://github.com/Alligator/termbox-janet"
   "https://github.com/Duncaen/adventofcode-janet"
   "https://github.com/Duncaen/dhall-janet"
   "https://github.com/GrayJack/Advent-Of-Code"
   "https://github.com/GrayJack/janet-str-ext"
   "https://github.com/GrayJack/rust-janet-module-template"
   "https://github.com/LeviSchuck/janet-sigv4"
   "https://github.com/LeviSchuck/janetjose"
   "https://github.com/LeviSchuck/janetls"
   "https://github.com/LouisJackman/janet-hypertext"
   "https://github.com/Luewd/otable"
   "https://github.com/MikeBeller/janet-abstract"
   "https://github.com/MikeBeller/janet-benchmarksgame"
   "https://github.com/MikeBeller/janet-set"
   "https://github.com/PaulBatchelor/junt"
   "https://github.com/PaulBatchelor/weewiki"
   "https://github.com/Putnam3145/janet-d"
   "https://github.com/Ruin0x11/janet-shiori"
   "https://github.com/Saikyun/janet-binary-search-comparison"
   "https://github.com/Saikyun/janet-find-in-files"
   "https://github.com/Saikyun/janet-namespaces"
   "https://github.com/Saikyun/janet-profiling"
   "https://github.com/Saikyun/janet-whereami"
   "https://github.com/Saikyun/freja"
   "https://github.com/ahungry/ahungry-janet"
   "https://github.com/ahungry/ahungry-janet-to-js"
   "https://github.com/ahungry/ahungry-janet-user"
   "https://github.com/ahungry/com.ahungry.crypt.jwt"
   "https://github.com/ahungry/emscripten-tinkering"
   "https://github.com/ahungry/janet-android"
   "https://github.com/ahungry/janet-code"
   "https://github.com/ahungry/janet-p99-map"
   "https://github.com/ahungry/janet-pobox"
   "https://github.com/ahungry/janet-xbuild"
   "https://github.com/ahungry/puny-gui"
   "https://github.com/ahungry/puny-server"
   "https://github.com/andrewchambers/h"
   "https://github.com/andrewchambers/hermes"
   "https://github.com/andrewchambers/hm"
   "https://github.com/andrewchambers/hpkg"
   "https://github.com/andrewchambers/janet-ahttp"
   "https://github.com/andrewchambers/janet-bare1"
   "https://github.com/andrewchambers/janet-base16"
   "https://github.com/andrewchambers/janet-big"
   "https://github.com/andrewchambers/janet-cloader"
   "https://github.com/andrewchambers/janet-flock"
   "https://github.com/andrewchambers/janet-fork"
   "https://github.com/andrewchambers/janet-httpkit"
   "https://github.com/andrewchambers/janet-jcjit"
   "https://github.com/andrewchambers/janet-jdn"
   "https://github.com/andrewchambers/janet-logfmt"
   "https://github.com/andrewchambers/janet-md-doc"
   "https://github.com/andrewchambers/janet-pgjobq"
   "https://github.com/andrewchambers/janet-pgmigrate"
   "https://github.com/andrewchambers/janet-pico-http-parser"
   "https://github.com/andrewchambers/janet-posix-spawn"
   "https://github.com/andrewchambers/janet-pq"
   "https://github.com/andrewchambers/janet-process"
   "https://github.com/andrewchambers/janet-redis"
   "https://github.com/andrewchambers/janet-redo"
   "https://github.com/andrewchambers/janet-rlrepl"
   "https://github.com/andrewchambers/janet-sh"
   "https://github.com/andrewchambers/janet-shlex"
   "https://github.com/andrewchambers/janet-tmppg"
   "https://github.com/andrewchambers/janet-unify"
   "https://github.com/andrewchambers/janet-uri"
   "https://github.com/andrewchambers/janet-utf8"
   "https://github.com/andrewchambers/janet-where-defined"
   "https://github.com/andrewchambers/janet-xcore"
   "https://github.com/andrewchambers/janetsh"
   "https://github.com/andrewchambers/jfmt"
   "https://github.com/andrewchambers/jpm-to-hermes"
   "https://github.com/andrewchambers/plumbtool"
   "https://github.com/andrewchambers/poolparty"
   "https://github.com/bakpakin/janet-miniz"
   "https://github.com/bakpakin/jurl"
   "https://github.com/bakpakin/littleserver"
   "https://github.com/bakpakin/mendoza"
   "https://github.com/bakpakin/x43bot"
   "https://github.com/swlkr/janet-html"
   "https://github.com/brandonchartier/janet-html"
   "https://github.com/brandonchartier/janet-irc-client"
   "https://github.com/brandonchartier/janet-queue"
   "https://github.com/brandonchartier/janet-url"
   "https://github.com/brandonchartier/janet-uuid"
   "https://github.com/brandonchartier/jobot"
   "https://github.com/ceigey/textgame-janet-protoype"
   "https://github.com/cellularmitosis/janet-lzo"
   "https://github.com/cmiles74/bencode"
   "https://github.com/coast-framework/coast-cli"
   "https://github.com/crocket/buku-fzf"
   "https://github.com/crocket/janet-repl-tools"
   "https://github.com/crocket/janet-utf8"
   "https://github.com/crocket/janet-xmrig"
   "https://github.com/crocket/simple-dosbox-launcher"
   "https://github.com/dabeaz/ranet"
   "https://github.com/dalygbarron/kowari"
   "https://github.com/dalygbarron/pingo"
   "https://github.com/dfuenzalida/janet-hello-world"
   "https://github.com/dracconi/yanka"
   "https://github.com/felixr/janet-benchmarks"
   "https://github.com/good-place/chidi"
   "https://github.com/good-place/mansion"
   "https://github.com/good-place/neil"
   "https://github.com/good-place/shawn"
   "https://github.com/good-place/tahani"
   "https://github.com/good-place/trolley"
   "https://github.com/goto-engineering/blackjack"
   "https://github.com/goto-engineering/jack"
   "https://github.com/heycalmdown/janet-brew-ls"
   "https://github.com/heycalmdown/janet-notion-helper"
   "https://github.com/heycalmdown/janet-whooing-helper"
   "https://github.com/ikarius/bencode"
   # "https://github.com/inchingforward/pw"
   "https://github.com/janet-lang/argparse"
   "https://github.com/janet-lang/circlet"
   "https://github.com/janet-lang/janet"
   "https://github.com/janet-lang/janetui"
   "https://github.com/janet-lang/jaylib"
   "https://github.com/janet-lang/jhydro"
   "https://github.com/janet-lang/jpm"
   "https://github.com/janet-lang/json"
   "https://github.com/janet-lang/juv"
   "https://github.com/janet-lang/path"
   "https://github.com/janet-lang/pkgs"
   "https://github.com/janet-lang/spork"
   "https://github.com/janet-lang/sqlite3"
   "https://github.com/janet-lang/tarray"
   "https://github.com/janet-lang/webview"
   "https://github.com/jcpsantiago/hazal"
   "https://github.com/jeannekamikaze/janet-filesystem"
   "https://github.com/jeannekamikaze/webgen"
   "https://github.com/jfcap/janet-luajit"
   "https://github.com/joy-framework/bundler"
   "https://github.com/joy-framework/cipher"
   "https://github.com/joy-framework/codec"
   "https://github.com/joy-framework/db"
   "https://github.com/joy-framework/dotenv"
   "https://github.com/joy-framework/example-todos"
   "https://github.com/joy-framework/halo"
   "https://github.com/joy-framework/halo2"
   "https://github.com/joy-framework/http"
   "https://github.com/joy-framework/joy"
   "https://github.com/joy-framework/joy-framework.github.io"
   "https://github.com/joy-framework/joyframework.com"
   "https://github.com/joy-framework/json-api-example"
   "https://github.com/joy-framework/moondown"
   "https://github.com/joy-framework/suresql"
   "https://github.com/joy-framework/tester"
   "https://github.com/joy-framework/uuid"
   "https://github.com/katafrakt/isjanetthereyet"
   "https://github.com/kixus/mycom-mygreetlib"
   "https://github.com/kongeor/skolio"
   "https://github.com/leahneukirchen/literate-janet"
   "https://github.com/levitanong/jdn-loader"
   "https://github.com/levitanong/teller"
   "https://github.com/nate/isatty"
   "https://github.com/nate/janet-sequence-cursor"
   "https://github.com/nate/pull-all"
   "https://github.com/newhook/janet-mysql"
   "https://github.com/pauldub/janet-http-client"
   "https://github.com/pepe/chidi"
   "https://github.com/pepe/janet-playground"
   "https://github.com/pepe/jesty"
   "https://github.com/pepe/jff"
   "https://github.com/pepe/tahani"
   "https://github.com/pepe/trolley"
   "https://github.com/pingiun/jequests"
   "https://github.com/pyrmont/advent"
   "https://github.com/pyrmont/bencodobi"
   "https://github.com/pyrmont/claret"
   "https://github.com/pyrmont/documentarian"
   "https://github.com/pyrmont/ecstatic"
   "https://github.com/pyrmont/hello-janet"
   "https://github.com/pyrmont/heroku-buildpack-janet"
   "https://github.com/pyrmont/markable"
   "https://github.com/pyrmont/musty"
   "https://github.com/pyrmont/outfool"
   "https://github.com/pyrmont/persimmon"
   "https://github.com/pyrmont/remarkable"
   "https://github.com/pyrmont/settee"
   "https://github.com/pyrmont/testament"
   "https://github.com/pyrmont/tomlin"
   "https://github.com/pyrmont/watchful"
   "https://github.com/quan-nh/sync-run"
   "https://github.com/quexxon/advent-of-code-2019"
   "https://github.com/rduplain/hosts"
   "https://github.com/roobie/crankshaft"
   "https://github.com/roobie/maybe"
   "https://github.com/roobie/redis"
   "https://github.com/roobie/sumtype"
   "https://github.com/runejuhl/toggle-leds"
   "https://github.com/scotthaleen/jhttp"
   "https://github.com/sepisoad/jtbox"
   "https://github.com/sepisoad/jurl"
   "https://github.com/sepisoad/labgoo"
   "https://github.com/sepisoad/super-janet-typist"
   "https://github.com/sevanteri/janet-secret"
   "https://github.com/sevanteri/jopass"
   "https://github.com/sogaiu/c-from-janet"
   "https://github.com/sogaiu/clojure-peg"
   "https://github.com/sogaiu/detect-clj-ns"
   "https://github.com/sogaiu/janet-bits"
   "https://github.com/sogaiu/janet-pcg-random"
   "https://github.com/sogaiu/janet-peg"
   "https://github.com/sogaiu/janet-socket-repl"
   "https://github.com/sogaiu/janet-walk-dir"
   "https://github.com/sogaiu/janet-xmlish"
   "https://github.com/sogaiu/janet-zip"
   "https://github.com/sogaiu/judge-gen"
   "https://github.com/sogaiu/mal-peg"
   "https://github.com/sogaiu/pin-src"
   "https://github.com/sogaiu/pod-janet-peg"
   "https://github.com/sorenbug/sys-script"
   "https://github.com/staab/budgetless"
   "https://github.com/staab/esv"
   "https://github.com/staab/janet-assert"
   "https://github.com/staab/janet-cache"
   "https://github.com/staab/janet-js"
   "https://github.com/staab/janet-multimethod"
   "https://github.com/staab/janet-pqutils"
   "https://github.com/staab/janet-pseudo-set"
   "https://github.com/staab/janet-schema"
   "https://github.com/staab/janet-util"
   "https://github.com/subsetpark/janet-cells"
   "https://github.com/subsetpark/janet-dtgb"
   "https://github.com/swlkr/askjanet"
   "https://github.com/swlkr/janetdocs"
   "https://github.com/swlkr/osprey"
   "https://github.com/swlkr/patter"
   "https://github.com/swlkr/speakeasy"
   "https://github.com/sysread/skewheap-janet"
   "https://github.com/tami5/denv"
   "https://github.com/yumaikas/anno"
   "https://github.com/yumaikas/anno-server"
   "https://github.com/yumaikas/cartnet"
   "https://github.com/yumaikas/praxis"
   "https://github.com/yumaikas/eye"
   "https://github.com/yumaikas/janet-errs"
   "https://github.com/yumaikas/janet-globals"
   "https://github.com/yumaikas/janet-stringx"
   "https://github.com/yumaikas/janitor"
   "https://github.com/yumaikas/newt"
   "https://github.com/zenlor/janet-csv"
   "https://github.com/zenlor/links"
   "https://gitlab.com/croquet/jddclient"
   "https://gitlab.com/louis.jackman/janet-hypertext"])
