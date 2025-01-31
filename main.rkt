#lang racket

;; Running this script will compile all of the existing templates into
;; a single templates/.all file.
;;
;; This is to simplify the process of getting a list of all templates
;; from the actual `raco new` command. Otherwise, it would need to read
;; each file individually, which is a lot of network requests.

(define (list-all-files path)
  (define (user-readable? f)
    (member 'read (file-or-directory-permissions f)))
  (for/list ([f (in-directory path user-readable?)])
    (path->string f)))

(define files
  (filter
    (lambda (f) (not (equal? "templates/.all" f)))
    (list-all-files "templates")))

(with-output-to-file
  "./templates/.all"
  #:exists 'replace
  (lambda ()
    (displayln "[")
    (for [(f files)]
      (displayln (string-trim (file->string f))))
    (displayln "]")
  ))