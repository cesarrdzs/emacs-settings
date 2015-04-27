(require 'moz)
 
;; This gist is just a combination of two gists that @nonsequitur thought up in 2010:
;; https://gist.github.com/nonsequitur/442376
;; https://gist.github.com/nonsequitur/666092
;; One-line change was made to support recent emacs requirement of 'provide' function (@ bottom)
 
;;; Usage
;; Run M-x moz-reload-mode to switch moz-reload on/off in the
;; current buffer.
;; When active, every change in the buffer triggers Firefox
;; to reload its current page.

(define-minor-mode moz-reload-mode"Moz Reload Minor Mode"
nil " Reload" nil(if moz-reload-mode;; Edit hook buffer-locally.
(add-hook 'post-command-hook 'moz-reload nil t)
(remove-hook 'post-command-hook 'moz-reload t)))
 
(defun moz-reload ()
(when (buffer-modified-p)
(save-buffer)
(moz-firefox-reload)))
 
(defun moz-firefox-reload ()
(comint-send-string (inferior-moz-process) "BrowserReload();"))
 
;;; Usage;; Run M-x moz-reload-on-save-mode to switch moz-reload on/off in the;; current buffer.
;; When active, saving the buffer triggers firefox-reload;; to reload its current page.
 
(define-minor-mode moz-reload-on-save-mode"Moz Reload On Save Minor Mode"
nil " Reload" nil(if moz-reload-on-save-mode;; Edit hook buffer-locally.
(add-hook 'after-save-hook 'moz-firefox-reload nil t)
(remove-hook 'after-save-hook 'moz-firefox-reload t)))
 
(defun moz-firefox-reload ()
(comint-send-string (inferior-moz-process) "BrowserReload();"))
 
(provide 'moz-reload-mode)
