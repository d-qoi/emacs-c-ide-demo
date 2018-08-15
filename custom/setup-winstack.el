;;; package --- Winstack! Found from stackexchange:
;;; https://emacs.stackexchange.com/questions/2710/switching-between-window-layouts

;;; Commentary:


;;; Code:

(defvar winstack-stack '()
  "A Stack holding window configurations.  Use `winstack-push' and `winstack-pop' to modify it.")

(defun winstack-push()
  "Push the current window configuration onto `winstack-stack'."
  (interactive)
  (if (and (window-configuration-p (first winstack-stack))
           (compare-window-configurations (first winstack-stack) (current-window-configuration)))
      (message "Current config already pushed")
    (progn (push (current-window-configuration) winstack-stack)
           (message (concat "pushed " (number-to-string
                                       (length (window-list (selected-frame)))) " frame config")))))

(defun winstack-pop()
  "Pop the last window configuration off `winstack-stack' and apply it."
  (interactive)
  (if (first winstack-stack)
      (progn (set-window-configuration (pop winstack-stack))
             (message "popped"))
    (message "End of window stack")))

(defun winstack-clear()
  "Clears 'winstack-stack' and does not apply it."
  (interactive)
  (progn
    (setq winstack-stack '())
    (message "Stack Cleared")))

(provide 'setup-winstack)
;;; setup-winstack.el ends here
