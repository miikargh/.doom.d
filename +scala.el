;;; +scala.el -*- lexical-binding: t; -*-

(defcustom spark-shell-buff-name "**spark-shell**" "name of spark-shell buffer")
(defcustom spark-shell-command "spark-shell" "command to launch spark-shell")

(defun open-spark-shell ()
  "Run an inferior instance of `spark-shell' inside Emacs."
  (interactive)
  (let* ((buffer (if (comint-check-proc spark-shell-buff-name)
                     (get-buffer spark-shell-buff-name)
                   (make-comint-in-buffer "spark-shell"
                                          spark-shell-buff-name spark-shell-command))))
    (display-buffer buffer)
    buffer))

(defun spark-shell-send-region (start end)
  (interactive "r")
  (comint-send-region spark-shell-buff-name start end))

(map! :map scala-mode-map
      :localleader
      (:prefix ("s" . "shell")
       :desc "Open Scala repl" "i" #'run-scala
       :desc "Send region to repl" "r" #'sbt-send-region
       :desc "Open spark-shell" "s" #'open-spark-shell
       :desc "Send region to spark-shell" "d" #'spark-shell-send-region
       )
      (:prefix ("f" . "shell")
       :desc "Format region or buffer" "a" #'scalariform-format-region-or-buffer))
