(require 'url)

(require 'network-stream)
(require 'erc-backend)

(setq erc-keywords '(
;;                     "\\bclojure\\b"
                     ".*robley.*"
                     ))

(require 'erc-match)
(erc-match-mode)

(setq erc-server "raleigh.irc.ibm.com")
(setq erc-nick "robley")
(setq erc-password "robley")
(setq erc-prompt (lambda ()
                   (if (and (boundp 'erc-default-recipients) (erc-default-target))
                       (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
                     (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))

(setq erc-autojoin-channels-alist
          '(("freenode" . ("#clojure" "##groovy"))
            ("raleigh" . ("#ipas_dr"))))

;(add-hook 'erc-text-matched-hook 'erc-beep-on-match)
(setq erc-beep-match-types '(current-nick keyword))

;; (add-hook 'erc-text-matched-hook
;;               (lambda (match-type nickuserhost message)
;;                 (cond
;;                   ((eq match-type 'current-nick)
;;                     (start-process-shell-command "devnullsoundbuffer" nil "aplay /usr/share/sounds/purple/login.wav"))
;;                   ((eq match-type 'keyword)
;;                    (start-process-shell-command "devnullsoundbuffer" nil "aplay /usr/share/sounds/purple/login.wav")))))

(setq erc-keyword-highlight-type 'nick-or-keyword)

(setq erc-replace-alist
      '(("joined" . "JOINED")
        ("quit" . "bugged out")
        ))


(defun cotse-tunnel ()
  (interactive)
  (let ((buffname "cotse"))
    (if (get-buffer buffname)
        (message (concat "Forwarding already set up for " buffname "."))
      (shell-command "ssh -D 1080 rrh@tunnel1.cotse.net &" "cotse")
      (switch-to-buffer buffname)
      (delete-other-windows)
      ;; (if (not (waiting-for-user-input-p)
      ;;          (socks-open-network-stream name buffer host service)
      ;;          ))
      )))

  ;; (let ((buffname "cotse"))
  ;;   (if (get-buffer buffname)
  ;;       (message (concat "Forwarding already set up for " buffname "."))
  ;;     (shell-command "ssh -D 1080 rrh@tunnel1.cotse.net & \"cotse\"")
  ;;     (switch-to-buffer buffname))
  ;;   (socks-open-network-stream)))

;; to use socks tunnel with externally defined tunnel use this
;; ((erc-server-connect-function 'socks-open-network-stream)

(defun connect-irc-freenode ()
  (interactive)
  (let ((erc-server-connect-function 'socks-open-network-stream)
;        (socks-override-functions 1)
        (socks-server '("Tunnel" "localhost" 1080 5)))
    (if (not (featurep 'socks))
        (require 'socks))
    (erc :server "irc.freenode.net"
         :port 6667
         :nick "rhall"
         :password "23$e-r-c"
         :full-name "rhall"
         )))



(provide 'init-erc)
