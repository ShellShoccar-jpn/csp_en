# Chapter 2. The Compatible Regular Expression

Have you ever had such an experience like that?

> You wrote a regular expression pattern string, and it worked on an OS or a command successfully. However, the string didn't work on another OS or command when you exported the shellscript, which contained the string. After all, you got confused by not knowing available metacharacters well.

The available metacharacters of regular expression (RE) are different depending on OSes or commands. There are many metacharacter sets on RE. For example, the sets depending on the following commands, such as sed, grep, AWK. Also, depending on the OS family, like System-V, BSD, GNU. You have to figure out the difference among them.

Don't worry. It's not so difficult because the metacharacter sets which you have to learn are only three for compatible shellscripts. The sets are almighty for not only shellscript but also all languages and libraries.

## Contents

1. [Just 3 Metacharacter Sets You Have to Learn](00_3_metachar_set.md)
   1. [Which Set Does Each Command Support Respectively?](00_3_metachar_set.md#which-set-does-each-command-support-respectively)
1. [BRE Metacharacter Set](11_BRE.md)
   1. [Matching Metacharacters](11_BRE.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](11_BRE.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](11_BRE.md#replacing-metacharacters)
1. [ERE Metacharacter Set](12_ERE.md)
   1. [Matching Metacharacters](12_ERE.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](12_ERE.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](12_ERE.md#replacing-metacharacters)
1. [AWK's Subset of ERE Metacharacters](13_AWK_subset.md)
   1. [Matching Metacharacters](13_AWK_subset.md#matching-metacharacters)
   1. [Matching Metacharacters Inside Brackets](13_AWK_subset.md#matching-metacharacters-inside-brackets)
   1. [Replacing Metacharacters](13_AWK_subset.md#replacing-metacharacters)
1. [Notes](21_notes.md)
   1. [`|`: OR Operator](21_notes.md#-or-operator)
