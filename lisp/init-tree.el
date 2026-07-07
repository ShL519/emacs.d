;;; init-tree.el --- Directory tree sidebar via neotree -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'neotree)
  (setq-default neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq-default neo-smart-open t)
  (global-set-key (kbd "<f8>") 'neotree-toggle))

(provide 'init-tree)
;;; init-tree.el ends here
