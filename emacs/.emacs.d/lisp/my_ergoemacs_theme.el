(ergoemacs-theme my-theme ()
  "my Ergoemacs Theme"
  :components '(copy
                dired-tab
                dired-to-wdired
                execute
                fixed-newline
                help
                kill-line
                misc
                move-bracket
                move-buffer
                move-char
                move-line
                ; move-page <-- disabled since I want C-M-i
                move-paragraph
                move-word
                search
                select-items
                switch
                text-transform
                ergoemacs-remaps
                standard-vars)
  :optional-on '(apps-punctuation
                 tab-indents-region
                 icy-reclaim
                 apps-apps
                 apps-toggle
                 apps
                 backspace-del-seq
                 backspace-is-back
                 fn-keys
                 f2-edit
                 fixed-bold-italic
                 standard-fixed
                 ido-remaps
                 helm-remaps
                 helm-find-files
                 multiple-cursors-remaps
                 quit
                 apps-swap
                 ;;save-options-on-exit
                 ;; Reverse menu-bar order
                 menu-bar-help
                 menu-bar-languages
                 menu-bar-view
                 menu-bar-search
                 menu-bar-edit
                 menu-bar-file
                 mode-line-major-mode-switch
                 )
  :optional-off '(guru
                  alt-backspace-is-undo
                  search-reg
                  no-backspace
                  helm-switch-sources
                  ergoemacs-banish-shift
                  move-and-transpose-lines
                  move-sexp
                  ido-prev-next-instead-of-left-right
                  join-line
                  save-options-on-exit
                  isearch-arrows
                  ergoemacs-swiper)
  :options-menu '(("Menu/Apps Key" (apps apps-apps apps-punctuation apps-toggle))
                  ("Function Keys" (fn-keys f2-edit))
                  ("Helm Options" (helm-switch-sources helm-find-files))
                  ("Remaps" (ido-remaps helm-remaps multiple-cursors-remaps icy-reclaim ergoemacs-swiper))
                  ("Extreme ErgoEmacs" (guru no-backspace ergoemacs-banish-shift))
                  ("Standard Keys" (standard-fixed fixed-bold-italic quit move-and-transpose-lines alt-backspace-is-undo))
                  ("Keys during Key Sequence" (f2-edit apps-swap backspace-del-seq))
                  ("Disputed Keys" (ido-prev-next-instead-of-left-right move-sexp))
                  ("Extra Functionality" (join-line isearch-arrows))
                  ("Packages" (avy multiple-cursors expand-region))
                  ("Mode Line" (mode-line-major-mode-switch))
                  ("Ergoemacs global menus" (menu-bar-file menu-bar-edit menu-bar-search menu-bar-view menu-bar-languages menu-bar-help))))
