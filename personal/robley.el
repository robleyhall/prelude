;;; package: --- Summary: personal customizations for emacs-prelude
;;; commentary:
;;;

;;; Code:
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


(setq exec-path (append '("/usr/local/bin") exec-path ))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;;;
;;; --- tramp ---
;;;
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave")
;; following allows for /sudo:root@aws-clown:/data/purescale/smash/
;; when userid root cannot be used directly
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;;;
;;; --- org-mode ---
;;;
(global-set-key [(control ?\')] 'org-cycle-agenda-files)
(setq org-directory "~/Documents/org-files")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
;;;(setq org-agenda-files (list "~/notes" "~/71notes"))
(setq org-agenda-files (list
                        (concat org-directory "/notes.org")
                        (concat org-directory  "/tornado.org")))

(setq org-archive-files (list
                         "~/Documents/org-archive/pureapp_archive.org"))
(setq org-refile-targets '(
                           (org-agenda-files . (:level . 1))
                           (org-archive-files . (:level . 1))
                           ))

(setq org-capture-templates
      '(
	("n" "Note" entry (file+datetree "~/Documents/org-files/notes.org")
         "* %?\n   Entered on %U\n  %i\n  %a" :clock-in t :clock-resume t)

        )
      )



;;;
;;; --- softlayer things ---
;;;
(defun sl-api-key ()
  "Insert the sl api key."
  (interactive)
  (insert "44298671d5cc105f7711306278c48e845422c315ce440d119dabb608359456d4"))
(key-chord-define-global "^^" 'slapi-api-key)



(defun millis-to-date-display (millis)
  (interactive "Menter millis value: ")
  (message "%s" (format-time-string "%Y-%m-%d %T"
                                          (seconds-to-time
                                           (string-to-number
                                            ;; make sure we've got the right number of digits for
                                            ;; contemporary times
                                            (substring (concat millis "0000000000") 0 10))))))

(defun millis-to-date (millis)
  (interactive "Menter millis value: ")
  (format-time-string "%Y-%m-%d %T"
                      (seconds-to-time
                       (string-to-number
                        ;; make sure we've got the right number of digits for
                        ;; contemporary times
                        (substring (concat millis "0000000000") 0 10)))))


(defun millis-at-point ()
  (interactive)
  (let* ((time (thing-at-point 'word))
        (rh/millis-display (format "%s : %s" time (millis-to-date time)))
        )
    (message rh/millis-display)
    (kill-new rh/millis-display)
    )
  )

(defun insert-millis-at-point ()
  (interactive)
  (let* ((time (thing-at-point 'word))
        (rh/millis-display (format " - %s" (millis-to-date time)))
        )
    (insert rh/millis-display)
    (kill-new rh/millis-display)
    )
  )

(provide 'robley)
;;; robley.el ends here
