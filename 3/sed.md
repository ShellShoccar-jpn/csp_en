# "sed" Command

This command has some points to be careful, too.

## Behavior when Given Text Data Doesn't Terminate with LF

Try this one-liner "`printf 'Hello,\nworld!' | sed 's/H/h/'`" on your environment. The reaction might be one of the following three.

GNU Edition: It's the most loyal to the original data.
```sh
$ printf 'Hello,\nworld!' | sed 's/H/h/'
hello,
world!$ 
```

BSD Edition: It adds an LF character to the end of the text wilfully.
```sh
$ printf 'Hello,\nworld!' | sed 's/H/h/'
hello,
world!
$ 
```

Solaris (XPG4) Edition: It returns with an error value if a non-LF terminated line received.
```sh
$ printf 'Hello,\nworld!' | sed 's/H/h/'
hello,
sed: Missing newline at end of file standard input.
world!
$ echo $?
2              <== This means that the previous sed finished with an error.
$ 
```

I think that the GNU edition behaves the most properly as a filter but you also have to consider the others.

### To Support All of Them

I'll show you an idea to prevent the problem as follows.

```sh
printf 'Hello,\nworld!'       |
(cat -; echo)                 |
sed 's/H/h/'                  |
awk 'BEGIN{
       ORS="";
       OFS="";
       getline line;
       print line;
       dlm=sprintf("\n");
       while (getline line) {
         print dlm,line;
       }
     }'
```

"`(cat -; echo)`" at the second line adds an LF character to the end to make sed work safely. Then, AWK, at the fourth line, is to remove the added LF.

## Available Metacharacters in Regular Expression

Be careful about the available metacharacters written on the GNU sed man page because it contains some uniquely additional ones. For sed command, the metacharacter set you should comply with is the Basic Regular Expression (BRE). It's written in [POSIX sed man page](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html). See also [BRE section](../2/11_BRE.md).

## "-" Does Not Always Mean the STDIN Symbol

Most commands regard the hyphen "-" as the STDIN symbol like /dev/stdin, but sed doesn't. POSIX doesn't say that "-" is regarded as the STDIN symbol on sed command, and the actual BSD sed tries to open the file, which is named "-" instead of to open STDIN. If you want to read data from STDIN, you should put no file arguments.

## Locale

See the [locale section](../1/locale.md).
