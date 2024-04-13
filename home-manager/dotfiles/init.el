(setq ergoemacs-user-keymap (make-keymap))

(setq custom-file (expand-file-name "custom_file.el" user-emacs-directory))
(load custom-file)

(use-package bind-key)

;; Key binding helpers
(defun bind (key f)
  (bind-key key f ergoemacs-user-keymap)
  (bind-key key f)
  )

(defun unbind (key f)
  (unbind-key key ergoemacs-user-keymap)
  (unbind-key key)
  )

(use-package color-theme-sanityinc-solarized
  :config
  (load-theme 'sanityinc-solarized-dark t)
  )

(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "sets a darker background when there are not many colors"
  (if (> 100 (length (defined-colors)))
    (set-face-background 'default "gray10" frame)
    ))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

(use-package multiple-cursors
  :config
  (bind "M-m" 'mc/edit-lines)
  (bind "M-#" 'set-rectangular-region-anchor)
  )

;; Clipboard TTY copy
(use-package clipetty
  :config
  (global-clipetty-mode))

(use-package expand-region
  :config
  (global-set-key (kbd "M-S-]") #'er/expand-region)
  (global-set-key (kbd "M-S-[") #'er/contract-region)
  )

(use-package python-mode)

;; Find file at point
(ffap-bindings)

(defun flyspell-on-for-buffer-type ()
  "Enable Flyspell appropriately for the major mode of the current buffer.  Uses `flyspell-prog-mode' for modes derived from `prog-mode', so only strings and comments get checked.  All other buffers get `flyspell-mode' to check all text.  If flyspell is already enabled, does nothing."
  (interactive)
  (if (not (symbol-value flyspell-mode)) ; if not already on
      (progn
        (if (derived-mode-p 'prog-mode)
            (progn
              (message "Flyspell on (code)")
              (flyspell-prog-mode))
          ;; else
          (progn
            (message "Flyspell on (text)")
            (flyspell-mode 1)))
        ;; I tried putting (flyspell-buffer) here but it didn't seem to work
        )))

(defun flyspell-toggle ()
  "Turn Flyspell on if it is off, or off if it is on.  When turning on, it uses `flyspell-on-for-buffer-type' so code-vs-text is handled appropriately."
  (interactive)
  (if (symbol-value flyspell-mode)
      (progn ; flyspell is on, turn it off
        (message "Flyspell off")
        (flyspell-mode -1))
                                        ; else - flyspell is off, turn it on
    (flyspell-on-for-buffer-type)))

;; Ways to turn on flyspell for ALL buffers (this is annoying though)
;;(add-hook 'find-file-hook 'flyspell-on-for-buffer-type)
;;(add-hook 'after-change-major-mode-hook 'flyspell-on-for-buffer-type)

(bind "C-M-4" 'flyspell-toggle)
(bind "M-$" 'flyspell-buffer)
(bind "C-$" 'flyspell-correct-word-before-point)

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
  :init
  (setq ergoemacs-keyboard-layout "us")
  (setq ergoemacs-theme nil)
  :config
  (ergoemacs-mode 1)
  )

;; Brings awesome bash tab completion to emacs shell-mode
(use-package bash-completion
  :config
  (bash-completion-setup)
  (set-variable 'bash-completion-use-separate-processes t)
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
(bind "C-M-," 'display-line-numbers-mode)

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

;; Misc config
(menu-bar-mode 0)
(scroll-bar-mode 0)
(delete-selection-mode t)
(display-time-mode t)
(show-paren-mode t)
(setq standard-indent 2)
(tool-bar-mode -1)
