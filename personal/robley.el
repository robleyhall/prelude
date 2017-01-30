(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq prelude-whitespace nil)

(defun pprint-python-region ()
  "json.dumps over the currently selected region and display in a new buffer."
  (interactive)
  (let* (
         (name (file-name-nondirectory (buffer-file-name))) extracted-buffer)

    (if (string-match "\\.jar\\|\\.war\\|\\.bar\\|\\.zip\\|\\.zip" name)
	(progn
	  (setq extracted-buffer (archive-extract))
	  (setq name (file-name-nondirectory (buffer-file-name)))))

    (if (string-match "\\.class$" name)
	(let ((new-buffer-name (replace-match ".jad" nil nil name))
	      (tmp-name (concat "/tmp/" name)))
	  (write-file tmp-name)
	  (call-process "jad" nil new-buffer-name nil "-b" "-dead" "-ff" "-l60" "-space" "-t2" "-p" tmp-name)

	  (if extracted-buffer
	      (kill-buffer extracted-buffer))

	  (pop-to-buffer new-buffer-name)
	  (delete-other-windows)
	  (goto-char (point-min))))))

;;; sr-speedbar
(require 'sr-speedbar)

(setq speedbar-frame-parameters
      '((minibuffer)
	(width . 20)
	(border-width . 0)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(unsplittable . t)
	(left-fringe . 0)))
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-max-width 70)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width-console 40)

(when window-system
  (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
    (set-frame-width (selected-frame)
                     (+ (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)

  (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
    (sr-speedbar-recalculate-width)
    (set-frame-width (selected-frame)
                     (- (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))

(provide 'robley)



;;; robley.el ends here
