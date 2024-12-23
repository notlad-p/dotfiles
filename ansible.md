## Installation Steps

1. Install ansible

```sh
pacman -S ansible
```

2. Install ansible requirements

```sh
ansible-galaxy collection install -r requirements.yml
```

---

## How to organize directory structure?

In root? This would clutter the root directory, but would make using `ansible-pull` easy.


## Usages:

- Install & configure all tools
    - Only separated item is AwesomeWM & Hyprland (by default use Awesome, use tag `hyprland` to switch to Hyprland)
- Install & configure *JUST* what you want. For example, use ansible to only install / configure NeoVim (and dependencies).
    - Use a `nvim` tag & others
- Install things that only I would use
    - Use `personal` tag when running
    - Creates `~/projects` directory
    - Uses `ansible-pull` to pull personal ansible repo 
        - Sets up with API keys and such
        - Clones personal projects

### Tags
Theses are the tags used in ansible, they can be used to only install and configure what you want. For example, if you want to only install and configure NeoVim and AwesomeWM:

```sh
ansible-playbook main.yml --tags "nvim, awesome"
```

You can also skip tags you don't want:

```sh
ansible-playbook main.yml --skip-tags "zsh"
```

#### List of tags:
- `personal` - Only useful for me to quickly configure personal stuff
- **Config tags**
    - `nvim` - Only install & configure NeoVim
    - `awesome` - Only 

---

## Personal setup

Setup git config / github cli? *This needs to be tested*
```yaml
# setup global git config (required for cloning repos later)
- name: Set git name
  community.general.git_config:
    name: user.name
    scope: global
    value: "Dalton Perkins"
- name: Set git email
  community.general.git_config:
    name: user.email
    scope: global
    value: contact@daltonp.dev
- name: Set git editor
  community.general.git_config:
    name: core.editor
    scope: global
    value: nvim

# NOTE: this doesn't work
# - name: Authenticate through GitHub CLI
#   ansible.builtin.shell: gh auth login
```
