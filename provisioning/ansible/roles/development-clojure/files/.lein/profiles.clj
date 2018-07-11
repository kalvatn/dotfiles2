{:user {:dependencies [[pjstadig/humane-test-output "0.8.3"]
                       [slamhound "1.5.5"]
                       [clj-stacktrace "0.2.8"]
                       ]

        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)
                     ]
        :plugins [[cider/cider-nrepl "0.17.0"]
                  [com.jakemccrary/lein-test-refresh "0.22.0"]
                  [lein-cloverage "1.0.11"]
                  [lein-kibit "0.1.6"]
                  [jonase/eastwood "0.2.7"]
                  [lein-ancient "0.6.15"]
                  [lein-bikeshed "0.5.1"]
                  [venantius/yagni "0.1.4"]
                  [lein-gen "0.2.2"]]
        :generators [[lein-gen/generators "0.2.1"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]
                  "codecheck" ["do" ["clean"] ["with-profile" "production" "deps" ":tree"] ["ancient"] ["kibit"] ["eastwood"] ["cloverage"] ]
                  "codecheck-extended" ["do" ["clean"] ["with-profile" "production" "deps" ":tree"] ["ancient"] ["kibit"] ["eastwood"] ["cloverage"] ["bikeshed"] ["yagni"] ]
                  }
        :jvm-opts ["-Xmx1G"]
        :repl-options {
                       :caught clj-stacktrace.repl/pst+}
        :test-refresh {; https://github.com/jakemcc/lein-test-refresh/blob/master/sample.project.clj
                       :notify-command ["notify-send" "-c" "clojure.test" "-a" "test-refresh" "-t" "1000" "-u" "low" "clj-test-refresh"]
                       :growl false
                       :jvm-opts ["-Xmx1G"]
                       :notify-on-success true
                       :quiet true
                       :changes-only true
                       :stack-trace-depth nil
                       :watch-dirs ["src" "test"]
                       :refresh-dirs ["src" "test"]}
        }}
