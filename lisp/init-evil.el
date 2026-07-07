;;; init-evil.el --- Vim-style modal editing with Evil -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Store more undo history to prevent loss of data.  Evil relies heavily
;; on undo, so give it plenty of room.
(setq undo-limit 8000000
      undo-strong-limit 8000000
      undo-outer-limit 8000000)

;; `evil-want-keybinding' must be set to nil *before* evil loads so that
;; evil-collection can manage keybindings across the many built-in modes.
(setq evil-want-keybinding nil)
(setq evil-want-integration t)
;; Use the built-in `undo-redo' (Emacs 28+) as the undo system, so C-r
;; redoes as expected without an extra package.
(setq evil-undo-system 'undo-redo)
;; More intuitive C-u (scroll up) and Y (yank to end of line) behaviour.
(setq evil-want-C-u-scroll t)
(setq evil-want-Y-yank-to-eol t)

(when (require-package 'evil)
  (require 'evil)
  (evil-mode 1)

  ;; Consistent Vim keybindings inside dozens of built-in/third-party
  ;; modes (dired, magit, ibuffer, help, etc.).
  (when (require-package 'evil-collection)
    (with-eval-after-load 'evil
      (evil-collection-init)))

  ;; cs"'  ds(  ysiw)  — operate on surrounding pairs.
  (when (require-package 'evil-surround)
    (global-evil-surround-mode 1))

  ;; gc to comment/uncomment in a Vim-friendly way.
  (when (require-package 'evil-nerd-commenter)
    (with-eval-after-load 'evil
      (evil-define-key '(normal visual) 'global
        (kbd "gc") 'evilnc-comment-or-uncomment-lines)))

  ;; Use Emacs (non-modal) editing in a few buffers where modal editing
  ;; gets in the way.
  (dolist (mode '(term-mode
                  eat-mode
                  vterm-mode
                  eshell-mode
                  shell-mode
                  git-rebase-mode))
    (add-to-list 'evil-emacs-state-modes mode))

  ;; Keep the familiar Emacs "\C-c" prefix etc. even in normal state by
  ;; letting some common Emacs bindings pass through.
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "TAB") nil)))


(provide 'init-evil)
;;; init-evil.el ends here
