# Completions


- bash_completion - programmable completion functions for bash 4.1+
- http://bash-completion.alioth.debian.org/
- RELEASE: 2.1


The bash_completion package:
`/usr/share/bash-completion/bash_completion`

The file `/etc/bash-completion` sources the main bash_completion package:
`. /usr/share/bash-completion/bash_completion`
it is called by file below.

The file `/etc/bash.bashrc` contains the fragment to
enable bash completion in interactive, non-posix mode, shell

```bash
if ! shopt -oq posix; then

  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
  
fi
```

There is also `/etc/bash_completion.d` dir for dropping compl files.
Following the usual convention completions are also probably also
auto-sourced from parallel user dir `$HOME/.bash_completion.d`

