;;; package --- custom functions that don't have another place to go

;;; Code:

(defun revert-all-file-buffer ()
  "Refresh all open files buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffer containing files, which are not modified;
      ;; try not to revert non-file buffers
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename) ;; only revert if readable file
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes)
              (message "Reverted buffer: %s" filename))
          ;; otherwise kill buffer (file no longer exists)
          (let (kill-buffer-query-functions)
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finnished reverting all buffers"))

(defun kill-all-file-buffers ()
  "Kills all file buffers"
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      (when filename
        (let (kill-buffer-query-functions)
          (kill-buffer buf)
          (message "Killed %s" filename))))))


(require 'elpy)
(defun set-elpy-py3 ()
  (interactive)
  (elpy-disable)
  (setq python-shell-interpreter "python3")
  (setq elpy-rpc-python-command "python3")
  (elpy-enable))


(message "custom-functions loaded")
(provide 'custom-functions)
