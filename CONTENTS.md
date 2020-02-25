# Contents

Chapter 2 is done translating. Now translating chap. 1 and 3. The sections with no link aren't translated yet.


## [Chapter 1. The Compatible Shell Syntax](1)

1. ["`#!`" -- "First of First" of Your Shell Script](1/-2321_shebang.md#----first-of-first-of-your-shell-script)
   1. [Can I Use "`#!/bin/sh`"?](1/-2321_shebang.md#can-i-use-binsh)
   1. [What Should I Write at The Top of Shell Scripts?](1/-2321_shebang.md#what-should-i-write-at-the-top-of-shell-scripts)
1. ["`$(`...`)`" Operator](1/-2428_dollar_parenthes.md#-operator)
   1. [Should Not Use the "case" Construction in This Operator](1/-2428_dollar_parenthes.md#should-not-use-the-case-construction-in-this-operator)
   1. [Put $$ in Double Quotation in This Operator](1/-2428_dollar_parenthes.md#put--in-double-quotation-in-this-operator)
1. "`$*`" And "`$@`" Variables
1. "/dev/random" File
1. "/dev/std{in,out,err}" Files
1. "/dev/urandom" File
1. "`[:`...`:]`" (POSIX Character Class)
1. "`[^`...`]`" (Pattern Matching Notation for Shell)
1. "`` ` ``...`` ` ``" (backquotes) Operator
1. "case" Construct
1. "if" Construct
1. "local" Modifier
1. Locale
1. "PIPESTATUS", "pipestatus" Variable
1. POSIX Character Class
1. Random Numbers
1. Regular Expression
1. Scope of Shell Objects
1. "`set -m`" ("-m" Option of "set" Command)
1. Shell Variables
1. Textdata Without LF-terminator in Last Line

## [Chapter 2. The Compatible Regular Expression](2)

1. [Just 3 Metacharacter Sets You Have to Learn](2/00_3_metachar_set.md#just-3-metacharacter-sets-you-have-to-learn)
   1. [Which Set Does Each Command Support Respectively?](2/00_3_metachar_set.md#which-set-does-each-command-support-respectively)
1. [BRE Metacharacter Set](2/11_BRE.md#bre-metacharacter-set)
   1. [Matching Metacharacters](2/11_BRE.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](2/11_BRE.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](2/11_BRE.md#replacing-metacharacters)
1. [ERE Metacharacter Set](2/12_ERE.md#ere-metacharacter-set)
   1. [Matching Metacharacters](2/12_ERE.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](2/12_ERE.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](2/12_ERE.md#replacing-metacharacters)
1. [AWK's Subset of ERE Metacharacters](2/13_AWK_subset.md#awks-subset-of-ere-metacharacters)
   1. [Matching Metacharacters](2/13_AWK_subset.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](2/13_AWK_subset.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](2/13_AWK_subset.md#replacing-metacharacters)
1. [Notes](2/21_notes.md#notes)
   1. [`|`: OR Operator](2/21_notes.md#-or-operator)

## [Chapter 3. The Compatible Commands And Usages](3)

1. "`[`" (test) Command
1. AWK Command
1. "base64" Command
1. "bc" Command
1. ["date" Command](3/date.md#date-command)
   1. [To do the Mutual Transformation](3/date.md#to-do-the-mutual-transformation)
1. "du" Command
1. "echo" Command
1. "env" Command
1. "exec" Command
1. "fold" Command
1. "grep" Command
1. "head" Command
1. "iconv" Command
1. "ifconfig" Command
1. "kill" Command
1. "ls" Command
1. "mktemp" Command
1. "nl" Command
1. "od" Command
1. ["pax" Command](3/pax.md#pax-command)
   1. [But Not So Popular](3/pax.md#but-not-so-popular)
1. "printf" Command
1. ["ps" Command](3/ps.md#ps-command)
   1. [Use "-A" Option Instead of "-x"](3/ps.md#use--a-option-instead-of--x)
   1. [Should Not Use "-l" Option](3/ps.md#should-not-use--l-option)
   1. [Always Use "-o" Option to Define Format Clearly](3/ps.md#always-use--o-option-to-define-format-clearly)
   1. [Sup.1 PPID Number](3/ps.md#sup1-ppid-number)
   1. [Sup.2 ps Command on Cygwin](3/ps.md#sup2-ps-command-on-cygwin)
1. ["pwd" Command](3/pwd.md#pwd-command)
   1. [POSIX Incompliant Implementaions](3/pwd.md#posix-incompliant-implementaions)
   1. [Solution](3/pwd.md#solution)
1. "readlink" Command
1. ["sed" Command](3/sed.md#sed-command)
   1. [Behavior When Given Text Data Doesn't Terminate with LF](3/sed.md#behavior-when-given-text-data-doesnt-terminate-with-lf)
   1. [Available Metacharacters in Regular Expression](3/sed.md#available-metacharacters-in-regular-expression)
   1. ["-" Does Not Always Mean the STDIN Symbol](3/sed.md#--does-not-always-mean-the-stdin-symbol)
   1. [Locale](3/sed.md#locale)
1. "sleep" Command
1. "sort" Command
1. "tac" Command
1. "tail" Command
1. ["tar" Command](3/tar.md#tar-command)
1. "test" (`[`) Command
1. ["time" Command](3/time.md#time-command)
   1. [How to Use It Safely](3/time.md#how-to-use-it-safely)
1. ["tr" Command](3/tr.md#tr-command)
   1. [In Case of Having Two Pairs of Brackets Arguments](3/tr.md#in-case-of-having-two-pairs-of-brackets-arguments)
   1. [In Case of Having Only One Pair](3/tr.md#in-case-of-having-only-one-pair)
1. "trap" Command
1. "uuencode" And "uudecode" Commands
1. "which" Command
1. "xargs" Command
1. ["zcat" Command](3/zcat.md#zcat-command)
   1. [Important : In Case of Dealing with Small Files](3/zcat.md#important--in-case-of-dealing-with-small-files)
