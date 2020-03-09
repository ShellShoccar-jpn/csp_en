# "echo" Command

To go straight to the bottom line, you should not use this command when you meet one or both of the following conditions.

* Strings of which contain a hyphen "`-`" at the head, or variables which have such a possibility
* Strings which contain one or more backslashes "`\`," or variables which have such a possibility

Thus, you should not also use echo for variables that you can't expect what characters are in them.

We explain the reason for it below.

## Every Implementation Supports Different Options

Here is the report about available options for echo command on various implementations.

* Support no option
  * POSIX
  * AIX's (7.2) /bin/sh (ksh) built-in and external
  * HP-UX's (11i v3) /bin/sh built-in and external
  * Solaris' (11) /bin/sh built-in and external
  * macOS's (10.13) /bin/sh (bash 3.2) built-in
* Support only "`-n`"
  * FreeBSD's (11.2) external
  * NetBSD's (7.0) external
  * OpenBSD's (6.5) external
  * macOS's (10.13) external
  * dash (some distros of Linux's /bin/sh) built-in
* Support "`-n`" and "`-e`"
  * FreeBSD's (11.2) /bin/sh (ash) built-in
  * NetBSD's (7.0) /bin/sh (ash) built-in
  * OpenBSD's (6.5) /bin/sh (pdksh) built-in
* Support "`-n`", "`-e`" and "`-E`"
  * bash (most distros of Linux's /bin/sh) built-in
  * zsh built-in
* Supports "`-n`", "`-e`", "`-E`", "`--help`", "`--version`"
  * most distros of Linux's external (GNU echo)

POSIX announces that implementations shall not support any options for the echo command. And most commercial UNIX OSes do so. But the GNU echo command, which most Linux distros have, supports five options.

When these echo commands are given unsupported options, they simply display the option as a string. It doesn't cause errors if an echo implementation doesn't know the option. But it causes us to make incompatible shell scripts.

## Some Implementations Interpret "`\`" Without the "`-e`" Option

To make us annoyed, some of the echo implementations interpret the backslash "`\`" as the escape sequence symbol without the "`-e`" option.

Although that causes incompatibility, [POSIX surprisingly allows the behavior!](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html#tag_20_37_10) The POSIX document says that all implementations should support the interpretation with no option.

## Solution

The case in which you may use this command is only the situation you certainly know that strings or variables contain neither the headed hyphen "`-`" nor backslashes "`\`." Otherwise, use printf command instead of echo.

Here is an example, which displays the strings of all arguments have.

```sh
#!/bin/sh

for arg in "$@"; do
  printf '%s\n' "$arg"
done
```

In this case, you must not use echo command because you can't expect what character the arguments contain at all.
