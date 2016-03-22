# Shows an interactive prompt to select a git branch to checkout to

function peco-git-branch-checkout --description "Check out a branch interactively"
    git branch -a | peco --prompt="Checkout branch:" | tr -d ' ' > /tmp/branchname
    set selected_branch_name (cat /tmp/branchname)


    # Remove remote/ if its part of the branchname
    switch $selected_branch_name
    case '*-\>*'
        set selected_branch_name (echo $selected_branch_name | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')
    case 'remotes*'
        set selected_branch_name (echo $selected_branch_name | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')
    end

    # Do the actual checkout
    echo "Checking out $selected_branch_name"
    git checkout $selected_branch_name
end

# Define convenient aliases
alias branch peco-git-branch-checkout 
alias b peco-git-branch-checkout
