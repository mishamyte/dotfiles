#!/bin/bash
# Generate bash completion files

mkdir -p ~/bash_completion.d

# Git completions
if command -v git &>/dev/null; then
    curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
        -o ~/bash_completion.d/git
    echo "Installed git bash completions"
fi

# kubectl completions
if command -v kubectl &>/dev/null; then
    kubectl completion bash > ~/bash_completion.d/kubectl
    echo "Installed kubectl bash completions"
fi
