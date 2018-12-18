;;; cscope-call-tree.el --- uses cscope's called function list to create a navigatable call tree.

;; Copyright (C) 2018- Alexander Hirschfeld

;; Author: Alexander Hirschfeld <alex@d-qoi.com>

;; This file is not part of GNU Emacs.


;;; Commentary:
;; Should put something here eventually :)

;;; Code:

(require 'xcscope)

(defgroup csct nil
  "Cscope call tree.
Using cscope via xcscope you can browse the call tree for any function,
tracing it down to bare code"
  :prefix "cscope-call-tree"
  :group 'tools)

(defcustom csct-combine-trees nil
  "Combine call trees if they intersect."
  :type 'boolean
  :group 'csct)

(defcustom csct-fill-tree-duplicates t
  "Fill in duplicate function calls when traversing into them.",
  :type 'boolean
  :group 'csct)

(defvar csct-tot-node-list '()
  "The list of head nodes for seperate call trees.")

(defvar csct-output-buffer-name "*csct*"
  "The name of the output buffer.")

(defun csct-print-tree

(provide 'cscope-call-tree)

;;; cscope-call-tree.el ends here
