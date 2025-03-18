## Installation:

- Make sure that there is no conflicting dotfiles and you have backed up your dotfiles.

- Clone the repo using the following command:

```bash
git clone https://github.com/mlhktp/dotfiles.git
```

- Use *stow* to install the dotfiles:

```bash
cd dotfiles
stow .
```


## Todos:

### Dunst:
- [x] Change *dunst* and polybar width
- [x] Make *dunst* transparent


### Polybar:
- [ ] Edit *Polybar* workspace module
- [ ] Add vivado icon to *Polybar*
- [x] *Polybar* change the size of the title module.
- [ ] *Polybar* change workspace active and inactive colors
- [ ] *Polybar* fix volume percentage
- [ ] Add weather module to *Polybar*

### Rofi:
- [x] *Rofi* theme selection bigger theme images

### Other:
- [x] *tmux* change the size of vertical and horizontal panes
- [x] disable *tmux* by default
- [ ] *wal* change to darker backgrounds after specific times of the day.
- [ ] Add a script for *crontab* jobs.
- [ ] Fix the bluetooth script.
- [x] Change the content on the screens.
- [ ] Add focus option to one of the applications on the screen.


## Long-Term Goals:

- [ ] Add a script to install all the dependencies - partially done for *Arch Linux*
- [ ] Add a script to backup all the current dotfiles on the system and install this repo's dotfiles - partially done for *Arch Linux*
- [ ] Update scripts to check available changes in the repo and update the dotfiles accordingly
- [ ] Switch dotfiles theme using branches
- [ ] Add a script to automatically capture screenshots to showcase the dotfiles
- [ ] Add spotify integration to polybar
- [ ] Add copilot as a pop-up screen like rofi
- [ ] *Polybar* workspace module popup to show all workspaces when hovered
- [ ] Add A-Tab to show all open windows
- [ ] Add apps button
- [ ] Add help button

## Credits:

- This repo is adopted from Nighty3098's dotfiles repo. You may find the link to his repo [here](https://github.com/Nighty3098/DevDotfiles/)
