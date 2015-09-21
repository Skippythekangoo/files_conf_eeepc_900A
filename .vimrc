"utilise les défauts de vim a la place de ceux de vi
set nocompatible

"numérotation des lignes
set number

"activation de la coloration syntaxique
syntax on

" Utilise le shell Bash
set shell=bash

"choix de la coloration syntaxique
"colorscheme morning
colorscheme default

" Remplace les tabulation par des espaces
set expandtab
filetype plugin indent on
set softtabstop=4
set shiftwidth=4

" Tabulation de 4 espaces
set tabstop=4

"indentation de type C
set cindent

"activation de l'auto indentation
set autoindent

"active les replis
set foldenable

"montre toujours la position du curseur
set ruler

"utilisation dela souris"
set mouse=a

" Encodage des fichiers en utf-8 par défaut
set encoding=utf-8

" Enleve l'ondentation automatique suite à un copier-coller d'une appli
" graphique
set paste

" Active la correction orthographique pour tout les fichiers
"setlocal spell spelllang=fr

" Edite automatiquement les fichiers de conf de conky
au BufNewFile,BufRead *conkyrc* set filetype=conkyrc
" Édite automatiquement les nouveaux fichiers PKGBUILD
au BufNewFile PKGBUILD 0r ~/.vim/templates/PKGBUILD

" Édite automatiquement les nouveaux fichiers bash
au BufNewfile *.sh 0r ~/.vim/templates/sh

" Édite automatiquement les nouveaux fichiers python
au BufNewfile *.py 0r ~/.vim/templates/python

" Fonction de 'nettoyage' d'un fichier :
" Suppression des caractères ^M en fin de ligne
function! CleanCode()
    %s/^M//g
    call s:DisplayStatus('Code nettoyé')
endfunction

" Ouverture des fichiers avec le curseur à la position de la dernière édition
function! s:Cursor0ldPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal g`\""
    endif
endfunction
autocmd BufReadPost * silent! call s:CursorOldPosition()

"Fichier de sauvergarde avec extention .bak"
set backup
set backupext=.$(date).bak
set backupdir=~/.backup_file

if !has("gui_running")
	if &term == "rxvt-unicode"
		let &t_SI = "\033]12;red\007"
		let &t_EI = "\033]12;green\007"

		:silent !echo -ne "\033]12; green\007"
		autocmd VimLeave * :silent :!echo -ne "\033]12;green\007"
	endif
	if &term == "screen"
		let &t_SI = "\033P\033]12;red\007\033\\"
		let &t_EI = "\033P\033]12;green\007\033\\"

		:silent !echo -ne "\033P\033]12;green\007\033\\"
		autocmd VimLeave * :silent :!echo -ne "\033P\033]12;green\007\033\\"
	endif
endif

""""""""""""""""""""""""""""""""""""""
"Charge le plugin pour les fiches man"
""""""""""""""""""""""""""""""""""""""
runtime ftplugin/man.vim

"""""""""""""""""
"Commandes perso"
"""""""""""""""""
command! EditVimrc :tabnew $HOME/.vimrc
command! EditBashrc :tabnew $HOME/.bashrc

""""""""""""""""""""""""
"Raccourcis clavier perso"
""""""""""""""""""""""""

"ouvre un nouvel onglet vierge
map gn :tabnew<CR>

"ouvre un fichier dans un nouvel onglet
map go :tabnew

"recharge le fichier de configuration
map <F2> :source $HOME/.vimrc<CR>

" Edite le fichier de configuration ~/.vimrc
map <F3> :EditVimrc<CR>

" Edite le fichier de configuration ~/.bashrc
map <F4> :EditBashrc<CR>

"des/activation de la correction orthographique fr*/*/*/
map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

"substitution de Ctrl-AltGr-] par )
map ) 

"onglet suivant"
map <C-l> :tabnext<CR>
imap <C-l> :tabnext<CR>
"onglet précédent"
map <C-h> :tabprevious<CR>
imap <C-h> :tabprevious<CR>
