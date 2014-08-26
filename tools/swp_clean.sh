#!/bin/bash

# bash script that recursively cleans all .swp files under the current
# directory.

CURR_DIR=`pwd`
GREP='\.sw[a-z]$'
RM_TARGET=`find $CURR_DIR | grep $GREP`

# default
if test $# -eq 0; then
  echo "cleaning *.swp files in and under $CURR_DIR ..."

  if [ -z $RM_TARGET ]; then
    echo "Did not find any swap files. Directory is clean."
  else
    rm -i $RM_TARGET
  fi

  exit 0
fi

# additional environment variables
FORCE=0           # boolean
VERBOSE=0         # boolean
USEGREP=$GREP     # string
USEDIR=$CURR_DIR  # string

# multiple command line flags
while test $# -gt 0; do
  case "$1" in
      -h|--help)
          echo "help!"
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
                USEGREP="$1"
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
    echo grep $USEGREP
    echo dir $USEDIR
    echo "Attemping to force clean all subdirectories with the grep pattern $GREP in top-level directory $USEDIR ..."
  fi

  RM_TARGET=`find $CURR_DIR | grep $GREP`

  if [ -z $RM_TARGET ]; then
    echo "Did not find any such files. Directory is clean."
  else
    rm -f $RM_TARGET
  fi

else
  if [ $VERBOSE -ne 0 ]; then
    echo force $FORCE
    echo verbose $VERBOSE
    echo grep $USEGREP
    echo dir $USEDIR
    echo "Attemping to clean all subdirectories with the grep pattern $GREP in top-level directory $USEDIR ..."
  fi

  RM_TARGET=`find $CURR_DIR | grep $GREP`

  if [ -z $RM_TARGET ]; then
    echo "Did not find any such files. Directory is clean."
  else
    rm -f $RM_TARGET
  fi
fi

