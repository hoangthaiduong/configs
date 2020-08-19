(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cff highlight-indent-guides ccls dap-mode lsp-ivy lsp-treemacs company-lsp company flycheck lsp-ui lsp-mode eyebrowse use-package ivy smooth-scrolling iflipb evil helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
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
;; (global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
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

; -------------------------------
; EVIL
; -------------------------------
(require 'evil)
(evil-mode t)

; -------------------------------
; IFLIPB
; -------------------------------
(require 'iflipb)
(global-set-key (kbd "<f10>") 'iflipb-next-buffer)
(global-set-key (kbd "<f9>")  'iflipb-previous-buffer)

; -------------------------------
; ORG
; -------------------------------
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

; -------------------------------
; IVY
; -------------------------------
(require 'ivy)
(require 'ivy-rich)
(require 'counsel)
(use-package ivy :ensure t
  :defer 0.1
  :diminish (ivy-mode . "")
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window)
         ("C-x b" . ivy-switch-buffer)
         ("C-c v" . ivy-push-view)
         ("C-c V" . ivy-pop-view))
  (:map ivy-mode-map
   ("C-'" . ivy-avy))
  :config
  (ivy-mode 1)
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order))))

;; (global-set-key (kbd "C-c v") 'ivy-push-view)
;; (global-set-key (kbd "C-c V") 'ivy-pop-view)

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy-rich
  :after counsel
  :init (setq ivy-rich-path-style 'abbrev
              ivy-virtual-abbreviate 'full)
  :config (ivy-rich-mode))

;; (use-package ivy-rich
;;   :after ivy
;;   :custom
;;   (ivy-virtual-abbreviate 'full
;;                           ivy-rich-switch-buffer-align-virtual-buffer t
;;                           ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-set-display-transformer 'ivy-switch-buffer
;;                                'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

; -------------------------------
; SMOOTH SCROLLING
; -------------------------------
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

; -------------------------------
; EYEBROWSE
; -------------------------------
(require 'eyebrowse)
(eyebrowse-mode t)


; -------------------------------
; LSP-MODE
; -------------------------------
(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package lsp-mode :commands lsp :ensure t)
(use-package lsp-ui :commands lsp-ui-mode :ensure t)
(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config (push 'company-lsp company-backends)) ;; add company-lsp as a backend



; -------------------------------
; CCLS
; -------------------------------
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq-default highlight-indent-guides-method 'character)
(setq-default highlight-indent-guides-responsive 'top)

; -------------------------------
; CFF
; -------------------------------
(require 'cff)
;; defines shortcut for find source/header file for the current
;; file
(add-hook 'c++-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))
(add-hook 'c-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))

; -------------------------------
; CUSTOM
; -------------------------------
(transient-mark-mode 1)
(desktop-save-mode 1)
(setq-default truncate-lines 1)
(setq-default tab-width 2)
(global-set-key [f6] (quote other-window))
(global-set-key [f2] (quote xref-find-definitions))
(global-set-key [f3] (quote lsp-ui-imenu))
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <down>")  'windmove-down)
(global-set-key (kbd "C-x <left>")  'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-z")         'undo)
(global-set-key (kbd "C-<next>")    'shrink-window)
(global-set-key (kbd "C-<prior>")   'enlarge-window)
(global-set-key (kbd "C-S-<next>")  'shrink-window-horizontally)
(global-set-key (kbd "C-S-<prior>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'pop-global-mark)

;; (defun save-ivy-views ()
;; (interactive)
;; (with-temp-file "~/.emacs.d/ivy-views"
;; (print ivy-views (current-buffer))
;; (message "save ivy-views to ~/.emacs.d/ivy-views")))

;; (defun load-ivy-views ()
;; (interactive)
;; (setq ivy-views
;; (with-temp-buffer
;; (insert-file-contents "~/.emacs.d/ivy-views")
;; (read (current-buffer))))
;; (message "load ivy-views"))
