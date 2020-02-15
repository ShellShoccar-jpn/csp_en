# "ps" Command

The most of the current "ps" commands are a little tricky because they support both BSD and System-V style argument rule.

## Use "-A" Option Instead of "-x"

"-x" option generally means that also display processes which don't have controlling terminals. However, you had better not to use it. That is because the POSIX document doesn't refer to the option, and the behavior of the option is slightly different between BSD and System-V. At least, the behavior of GNU ps and BSD ps seem to be different.

For instance, BSD ps displays the processes created by CGI (httpd) only when "-x" is given, on the other hand, GNU ps displays them despite no "-x" option.

After all, it would be best if you used the "-A" (capital A) option to display all processes once and filter processes which you need not.

## Should Not Use "-l" Option

"-l" option has a similar meaning as the same name option of the "ls" command. That is, it displays detail information. And POSIX refers to this. Nonetheless, it would be best if you didn't use it because POSIX defines neither the field items nor their order for the option.

## Always Use "-o" Option to Define Format Clearly

I told like that the field format by "-l" is undefined. But it's the same when no options. The common rules which all implementations comply are only like these:

* The first field is the Process ID (PID).
* Command name field always exists somewhere.

If you want to avoid the ambiguous format, you have to define the format with "-o" option. 

Here is an example to display Process ID (PID), Parent Process ID (PPID), and Command name with its arguments for all processes.

``` sh
$ ps -Ao PID,PPID,ARGS
  PID  PPID COMMAND
    1     0 /init
   22     1 /init
   23    22 /init
   24    23 -bash
  242     1 /init
  243   242 /init
  244   243 -bash
  266   244 dash
  300    24 ps -Ao pid,ppid,args
$ 
```

See the "STDOUT" section of [ps man page in the POSIX document](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ps.html) for the detail of the "-o" option.

## Sup.1 PPID Number

On Linux, "init" is the only process whose PPID is 0. On the other hand, there are some processes whose PPID is 0 on FreeBSD. That difference is by kernel rather than command. Be careful about the difference if you need to make your program compatible.

## Sup.2 ps Command on Cygwin

Unfortunately, ps command on Cygwin is incompatible with POSIX as of November 2019. It doesn't support either "-A" or "-o" option. I suppose that the cause is that Cygwin works on Windows, which has a different process management system.

I think it's a proper policy that you don't support Cygwin because of non-POSIX OS. But, you, of course, also support it. If you want, you should make sure that your shell script is on Cygwin with "uname" command before executing the ps command.

Here is an example.

``` sh
case $(uname) in                                             #
  CYGWIN*) ps -af                                      |     #
           awk '{c=$6;sub(/^.*\//,"",c);print $3,$2,c}';;    #
        *) ps -Ao ppid,pid,comm                        ;;    #
esac                                                         |
```
