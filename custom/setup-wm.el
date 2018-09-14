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
  (exwm-config-default))

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  :init
  (progn
    (require 'exwm-systemtray)
    (exwm-systemtray-enable)

    (require 'helm-exwm)

    (use-package gpastel
      :ensure t)

    (use-package desktop-environment
      :ensure t
      :init
      (progn
        (desktop-environment-mode)
        (setq desktop-environment-volume-get-command "pactl list sinks | grep 'Volume: f' | cut -c30-34")
        (setq desktop-environment-volume-toggle-command "pactl set-sink-mute 0 toggle")
        (setq desktop-environment-volume-toggle-microphone-command "pactl set-source-mute 0 toggle")
        (setq desktop-environment-screenshot-command "gnome-screenshot")
        (setq desktop-environment-screenshot-partial-command "gnome-screenshot -a")
        (setq desktop-environment-brightness-get-command "cat /sys/class/backlight/acpi_video0/brightness")
        (setq  desktop-environment-brightness-get-regexp "\\([0-9]+\\)")
        (define-key desktop-environment-mode-map (kbd "<XF86MonBrightnessUp>") nil)
        (define-key desktop-environment-mode-map (kbd "<XF86MonBrightnessDown>") nil)
        (define-key desktop-environment-mode-map (kbd "S-<XF86MonBrightnessUp>") nil)
        (define-key desktop-environment-mode-map (kbd "S-<XF86MonBrightnessDown>") nil)))

    (use-package exwm-edit
      :config
      (require 'markdown-mode)
      (defun ag-exwm/on-exwm-edit-compose ()
        ;;(spacemacs/toggle-visual-line-navigation-on)
        (markdown-mode))

      (add-hook 'exwm-edit-compose-hook 'ag-exwm/on-exwm-edit-compose))

    (require 'exwm-randr)
    (defvar exwm-randr-workspace-output-plist)
    (setq exwm-randr-workspace-output-plist '(0 "VGA1"))
    (add-hook 'exwm-randr-screen-change-hook
              (lambda ()
                (start-process-shell-command
                 "xrandr" nil "xrandr --output VGA1 --left-of LVDS1 --auto")))
    (exwm-randr-enable)))

(provide 'setup-wm)
;;; setup-wm.el ends here
