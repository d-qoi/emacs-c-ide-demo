;;; package --- setup for EXWM
;;; Commentary:
; Mostly for EXWM

;;; Code:
(require 'cl-generic)
(require 'ecb)

(defun cust-exwm-start ()
  "To start from the command line."
  (require 'exwm)
  (require 'exwm-config)
  (exwm-config-cust))

(defun exwm-config-cust ()
  "Modified default configuration of EXWM."
  ;; Set the initial workspace number.
  (setq exwm-workspace-number 4)
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  ;; 's-r': Reset
  (exwm-input-set-key (kbd "s-r") #'exwm-reset)
  ;; 's-w': Switch workspace
  (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)

  ;; 's-N': Switch to certain workspace
  (dotimes (i 10)
    (exwm-input-set-key (kbd (format "s-%d" i))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-switch-create ,i))))
  ;; 's-d': Launch application
  (exwm-input-set-key (kbd "s-d")
                      (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command)))
  ;; Line-editing shortcuts
  (setq exwm-input-simulation-keys
        '(([?\C-b] . [left])
          ([?\C-f] . [right])
          ([?\C-p] . [up])
          ([?\C-n] . [down])
          ([?\C-a] . [home])
          ([?\C-e] . [end])
          ([?\M-v] . [prior])
          ([?\C-v] . [next])
          ([?\C-d] . [delete])
          ([?\C-k] . [S-end delete])))
  ;; Enable EXWM
  (exwm-enable)
  ;; Configure Ido
  (exwm-config-ido)
  ;; Other configurations
  (exwm-config-misc))

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  :init
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (require 'helm-exwm)
  (global-set-key (kbd "<s-tab>") 'helm-exwm)

  (add-hook 'exwm-edit-compose-hook 'ag-exwm/on-exwm-edit-compose)

  (add-hook 'exwm-manage-finish-hook
            (lambda ()
              (when (and exwm-class-name
                         (string= exwm-class-name "XTerm"))
                (exwm-input-set-local-simulation-keys '(([?\C-c ?\C-c] . ?\C-c))))))
  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(0 "VGA1"))
  (defvar exwm-randr-workspace-output-plist)
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command
               "xrandr" nil "xrandr --output VGA1 --left-of LVDS1 --auto")))
  (exwm-randr-enable))

(use-package desktop-environment
  :after exwm
  :custom
  (desktop-environment-volume-get-command "pactl list sinks | grep 'Volume: f' | cut -c30-34")
  (desktop-environment-volume-toggle-command "pactl set-sink-mute 0 toggle")
  (desktop-environment-volume-toggle-microphone-command "pactl set-source-mute 0 toggle")
  (desktop-environment-screenshot-command "gnome-screenshot")
  (desktop-environment-screenshot-partial-command "gnome-screenshot -a")
  (desktop-environment-brightness-get-command "cat /sys/class/backlight/acpi_video0/brightness")
  (desktop-environment-brightness-get-regexp "\\([0-9]+\\)")
  :bind
  (:map desktop-environment-mode-map
        ("<XF86MonBrightnessUp>" . nil)
        ("<XF86MonBrightnessDown>" . nil)
        ("S-<XF86MonBrightnessUp>" . nil)
        ("S-<XF86MonBrightnessDown>" . nil))
  :config
  (desktop-environment-mode))

(use-package gpastel
  :after exwm)

(use-package exwm-edit
  :after exwm
  :config
  (require 'markdown-mode)
  (defun ag-exwm/on-exwm-edit-compose ()
    ;;(spacemacs/toggle-visual-line-navigation-on)
    (markdown-mode)))

(provide 'setup-wm)
;;; setup-wm.el ends here
