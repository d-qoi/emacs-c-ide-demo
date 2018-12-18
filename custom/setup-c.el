;; company-c-headers

;;; Code:
(message "setup-c entered")

(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "linux") ;; set style to "linux"

(require 'cc-mode)

(defun c-offset-correct-hook ()
  (c-set-offset 'substatement-open '0))

(add-hook 'c-mode-hook 'c-offset-correct-hook)

(use-package cuda-mode)

(use-package xcscope
  :custom
  (cscope-initial-directory "~/cscopedb/")
  (cscope-keymap-prefix "C-c M-s")
  :config
  (cscope-setup) ;; has bindings for c, c++, and dired
  ;; (define-key cscope-minor-mode-keymap cscope-keymap-prefix nil)
  ;; (setq cscope-keymap-prefix (kbd "C-c S"))
  ;; (define-key cscope-minor-mode-keymap cscope-keymap-prefix
  ;;   cscope-command-map)
  (add-hook 'c-mode-common-hook (lambda () (cscope-minor-mode 1))))

    ;;(add-hook 'c-mode-hook cscope-minor-mode)))

;; function-args
(use-package function-args
  :config
  (fa-config-default)
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))

(use-package ecb)

(message "setup-c loaded")
(provide 'setup-c)
;;; setup-c.el ends here
