# "tr" Command

This is also one of the commands in which dialect between BSD and System-V remain firmly. So, I'm not too fond of it.[1]

## In Case of Having Two Pairs of Brackets Arguments

When you replace each capital letter to the small one in the whole of text data, you have to choose one of the following usages depending on whether it's for BSD edition or System-V edition.

> `tr '[A-Z]' '[a-z]'`  <== for System-V (works correctly by chance)

> `tr 'A-Z' 'a-z'`      <== for BSD and POSIX

The difference between the two is whether the brackets "[,]" is necessary or not. On BSD and POSIX, the brackets have no special meaning and also regarded as usual ones. So, if you use the System-V usage on BSD, the brackets on text data will be able to be transformed into anything unintentionally.  However, the former case, which has two pairs of brackets arguments, works with no problem because brackets transform into the same each by chance. Thus, it would be best if you use the former even on BSD rather than the latter.

## In Case of Having Only One Pair

However, the above trick is useless for the case that the "tr" command has only one pair of Brackets Argument, like when using the "-d" option. Here is an example.

> `tr -d '[a-z]'`  <== for System-V (doesn't work on BSD, POSIX)

> `tr -d 'a-z'`    <== for BSD (doesn't work on System-V)

You might think that the former (System-V usage) is not proper because it doesn't comply with POSIX. It's certainly correct, but there are some ideas to support it. One of them is to replace it with the "sed" command. The above example can be replaced as follows in most cases.

> `sed 's/[a-z]//g'`

Note that sed command is NOT a perfect substitute for tr. That is because sed works differently depending on vendors if it receives text data which doesn't terminate with line-feed (LF) character. (See ["sed" command section](sed.md))

The other idea is not to use the hyphen "-" as range operator. You can also replace the above example with the following.

> `tr -d 'abcdefghijklmnopqrstuvwxyz'`

This is the perfect substitute for "`tr -d 'a-z'`" and/or "`tr -d '[a-z]'`," although it looks a little longer.


---
* Although Solaris 11 is one of the traditional System-V family OSes, it already has not only System-V traditional commands but also POSIX compliant ones. "tr" command is, too.