(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq custom-file (expand-file-name "custom_file.el" user-emacs-directory))
(load custom-file)

(eval-when-compile
  (defvar use-package-verbose t)
  (require 'use-package))

(use-package bind-key
  :ensure t)

;; Key binding helpers
(defun bind (key f)
  (bind-key key f ergoemacs-user-keymap)
  (bind-key key f)
  )

(defun unbind (key f)
  (unbind-key key ergoemacs-user-keymap)
  (unbind-key key)
  )

;; Indent normally
(setq c-default-style "linux"
      c-basic-offset 2)

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
  (bind "M-m" 'mc/edit-lines)
  (bind "M-#" 'set-rectangular-region-anchor)
  )

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-S-]") #'er/expand-region)
  (global-set-key (kbd "M-S-[") #'er/contract-region)
  )

;; Find file at point
;; Overrides open init.el
(use-package ffap
  :ensure t
  :config
  (ffap-bindings)
  )

;; Writeable grep
(use-package wgrep
  :ensure t
  )

(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(setq ruby-insert-encoding-magic-comment nil)

;; Use UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Put backups in a better place
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; These are annoying and break things (e.g. node)
(setq create-lockfiles nil)

;; Shell improvements
(when (eq system-type 'windows-nt)
  ;(setq vc-handled-backends nil)
  (set-variable 'explicit-shell-file-name "c:/Program Files/Git/bin/bash.exe")
  (set-variable 'shell-file-name "bash")
  )
(add-hook 'shell-mode-hook #'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions #'ansi-color-process-output)

(use-package ergoemacs-mode
  :demand t
  :ensure t
  :init
  (setq ergoemacs-keyboard-layout "us")
  (setq ergoemacs-theme nil)
  :config
  (ergoemacs-mode 1)
  )

;; Brings awesome bash tab completion to emacs shell-mode
(use-package bash-completion
  :ensure t
  :config
  (bash-completion-setup)
  )

;; General key bindings
(bind-keys :map ergoemacs-user-keymap
           :prefix-map split-window-map
           :prefix "C-x 2"
           ("i" . split-up-and-switch-buffer)
           ("k" . split-down-and-switch-buffer)
           ("j" . split-left-and-switch-buffer)
           ("l" . split-right-and-switch-buffer)
           )

(bind-keys :map ergoemacs-user-keymap
           :prefix-map windmove-map
           :prefix "C-x o"
           ("i" . windmove-up)
           ("k" . windmove-down)
           ("j" . windmove-left)
           ("l" . windmove-right)
           )

(bind-keys :map ergoemacs-user-keymap
           :prefix-map delete-window-map
           :prefix "C-x 0"
           ("i" . delete-window-up)
           ("k" . delete-window-down)
           ("j" . delete-window-left)
           ("l" . delete-window-right)
           ("SPC" . delete-window)
           )


;; My misc shortcuts
;; Some of these restore standard Emacs keys that were disabled in
;; ergoemacs.
(bind "M-<up>" 'capitalize-word)
(bind "S-M-<up>" 'upcase-word)
(bind "S-M-<down>" 'downcase-word)
(bind "C-t" 'transpose-chars)
(bind "M-t" 'transpose-words)
(bind "M-;" 'isearch-forward)
(bind "M-:" 'isearch-backward)
(bind "S-C-f" 'isearch-backward)
(bind "C-SPC" 'set-mark-command)
(bind "C-@" 'set-mark-command)
(bind "C-x C-k" 'ergoemacs-close-current-buffer)
(bind "C-x k" 'kill-buffer)
(bind "M-}" 'mc/mark-next-like-this)
(bind "M-{" 'mc/mark-previous-like-this)
(bind "M-/" 'hippie-expand)
(bind "S-C-s" 'write-file)
(bind "M-`" 'shell)
(bind "M-," 'goto-line)


; Window motion commands

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

(bind "C-x 1" 'delete-other-windows)

; Add more minor modes here if you find that it's broken
(unbind "C-M-i" emacs-lisp-mode-map)
(unbind "C-M-i" help-mode-map)

(bind "C-M-j" 'windmove-left)
(bind "C-M-l" 'windmove-right)
(bind "C-M-k" 'windmove-down)
(bind "C-M-i" 'windmove-up)

; Mousewheel and C-+ C-- scrolling
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

(bind "C--" 'scale-down)
(bind "C-+" 'scale-up)
(bind "C-=" 'scale-up)

(bind "C-<wheel-up>" 'scale-down)
(bind "C-<double-wheel-up>" 'scale-down)
(bind "C-<triple-wheel-up>" 'scale-down)
(bind "C-<wheel-down>" 'scale-up)
(bind "C-<double-wheel-down>" 'scale-up)
(bind "C-<triple-wheel-down>" 'scale-up)

(bind "C-0" 'scale-reset)

(bind "C-x g" 'magit-status)

;; Misc config
(menu-bar-mode 0)
