# "`#!`" -- "First of First" of Your Shell Script

You know, "`#!`" is called "shebang," which we always write at the head of your script. First of all, we have to tell you about this.

## Can I Use "`#!/bin/sh`"?

Our answer is actually, "Yes." However, strictly speaking, the answer is UNDEFINED.

[The man-page of POSIX sh](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html) has [the following explanation](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html#tag_20_117_16):

> Applications should note that the standard PATH to the shell cannot be assumed to be either **/bin/sh** or **/usr/bin/sh**, and should be determined by interrogation of the PATH returned by getconf PATH, ensuring that the returned pathname is an absolute pathname and not a shell built-in.

In other words, POSIX says that POSIX-compliant OSes don't have to put the sh command in /bin. If you comply with the explanation, you can't use the phrase "`#!/bin/sh`" at the head of shell scripts. In the case that you don't use the phrase, the shell script is executed by the current shell itself, which you have used to execute the script. Therefore, if you are using "csh" or C-Shell, the shell script is tried to executed by csh, and it would probably fail if your shell script is for Bourne Shell.

Otherwise, we have to execute the getconf command in advance on a shell script, which can run on all shells. Then, have to rewrite all paths of shebangs on all your shell scripts dynamically or manually. But that is unrealistic. Moreover, you can find a few pages having the "`#!/bin/sh`," which assumes the path of the sh command is "/bin," on the POSIX document — these conflicts with the explanations.

These are the reasons why we say yes.

## What Should I Write at the Top of Shell Scripts?

It is very important for shell scripts that want high compatibility to behave equally no matter what status of the OS on which the script is deployed has. To make such a shell script, we recommend that you should always write the following code at the top of your shell script.

```sh
#!/bin/sh

set -u
umask 0022
export LC_ALL=C
export PATH="$(command -p getconf PATH 2>/dev/null)${PATH+:}${PATH-}"
case $PATH in :*) PATH=${PATH#?};; esac
export UNIX_STD=2003  # to make HP-UX conform to POSIX
```

I'll explain them one by one.

### 1) "`#!/bin/sh`" (shebang)

See [the above section](#can-we-use-binsh).

### 2) "`set -u`"

"set" command sets the following arguments to the shell as options. And, "-u" is the option to abort the shell script when the script tries to read a variable having no value. It is useful for finding out misspelled variables. However, there are some points to be aware of the option. See ["`$*`/`$@`" variables section](-2440_doller_asterisk_and_atmark.md) and ["reading a undefined variable" section](shell_variables.md#reading-a-undefined-variable).

### 3) "`umask 0022`"

"umask" command is to define the default file permission when the shell creates a file or directory. And "0022" is the typical value for general shell scripts. So, please initialize the setting with this command.

### 4) "`export LC_ALL=C`"

The environment variable "LC_ALL" is to define the locale, which most commands refer the value to decide their behavior. And, "C" is the default locale, which all OSes in all region support, it means the most compatible locale. So, it would also be better if you initialize the setting with this variable.

### 5) "`PATH=...`"  (Redefinition of "PATH" Variable)

"PATH" is one of the most important environment variables. If you don't initialize this before executing a command, you can't expect which one of commands having the same name but in different paths would execute. The line is to make shell refer to the POSIX-compliant paths preferentially. If your host support neither "command" nor "`getconf PATH`", this redifinition are cancelled by the next line.

Notably, this line are significant for shell scripts, which likely to run on Solaris because the default paths on Solaris, such as "/bin," "/usr/bin," have many POSIX-incompliant commands. And, this could overwrite the setting.

### 6) "`case $PATH ...`" (Validation of the Redefinition)

If your host support neither "command" command nor "`getconf PATH`", the string of "PATH" variable starts from the charater ":" because "`$(command ...)`" in the previous line failed. To recover the original string of "PATH" in that case, the "case" construct validates the "PATH" variable and removes the delimiter ":" if invalid.

### 7) "`export UNIX_STD=2003`"

This environment variable is to make HP-UX compatible with POSIX. The commands in HP-UX behave compliantly with POSIX when this variable exists, and it has this value.

