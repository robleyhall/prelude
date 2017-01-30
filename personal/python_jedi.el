(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook 'run-python)

;; Now hook everything up
;; Hook up to autocomplete
;;(add-to-list 'ac-sources 'ac-source-jedi-direct)

;; Enable Jedi setup on mode start
(add-hook 'python-mode-hook 'jedi:setup)

;; Buffer-specific server options
(add-hook 'python-mode-hook
          'jedi-config:setup-server-args)
;; (when jedi-config:use-system-python
;;   (add-hook 'python-mode-hook
;;             'jedi-config:set-python-executable))

;; And custom keybindings
(defun jedi-config:setup-keys ()
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "M-?") 'jedi:show-doc)
  (local-set-key (kbd "M-/") 'jedi:get-in-function-call))

;; Don't let tooltip show up automatically
(setq jedi:get-in-function-call-delay 10000000)
;; Start completion at method dot
(setq jedi:complete-on-dot t)
;; Use custom keybinds
(add-hook 'python-mode-hook 'jedi-config:setup-keys)
