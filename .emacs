(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

; --------------------------------
; PLUGINS
; --------------------------------
(require 'org)
;; The following lines are always needed.  Choose your own keys.
;;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cc" 'org-capture)
;;(global-set-key "\C-cb" 'org-switchb)
(global-set-key (kbd "C-c o b") 'org-web-tools-insert-link-for-url)
(global-set-key (kbd "C-c o a") 'org-web-tools-archive-attach)
(global-set-key (kbd "C-c o v") 'org-web-tools-archive-view)
(add-to-list 'load-path "~/.emacs.d/elpa")
(require 'iflipb)
(global-set-key (kbd "<f10>") 'iflipb-next-buffer)
(global-set-key (kbd "<f9>")  'iflipb-previous-buffer)

; --------------------------------
; GENERAL
; --------------------------------
(desktop-save-mode 1)
(load-theme 'leuven t)

(tool-bar-mode -1)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq default-frame-alist '((font . "Fantasque Sans Mono-12")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(org-agenda-files (quote ("/cygdrive/d/Dropbox/Documents/todo.org")))
 '(package-selected-packages
   (quote
    (evil org-bullets ztree magit afternoon-theme org-web-tools s dash org-board)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))

(setq inhibit-splash-screen t)
(transient-mark-mode 1)
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <down>")  'windmove-down)
(global-set-key (kbd "C-x <left>")  'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-z")         'undo)
(global-set-key (kbd "C-<next>")    'shrink-window)
(global-set-key (kbd "C-<prior>")   'enlarge-window)
(global-set-key (kbd "C-S-<next>")  'shrink-window-horizontally)
(global-set-key (kbd "C-S-<prior>") 'enlarge-window-horizontally)

; --------------------------------
; ORG
; --------------------------------
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-hide-leading-stars 1)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq org-startup-indented t
      org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
      org-ellipsis "  " ;; folding symbol
      org-pretty-entities t
      org-hide-emphasis-markers t
      ;; show actually italicized text instead of /italicized text/
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)


; --------------------------------
; FONT
; --------------------------------
;(when (member "DejaVu Sans Mono" (font-family-list))
;  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))
;(when (member "Fantasque Sans Mono" (font-family-list))
;  (set-face-attribute 'default nil :font "Fantasque Sans Mono"))
(setq inhibit-compacting-font-caches t)

; -------------------------------
; EVIL
; -------------------------------
(require 'evil)
(evil-mode t)

; -------------------------------
; HELM
; -------------------------------
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)
