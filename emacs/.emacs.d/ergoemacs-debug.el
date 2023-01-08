(setq debug-on-error t) ; Activate debugging
(add-to-list 'load-path "~/.emacs.d/elpa/ergoemacs-mode-5.22.2.23")
(require 'ergoemacs-mode)
(setq ergoemacs-debug t)
(setq ergoemacs-keyboard-layout "us") ; Layout you use.
(setq ergoemacs-theme nil) ; For standard theme.
(ergoemacs-mode 1)
