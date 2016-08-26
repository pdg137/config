(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(when (not (package-installed-p 'use-package))
    (package-refresh-contents)
    (package-install 'use-package))

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

(mapc
 (lambda (package)
   (eval `(use-package ,package :ensure t)))
 '(haml-mode sass-mode clojure-mode))

(menu-bar-mode 0)

; Don't split horizontally
(setq split-height-threshold nil)
(setq split-width-threshold nil)

; Indent normally
(setq c-default-style "linux"
      c-basic-offset 2)

(setq js-indent-level 2)

(use-package ergoemacs-mode
  :ensure t
  :init
  (setq ergoemacs-keyboard-layout "us")
  (setq ergoemacs-theme-options (quote ((save-options-on-exit off))))
  )

(use-package color-theme-sanityinc-solarized
  :ensure t
  :config
  (load-theme 'sanityinc-solarized-dark t)
  )

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "M-m") #'mc/edit-lines)
  (global-set-key (kbd "M-#") #'set-rectangular-region-anchor)
  )

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-]") #'er/expand-region)
  (global-set-key (kbd "M-[") #'er/contract-region)
  )

(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

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

; Custom Shortcuts
(global-set-key "\e`" #'shell)
(global-set-key "\e," #'goto-line)
(global-set-key (kbd "C-@") #'set-mark-command)

; Ruby
;(load-library "rhtml-mode")
;(load-library "two-mode-mode")
(load-library "haml-mode")
(load-library "sass-mode")

(defun rhtml-modes ()
  (two-mode-mode)
  (rhtml-minor-mode))

(setq auto-mode-alist
      (append
       (list '("\\.rhtml$" . rhtml-modes))
       auto-mode-alist))

; Timestamper
(defun sign-with-timestamp () (interactive)
    (insert (shell-command-to-string "echo -n ' -'$USER $(date)")))

(when (eq system-type 'windows-nt)
  (setq vc-handled-backends nil)
  (set-variable 'explicit-shell-file-name "c:/Program Files \(x86\)/Git/bin/bash.exe")
  (set-variable 'shell-file-name "bash")
  )

(setq custom-file (expand-file-name "custom_file.el" user-emacs-directory))
(load custom-file)

;(define-key dired-mode-map (kbd "C-O") 'find-file)
(ergoemacs-component my-ergoemacs-keys ()
  "My ergoemacs keys"
  (global-set-key (kbd "C-z") #'undo)
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

  (global-set-key (kbd "M-}") #'mc/mark-next-like-this)
  (global-set-key (kbd "M-{") #'mc/mark-previous-like-this)
  (global-set-key (kbd "M-/") #'hippie-expand)
  (global-set-key (kbd "M-~") #'sign-with-timestamp)

  (global-set-key (kbd "S-C-s") #'write-file)
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

;; These shortcuts don't work as an ergoemacs component, but they work
;; here.  Unforunately it seems like repeated scrolling "clicks" don't
;; work correctly, so you can only scroll by one step at a time.
(global-set-key (kbd "C-=") #'scale-up)
(global-set-key (kbd "C--") #'scale-down)
(global-set-key (kbd "C-0") #'scale-reset)
(global-set-key [C-mouse-4] #'scale-up)
(global-set-key [C-mouse-5] #'scale-down)
