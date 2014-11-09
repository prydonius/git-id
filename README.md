# git-id

No more manual local git user configuration.

Switch between different git identities based on the directory you're currently in.

## Prerequisites

* ruby

## Installation

The script is provided as an oh-my-zsh plugin, so if you're using that you can clone this repository into `$ZSH_CUSTOM/plugins`.

Other than that, it is just a bash script, and so you can just `source` it from your usual shell configuration.

## Configuration

git-id looks for a `.gitid.yml` file in your home folder. Here is an example file:

```
/Fun:
  name: Adnan Abdulhussein
  email: adnan@prydoni.us
/Projects:
  name: Adnan A
  email: adnan@bitnami.com
```
