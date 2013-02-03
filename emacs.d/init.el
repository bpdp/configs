;;(setq load-path (cons  "/home/bpdp/.emacs.d" load-path))

;;(let ((default-directory "~/.emacs.d/color-theme-6.6.0/"))
;;	(normal-top-level-add-subdirs-to-load-path))
;;

(require 'package)
;;(add-to-list 'package-archives
;;	    '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; This one from emacs 23.x
;; I still need this, so I put this here
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0") 
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/themes") 
(require 'color-theme) 
(color-theme-initialize) 
;;	(setq color-theme-is-global t) 
;;	(color-theme-calm-forest) 
;;	(color-theme-billw)

;; for load-theme - only in emacs24
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)
;;(load-theme 'solarized-dark t)

;; js2-mode
;;
(add-to-list 'load-path "~/emacs.d/js2-mode")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Twittering-mode
;; Failed: Authorization via OAuth failed. Type M-x twit to retry
;; (require 'twittering-mode)
;; (setq twittering-use-master-password t)

;; Author: Patrick Gundlach 
;; nice mark - shows mark as a highlighted 'cursor' so user 'always' 
;; sees where the mark is. Especially nice for killing a region.

(defvar pg-mark-overlay nil
  "Overlay to show the position where the mark is") 
(make-variable-buffer-local 'pg-mark-overlay)

(put 'pg-mark-mark 'face 'secondary-selection)

(defvar pg-mark-old-position nil
  "The position the mark was at. To be able to compare with the
current position")

(defun pg-show-mark () 
  "Display an overlay where the mark is at. Should be hooked into 
activate-mark-hook" 
  (unless pg-mark-overlay 
    (setq pg-mark-overlay (make-overlay 0 0))
    (overlay-put pg-mark-overlay 'category 'pg-mark-mark))
  (let ((here (mark t)))
    (when here
      (move-overlay pg-mark-overlay here (1+ here)))))

(defadvice  exchange-point-and-mark (after pg-mark-exchange-point-and-mark)
  "Show visual marker"
  (pg-show-mark))

(ad-activate 'exchange-point-and-mark)
(add-hook 'activate-mark-hook 'pg-show-mark)

;; dired+ - dired improvement
(require 'dired+)

;; that's for emms
;;(require 'emms-setup)
;;(emms-devel)
;;(emms-default-players)
;; Show the current track each time EMMS
;; starts to play a track with "NP : "
;;(add-hook 'emms-player-started-hook 'emms-show)
;;(setq emms-show-format "NP: %s")
;; When asked for emms-play-directory,
;; always start from this one 
;;(setq emms-source-file-default-directory "/opt/lagu/")
;; Want to use alsa with mpg321 ? 
;; (setq emms-player-mpg321-parameters '("-o" "alsa"))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el" 
  "Major mode for editing Markdown files" t) 
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; and these for line + column highlight and activate line number
(global-hl-line-mode 1)
;; To customize the background color
(set-face-background 'hl-line "#330")
;;(require 'col-highlight)
;;(column-highlight-mode 1)
;;(toggle-highlight-column-when-idle 1)
(global-linum-mode 1) 

;;(setq inferior-lisp-program "/usr/bin/sbcl")
(setq inferior-lisp-program "/home/bpdp/software/leiningen/lein repl")

;;(set-default-font "-adobe-courier-medium-r-normal--12-180-75-75-m-90-iso8859-1")
;;(set-default-font "-monaco-*-*-*-*-*-12-180-75-75-m-90-iso8859-1")
(set-face-attribute 'default nil :font "Monaco-10")

;;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;;  '(crosshairs-mode 1)
;;)
;;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;; '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "monotype" :family "Andale Mono")))))

;; do not display splash screen
(setq inhibit-startup-message t)

;; these for Clojure, activate then turn on 
(require 'clojure-mode)
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#1a1a1a" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "fc97561a594768660eae60b39c5cddd16c4231f1328f491a7624014a2fc07564" "83e62ea27a5c591467ed6c1992a4dc18e44577b50d2275795e8ed0056c56efa4" "6938c51c0a89f078c61b979af23ae4c32204458f16a6a08c1a683ab478a7bc6b" default)))
 '(fci-rule-color "#383838")
 '(foreground-color "#839496"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
