;;;; EMACS.EL ;;;;

;; Packages ;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Remove distractions ;;
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar  -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; Better completation ;;
(ido-mode 1)
(ido-everywhere 1)
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)

;; Multiple Cursors ;;
(require 'multiple-cursors)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)

;; Whitespace ;;
(require 'whitespace)
;(whitespace-mode 1)
;(setq whitespace-style '(trailing tabs tab-mark))
(setq whitespace-style 
      '(face tabs tab-mark spaces space-mark newline newline-mark))

(setq whitespace-display-mappings
      '(
	(space-mark ?\u3000 [?□])
        (space-mark ?\u0020 [?\xB7])
        (newline-mark ?\n   [?$ ?\n]) 
        (tab-mark   ?\t   [?\xBB ?\t])
        ) )


;; ORG-MODE ;;
;; Settings ;;

(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
