# asdf - extendable version manager

# https://github.com/asdf-vm/asdf
# https://github.com/asdf-vm/asdf-plugins


# For most plugins, it is good if you have installed the following packages:
# 
#sudo apt install automake autoconf libreadline-dev libncurses-dev libssl-dev
#sudo apt install libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev


# SETUP
# =====

# Copy-paste the following into command line:
#
#git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.1


# Depending on your OS and shell, run the following:

# Bash
#
#echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
#echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

# Zsh:
# If you are using a framework, such as oh-my-zsh, use these lines. 
# (Be sure that if you make future changes to .zshrc these lines remain below the
# line where you source your framework.)
#
#echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
#echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
#
# If you are not using a framework, or if on starting your shell you get an 
# error message like 'command not found: compinit', then add this line before 
# the ones above.
#
#autoload -Uz compinit && compinit

# Fish:
#
#
#echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish
#mkdir -p ~/.config/fish/completions; and cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
#



