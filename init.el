(require 'package)

; activate all the packages (in particular autoloads)
(setq package-enable-at-startup nil)
(package-initialize)


(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#373b41"))
 '(custom-enabled-themes (quote (tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "06ed008240c1b9961a0214c87c078b4d78e802b811f58b8d071c396d9ff4fcb6" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(electric-pair-mode t)
 '(enh-ruby-add-encoding-comment-on-save nil)
 '(enh-ruby-check-syntax nil)
 '(enh-ruby-hanging-brace-deep-indent-level 2)
 '(fci-rule-color "#373b41")
 '(midnight-delay 10800)
 '(midnight-mode t)
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow vlf window-numbering anzu neotree git-commit web-mode json-mode yaml-mode csv-mode golden-ratio-scroll-screen aggressive-indent fish-mode enh-ruby-mode nyan-mode dash smartparens magit helm-projectile)))
 '(ruby-insert-encoding-magic-comment nil)
 '(send-mail-function (quote mailclient-send-it))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hasklig" :foundry "nil" :slant normal :weight medium :height 120 :width normal))))
 '(highlight ((t (:background "gray20")))))




;;
;; END CUSTOM
;;




;; TOTE – The Only Text Encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en_US.UTF-8")
(prefer-coding-system 'utf-8)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(if (display-graphic-p)
    (progn  ;; has graphical system
      (desktop-save-mode 1)
      (mac-auto-operator-composition-mode))
  (progn    ;; isatty
    (menu-bar-mode -1)
    (xterm-mouse-mode 1)
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))))

(setq mac-option-modifier 'meta
      mac-right-option-modifier nil
      mac-command-modifier 'super)


(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "M-s-t") 'helm-projectile-switch-project)
(global-set-key (kbd "s-t") 'helm-projectile-find-file)
(global-set-key (kbd "C-x k") 'kill-this-buffer)






; list the packages you want
(setq package-list '(dash
                     enh-ruby-mode
                     yaml-mode
                     json-mode
                     web-mode
                     fish-mode
                     git-commit
                     helm-projectile
                     smart-mode-line  smart-mode-line-powerline-theme
                     nyan-mode
                     color-theme-sanityinc-tomorrow
                     neotree
                     anzu
                     window-numbering
                     vlf  ; very large files
                     smartparens))

; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))





(setq powerline-arrow-shape 'curve)
(setq sml/theme 'powerline)
(sml/setup)





(setq vc-follow-symlinks t)
(require 'vlf-setup)

(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-config)
(helm-mode 1)

(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
;;(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "/tmp/helm-cfg.el") (delete-file "/tmp/helm-cfg.el"))))

(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2))
  (move-to-window-line nil))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2))
  (move-to-window-line nil))

(global-set-key [remap scroll-down-command] 'scroll-half-page-down)
(global-set-key [remap scroll-up-command] 'scroll-half-page-up)


(require 'helm-projectile)
(helm-projectile-on)

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))




(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)
(add-hook 'prog-mode-hook #'show-smartparens-mode)



(require 'web-mode)

(defun my-web-mode-hook ()
  (setq web-mode-enable-auto-pairing nil)  ; to be compatible with smartparens
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(defun sp-web-mode-is-code-context (id action context)
  (and (eq action 'insert)
       (not (or (get-text-property (point) 'part-side)
                (get-text-property (point) 'block-side)))))

;; end smartparens-web-mode support



(global-anzu-mode +1)

(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq css-indent-offset 2)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-git-commit-mode)
(global-auto-revert-mode 1)

(window-numbering-mode)
(defface window-numbering-face '((default :weight extra-bold :foreground "RoyalBlue1"))
  "Face for window number in the mode-line.")



(if (display-graphic-p)
    (progn
      ;; (nyan-mode)
      ))
