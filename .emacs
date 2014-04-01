(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))



(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(add-hook 'markdown-mode-hook (lambda () (variable-pitch-mode f)
                                (auto-fill-mode f)))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (require 'color-theme-solarized)
;;  (require 'solarized-definitions
;;          (locate-file "solarized-definitions.el" custom-theme-load-path
;;                       '("c" "")))

;; (create-solarized-theme dark)

; (color-theme-solarized-light)
(load-theme 'solarized-light t)
(defun align-repeat (start end regexp)
    "Repeat alignment with respect to 
     the given regular expression."
    (interactive "r\nsAlign regexp: ")
    (align-regexp start end 
        (concat "\\(\\s-*\\)" regexp) 1 1 t))

;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(setq mac-option-modifier 'meta)
; (global-set-key (kbd "M-v") 'View-scroll-half-page-forward)
; (global-set-key (kbd "M-v") 'View-scroll-half-page-backward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; revert

(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

(global-set-key (kbd "<f5>") 'revert-buffer)
(put 'narrow-to-region 'disabled nil)

(setq default-directory "~/" ) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Custom funs

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; From Steve Yegge effective emacs
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key [f5] 'call-last-kbd-macro)
(defalias 'qrr 'query-replace-regexp)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(markdown-command "/usr/local/bin/pandoc")
 '(markdown-open-command "/Applications/Marked.app/Contents/MacOS/Marked")
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If
 there is more than one, they won't work right.
 )

;; Place the function call requiring `clojure-mode` after the call to `package-initialize`
;; if you are using Emacs version 24.1.1
(require 'clojure-mode)

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
