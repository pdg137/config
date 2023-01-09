(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(c-offsets-alist '((substatement-open . 0)))
 '(completion-ignored-extensions
   '(".o" "~" ".bin" ".obj" ".map" ".ico" ".pif" ".lnk" ".a" ".ln" ".blg" ".bbl" ".dll" ".drv" ".vxd" ".386" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
 '(css-indent-offset 2)
 '(custom-enabled-themes '(sanityinc-solarized-dark))
 '(custom-safe-themes
   '("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "7392f213ece957a89580293fb7976359b33d5afd17709a3add22e098c19552a9" "cf3e206f8fe53354921a492fb58eee2efffef3251032387752f725c789f612ff" default))
 '(delete-selection-mode t)
 '(display-time-mode t)
 '(ergoemacs-ctl-c-or-ctl-x-delay 0.2)
 '(ergoemacs-default-cursor-color "violet red")
 '(ergoemacs-handle-ctl-c-or-ctl-x 'both)
 '(ergoemacs-ini-mode t)
 '(ergoemacs-keyboard-layout "us")
 '(ergoemacs-mode nil)
 '(ergoemacs-mode-used "5.13.11")
 '(ergoemacs-smart-paste nil)
 '(ergoemacs-theme 'my_ergoemacs_theme)
 '(ergoemacs-theme-options '((save-options-on-exit off)))
 '(ergoemacs-use-menus t)
 '(fci-rule-color "#073642")
 '(frame-background-mode 'dark)
 '(global-whitespace-mode t)
 '(indent-tabs-mode nil)
 '(initial-scratch-message
   ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with 【Ctrl+O】,
;; then enter the text in that file's own buffer.")
 '(max-lisp-eval-depth 10000)
 '(max-specpdl-size 10000)
 '(org-CUA-compatible nil t)
 '(org-replace-disputed-keys nil)
 '(package-selected-packages
   '(undo-fu undo-tree icicles terminal-focus-reporting persistent-soft typescript-mode markdown-mode expand-region multiple-cursors color-theme-sanityinc-solarized ergoemacs-mode bash-completion wgrep magit clojure-mode sass-mode haml-mode use-package))
 '(recentf-menu-before "Close")
 '(recentf-mode t)
 '(safe-local-variable-values '((encoding . binary)))
 '(scroll-error-top-bottom nil)
 '(set-mark-command-repeat-pop nil)
 '(shift-select-mode nil)
 '(show-paren-mode t)
 '(standard-indent 2)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style 'post-forward nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16")))
 '(vc-annotate-very-old-color nil)
 '(whitespace-global-modes '(not shell-mode))
 '(whitespace-style
   '(tabs trailing space-before-tab empty space-after-tab face)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "ADBE" :family "Source Code Pro"))))
 '(comint-highlight-input ((t (:foreground "gainsboro" :weight bold))))
 '(comint-highlight-prompt ((t (:inherit minibuffer-prompt :foreground "dim gray"))))
 '(cursor ((t (:background "violet red"))))
 '(lazy-highlight ((t (:background "#2aa198" :foreground "#073642"))))
 '(line-number ((t (:foreground "#2f525b"))))
 '(line-number-current-line ((t (:inherit default :foreground "#586e75")))))
