#!/bin/bash

# bash script that recursively cleans all .swp files under the current
# directory.

PACKAGE=swpclean
CURR_DIR=`pwd`
REGEX='.*.sw[a-z]$'

# default
if test $# -eq 0; then
  echo "cleaning *.swp files in and under $CURR_DIR ..."

  if [ -z $RM_TARGET ]; then
    echo "Did not find any swap files. Directory is clean."
  else
    find -name '.*.sw[a-z]' -exec rm -i {} \;
  fi

  exit 0
fi

# additional environment variables
FORCE=0           # boolean
VERBOSE=0         # boolean
USEREGEX=$REGEX     # string
USEDIR=$CURR_DIR  # string

# multiple command line flags
while test $# -gt 0; do
  case "$1" in
      -h|--help)
          echo "$PACKAGE help:"
	  echo " "
          echo "$PACKAGE [-f | -v] [-g <grep_expression>| -d <dir>]"
	  echo " "
          echo "Uses the find and grep utilities in Unix to delete swap files under a certain top-level directory."
	  echo " "
	  echo "The options are as follows:"
	  echo " "
	  echo "-f|--force-delete:"
	  echo "	  Force delete all found files when it can. Does not prompt for permission."
	  echo " "
	  echo "-v|--verbose :"
	  echo "	  Verbose mode."
	  echo " "
	  echo "-g|--use-grep <grep expression> :"
	  echo "	  Uses the user-provided grep expression when it is searching for
	  files to clean. If unspecified, the default is to search for files
	  ending in .sw? (such as .swp, .swo, etc.)."
	  echo "	  For safe usage, enclose the grep expression in single quotes."
	  echo " "
	  echo "-d|--use-directory <dir> :"
	  echo "	  Uses the user-specified directory as the top-level directory.
	  If unspecified, the default is to search for files in the current directory."
          exit 0
          ;;
      -f|--force-delete)
          FORCE=1
          shift
          ;;
      -v|--verbose)
          VERBOSE=1
          shift
          ;;
      -g|--use-grep)
          shift

          case $1 in
            -*)
                echo "Error (-g\|--use-grep): missing grep pattern"
                echo "Run --help for a manual."
                exit -2
                ;;
            *)
                USEREGEX="$1"
                shift
                ;;
          esac

          ;;
      -d|--use-directory)
          shift

          case $1 in
            -*)
                echo "Error (-d\|--use-directory): missing directory"
                echo "Run --help for a manual."
                exit -2
                ;;
            *)
                USEDIR="$1"
                shift
                ;;
          esac

          ;;
      *)
          echo "unknown argument: $1"
          exit -1
          ;;
  esac
done

# In actuality, it is just a one-line command.
if [ $FORCE -ne 0 ]; then
  if [ $VERBOSE -ne 0 ]; then
    echo force $FORCE
    echo verbose $VERBOSE
    echo grep $USEREGEX
    echo dir $USEDIR
    echo "Attemping to force clean all subdirectories with the grep pattern $REGEX in top-level directory $USEDIR ..."
  fi

  find -name '.*.sw[a-z]' -exec rm -f {} \;

else
  if [ $VERBOSE -ne 0 ]; then
    echo force $FORCE
    echo verbose $VERBOSE
    echo grep $USEREGEX
    echo dir $USEDIR
    echo "Attemping to clean all subdirectories with the grep pattern $REGEX in top-level directory $USEDIR ..."
  fi

  cd $USEDIR
  if [ $? -ne 0 ]; then
    echo "Error: cannot find the directory."
    exit -3
  else
    find -name '.*.sw[a-z]' -exec rm -i {} \;
  fi
    cd $CURR_DIR
fi

