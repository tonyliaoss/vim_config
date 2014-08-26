# Vim Swap File Cleaner

### Overview
Vim is awesome. But sometimes, when your program crashes you may end up with
undeleted .swp files. This is fine if you only have one or two files. But if
you are on a system that crashes every so often, eventually you are going to
have a directory filled with these .swp files. Not very desirable eh?

This is a command line tool, written in bash script, that finds all .swp files
in a subdirectory and deletes them. You may call it in the top-level directory,
or you may use the -d flag to pass the top level directory. Detailed usage is
described below.

### Usage
```
swpclean [-f | -v] [-g <grep_expression>| -d <dir>]
```
You may run this script without any arguments, in which case it will simply
recurse down the current directory, and ask you for permission before it
removes any swap files.

##### Options
You may also run it with the following options:
* -h|--help
  * Prints out the help message.
* -f|--force-delete
  * Does not ask for your permission before deleting the swap files.
* -v|--verbose
  * A loquacious version of the script.
* -g|--use-grep <grep_expression>
  * Uses user-provided grep expression in its search.
  * The default grep pattern searches for .swp, .swo, ... files, since vim
    creates additional swap files when .swp is taken.
* -d|--use-directory <dir>
  * Uses the user-specified directory dir as top level directory
  * The default top-level directory is the current working directory.

### Installation
Not really an installation per se, but you can define a bash/csh runtime alias.

First download this script into your home directory:
```
$ cp swp_clean.sh ~/swp_clean.sh
```

Then change its permission so that it is executable:
```
$ chmod 744 ~/swp_clean.sh
```

And then, open up your ~/.bash_profile (or ~/.cshrc if you use C shell) with your
favorite text editor:
```
$ vim ~/.bash_profile
```
or
```
$ vim ~/.cshrc
```

And add one of the following lines:
```
alias vclean=~/swp_clean.sh # if you use bash
alias vclean ~/swp_clean.sh # if you use csh
```

### System Requirements
You need to have find and you need to have grep. End of story.

You can check if you have these in your execution path by typing
```
$ which find
```
or similarly
```
$ which grep
```
in your shell.

