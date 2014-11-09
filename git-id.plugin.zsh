git() {
  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 && git-id
  command git $@
}

git-id() {
  _git-id-get-id

  # Array compatibility for ZSH
  [ -n "$ZSH_VERSION" ] && set -o KSH_ARRAYS

  [ "${GIT_ID[0]}" != "GIT_ID_NULL" ] \
    && [ "$(command git config user.name)" != "${GIT_ID[0]}" ] \
    && echo "Setting local git user name to ${GIT_ID[0]}" \
    && $(command git config --local user.name ${GIT_ID[0]})
  [ "${GIT_ID[1]}" != "GIT_ID_NULL" ] \
    && [ "$(command git config user.email)" != "${GIT_ID[1]}" ] \
    && echo "Setting local git user email to ${GIT_ID[1]}" \
    && $(command git config --local user.email ${GIT_ID[1]})

  unset GIT_ID
}

_git-id-get-id() {
  IFS=$'\n'
  set -f
  GIT_ID=($(ruby -e "
    require 'yaml'
    conf = YAML.load_file(File.expand_path('~/.gitid.yml'))
    dir = Dir.pwd.split('/')
    id = {}
    while dir.length > 1
      if conf[File.join(dir)]
        id = conf[File.join(dir)]
        break
      end
      dir.pop
    end
    print \"#{id['name'] || 'GIT_ID_NULL'}\n#{id['email'] || 'GIT_ID_NULL'}\"
  "))
  unset IFS
  set +f
}
