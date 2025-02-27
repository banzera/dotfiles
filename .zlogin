echo "sourcing .zlogin"

# chuck | cowthink -f stegosaurus | lolcat
https https://api.chucknorris.io/jokes/random | jq -r .value | cowthink -f stegosaurus | lolcat

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
