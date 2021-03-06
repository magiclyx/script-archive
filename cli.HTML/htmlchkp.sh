#!/bin/sh
#
# Shell script to run htmlchek.pl with options checking.
#
nonvar='NO'
for px
do
 case $px
 in -?* ) echo "You are passing flags to the perl interpreter in argument $px"
          echo "(This may not be what you intended)";;
    *=* ) if   test $nonvar = 'YES'
          then echo "Error: An option=value argument $px followed"
               echo "a filename argument on the command line."
               exit 1
          else
            case $px
            in append=* | arena=* | configfile=* | deprecated=* |\
               dirprefix=* | html3=* | htmlplus=* | loosepair=* |\
               lowlevelnonpair=* | lowlevelpair=* | netscape=* | nonblock=* |\
               nonpair=* | nonrecurpair=* | nowswarn=* | refsfile=* |\
               reqopts=* | strictpair=* | sugar=* | tagopts=* | usebase=* ) ;;
             * ) echo "Error: In the option=value argument $px, the part"
                 echo "before the equals sign \`=' is not a recognized option."
                 exit 1;;
            esac
          fi;;
      * ) nonvar='YES';;
 esac
done
#
case ${HTMLCHEK:-"/"}
  in */ )
    if test -s ${HTMLCHEK}htmlchek.pl
    then
        echo "Checking file(s) now... (using perl)"
        perl ${HTMLCHEK}htmlchek.pl $@
    else
        echo "htmlchek.pl is not found.  Either copy it to the current directory, or
set the environment variable HTMLCHEK to the pathname where it is located
(this should terminate with a \`/' character).  Do \`setenv HTMLCHEK /somedir/'
in csh and tcsh, \`HTMLCHEK=/somedir/;export HTMLCHEK' in sh and its offspring."
        exit 1
    fi;;
  * ) echo "Environment variable HTMLCHEK does not end in \`/'"
      exit 1;;
esac
exit 0
