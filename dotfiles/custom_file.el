(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
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
   ";; This buffer is for notes you don't want to save, and for Lisp evaluation.\12;; If you want to create a file, visit that file with 【Ctrl+O】,\12;; then enter the text in that file's own buffer.")
 '(markdown-max-image-size '(1200 . 1200))
 '(recentf-menu-before "Close")
 '(recentf-mode t)
 '(uniquify-buffer-name-style 'post-forward nil (uniquify))
 '(whitespace-global-modes '(not shell-mode))
 '(whitespace-style
   '(tabs trailing space-before-tab empty space-after-tab face)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight semi-bold :height 135 :width normal :family "Source Code Pro"))))
 '(ansi-color-black ((t (:background "#002b36" :foreground "#002b36"))))
 '(ansi-color-blue ((t (:background "#6c71c4" :foreground "#6c71c4"))))
 '(ansi-color-bright-black ((t (:background "#073642" :foreground "#073642"))))
 '(ansi-color-bright-blue ((t (:background "#268bd2" :foreground "#268bd2"))))
 '(ansi-color-bright-cyan ((t (:background "#2aa198" :foreground "#2aa198"))))
 '(ansi-color-bright-green ((t (:background "#859900" :foreground "#859900"))))
 '(ansi-color-bright-magenta ((t (:background "#d33682" :foreground "#d33682"))))
 '(ansi-color-bright-red ((t (:background "#dc322f" :foreground "#dc322f"))))
 '(ansi-color-bright-white ((t (:background "#fdf6e3" :foreground "#fdf6e3"))))
 '(ansi-color-bright-yellow ((t (:background "#b58900" :foreground "#b58900"))))
 '(ansi-color-cyan ((t (:background "#2aa198" :foreground "#2aa198"))))
 '(ansi-color-green ((t (:background "#859900" :foreground "#859900"))))
 '(ansi-color-magenta ((t (:background "#6c71c4" :foreground "#6c71c4"))))
 '(ansi-color-red ((t (:background "#dc322f" :foreground "#dc322f"))))
 '(ansi-color-white ((t (:background "#839496" :foreground "#839496"))))
 '(ansi-color-yellow ((t (:background "#cb4b16" :foreground "#cb4b16"))))
 '(comint-highlight-input ((t (:foreground "gainsboro" :weight bold))))
 '(comint-highlight-prompt ((t (:inherit minibuffer-prompt :foreground "dim gray"))))
 '(cursor ((t (:background "violet red"))))
 '(lazy-highlight ((t (:background "#2aa198" :foreground "#073642"))))
 '(line-number ((t (:foreground "#2f525b"))))
 '(line-number-current-line ((t (:inherit default :foreground "#586e75"))))
 '(mode-line ((t (:background "#073642" :foreground "#93a1a1" :box nil :weight semi-bold))))
 '(mode-line-inactive ((t (:weight normal :box nil :foreground "#586e75" :background "#073642" :inherit mode-line)))))
