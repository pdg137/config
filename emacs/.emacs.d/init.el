(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

(mapc
 (lambda (package)
   (eval `(use-package ,package :ensure t)))
 '(haml-mode sass-mode wgrep ffap bind-key))

(menu-bar-mode 0)

                                        ; Don't split horizontally
(setq split-height-threshold nil)
(setq split-width-threshold nil)

                                        ; Indent normally
(setq c-default-style "linux"
      c-basic-offset 2)

(setq js-indent-level 2)

                                        ; brings awesome bash tab completion to emacs shell-mode
(use-package bash-completion
  :ensure t
  :config
  (bash-completion-setup)
  )

(use-package ergoemacs-mode
  :ensure t
  :init
  (setq ergoemacs-keyboard-layout "us")
  (setq ergoemacs-theme nil)
  )

;; Load an Ergoemacs theme including everything
;; except move-page, since that overwrites
;; C-M-i.
(if ergoemacs-mode--fast-p
    (provide 'my_ergoemacs_theme)
  (load "my_ergoemacs_theme"))

(use-package color-theme-sanityinc-solarized
  :ensure t
  :config
  (load-theme 'sanityinc-solarized-dark t)
  )

(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "sets a darker background when in xterm-256color mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "gray10" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "M-m") #'mc/edit-lines)
  (global-set-key (kbd "M-#") #'set-rectangular-region-anchor)
  )

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-S-]") #'er/expand-region)
  (global-set-key (kbd "M-S-[") #'er/contract-region)
  )

(add-hook 'shell-mode-hook #'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions #'ansi-color-process-output)

;; This is supposed to allow PS1 to have custom colors, but it doesn't work.
;;(set-face-attribute 'comint-highlight-prompt nil
;;                    :inherit nil)

(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(setq ruby-insert-encoding-magic-comment nil)

                                        ; Use UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

                                        ; Put backups in a better place
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

; these are annoying and break things (e.g. node)
(setq create-lockfiles nil)
                                        ; Custom Shortcuts
(global-set-key "\e`" #'shell)
(global-set-key "\e," #'goto-line)
(global-set-key (kbd "C-@") #'set-mark-command)

(when (eq system-type 'windows-nt)
  (setq vc-handled-backends nil)
  (set-variable 'explicit-shell-file-name "c:/Program Files \(x86\)/Git/bin/bash.exe")
  (set-variable 'shell-file-name "bash")
  )

(setq custom-file (expand-file-name "custom_file.el" user-emacs-directory))
(load custom-file)

(defun split-right-and-switch-buffer ()
  (interactive)
  (split-window-right)
  (windmove-right)
  (switch-to-buffer (other-buffer))
  (windmove-left)
  )

(defun split-left-and-switch-buffer ()
  (interactive)
  (split-window-right)
  (switch-to-buffer (other-buffer))
  (windmove-right)
  )

(defun split-up-and-switch-buffer ()
  (interactive)
  (split-window-below)
  (switch-to-buffer (other-buffer))
  (windmove-down)
  )

(defun split-down-and-switch-buffer ()
  (interactive)
  (split-window-below)
  (windmove-down)
  (switch-to-buffer (other-buffer))
  (windmove-up)
  )

(defun delete-window-up ()
  (interactive)
  (windmove-up)
  (delete-window)
  )

(defun delete-window-down ()
  (interactive)
  (windmove-down)
  (delete-window)
  )

(defun delete-window-left ()
  (interactive)
  (windmove-left)
  (delete-window)
  )

(defun delete-window-right ()
  (interactive)
  (windmove-right)
  (delete-window)
  )

(ergoemacs-component my-ergoemacs-keys ()
  "My ergoemacs keys"
  (unbind-key "M-O") ; fixes terminal arrow keys

  (global-set-key (kbd "M-<up>") #'capitalize-word)
  (global-set-key (kbd "S-M-<up>") #'upcase-word)
  (global-set-key (kbd "S-M-<down>") #'downcase-word)
  (global-set-key (kbd "C-t") #'transpose-chars)
  (global-set-key (kbd "M-t") #'transpose-words)
  (global-set-key (kbd "M-;") #'isearch-forward)
  (global-set-key (kbd "M-:") #'isearch-backward)
  (global-set-key (kbd "S-C-f") #'isearch-backward)
  (global-set-key (kbd "C-SPC") #'set-mark-command)

  (global-set-key (kbd "C-x C-k") #'ergoemacs-close-current-buffer)
  (global-set-key (kbd "C-x k") #'kill-buffer)

  (global-set-key (kbd "M-}") #'mc/mark-next-like-this)
  (global-set-key (kbd "M-{") #'mc/mark-previous-like-this)
  (global-set-key (kbd "M-/") #'hippie-expand)
  (global-set-key (kbd "M-~") #'sign-with-timestamp)

  (global-set-key (kbd "S-C-s") #'write-file)

  (bind-key "C-M-l" #'windmove-right)
  (bind-key "C-M-k" #'windmove-down)
  (bind-key "C-M-j" #'windmove-left)
  (bind-key "C-x 1" #'delete-other-windows)
  ;; C-M-i must be handled specially (below)

  (bind-keys :prefix-map windmove-map
             :prefix "C-x o"
             ("i" . windmove-up)
             ("k" . windmove-down)
             ("j" . windmove-left)
             ("l" . windmove-right)
             )

  (bind-keys :prefix-map delete-window-map
             :prefix "C-x 0"
             ("i" . delete-window-up)
             ("k" . delete-window-down)
             ("j" . delete-window-left)
             ("l" . delete-window-right)
             ("SPC" . delete-window)
             )

  (bind-keys :prefix-map split-window-map
             :prefix "C-x 2"
             ("i" . split-up-and-switch-buffer)
             ("k" . split-down-and-switch-buffer)
             ("j" . split-left-and-switch-buffer)
             ("l" . split-right-and-switch-buffer)
             )

  ;; Recover shortcuts we lost when removing page-move from ergoemacs.
  (bind-key "M-I" #'scroll-down-command)
  (bind-key "M-K" #'scroll-up-command)
  )
(ergoemacs-require 'my-ergoemacs-keys)

                                        ; mousewheel and C-+ C-- scrolling
(defun scale-to (f)
  (set-face-attribute 'default nil :height
                      (round f)
                      ))

(defun scale-by (f)
  (scale-to (* f (face-attribute 'default :height)))
  )

(defun scale-up () (interactive)
       (scale-by 1.1))

(defun scale-down () (interactive)
       (scale-by (/ 1 1.1)))

(defun scale-reset () (interactive)
       (scale-to 200))

;; The  shortcuts don't work as an ergoemacs component, but
;; they work here.  Unforunately it seems like repeated scrolling
;; "clicks" don't work correctly, so you can only scroll by one step
;; at a time.
(unbind-key "C-M-i" emacs-lisp-mode-map)
(unbind-key "C-M-i" help-mode-map)
(bind-key "C-M-i" #'windmove-up)

(bind-key [C-mouse-4] #'scale-up)
(bind-key [C-mouse-5] #'scale-down)
(bind-key "C-=" #'scale-up)
(bind-key "C--" #'scale-down)
(bind-key "C-0" #'scale-reset)
(bind-key "C-x g" #'magit-status)
