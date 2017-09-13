{:user {:dependencies [[pjstadig/humane-test-output "0.8.2"]
                       [slamhound "1.5.5"]
                       ]

        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)
                     ]
        :plugins [[cider/cider-nrepl "0.15.0"]
                  [com.jakemccrary/lein-test-refresh "0.20.0"]
                  [lein-cloverage "1.0.9"]
                  [lein-kibit "0.1.5"]
                  [jonase/eastwood "0.2.4"]
                  [lein-ancient "0.6.10"]
                  [lein-bikeshed "0.4.1"]
                  [venantius/yagni "0.1.4"]
                  ]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]
                  "codecheck" ["do" ["clean"] ["with-profile" "production" "deps" ":tree"] ["ancient"] ["kibit"] ["eastwood"] ["cloverage"] ]
                  "codecheck-extended" ["do" ["clean"] ["with-profile" "production" "deps" ":tree"] ["ancient"] ["kibit"] ["eastwood"] ["cloverage"] ["bikeshed"] ["yagni"] ]
                  }


        :test-refresh {; https://github.com/jakemcc/lein-test-refresh/blob/master/sample.project.clj
                       :notify-command ["notify-send" "-c" "clojure.test" "-a" "test-refresh" "-t" "1000" "-u" "low" "clj-test-refresh"]
                       :growl false
                       :notify-on-success true
                       :quiet true
                       :changes-only true
                       :stack-trace-depth nil
                       :watch-dirs ["src" "test"]
                       :refresh-dirs ["src" "test"]}
        }}
