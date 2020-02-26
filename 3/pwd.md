# "pwd" Command

You know, this command displays the path where you are working now, it's called "Current Working Directory (CWD). There are two ways to express the path when you are in a symbolic linked directory. One is "Logical Path (LP)," which expresses the path with the name of the symbolic link. And the other is "Physical Path (PP)," which expresses the path with the actual directory name the symbolic link links.

## POSIX Incompliant Implementaions

However, it depends on actual pwd implementations whether they display LP or PP by default even though POSIX says pwd should display LP by default. For instance, the pwd in FreeBSD 12.1 displays PP by default. Moreover, its manual insists that this behavior is to comply with POSIX 2001 edition. Of course, that is wrong.

### Most Linux Distros Have Both LP and PP Versions

To our annoyance, on Linux, the built-in pwd of bash displays LP with no option while the pwd of the coreutils (version 8.28) displays PP. You can make sure of the difference easily by the following.

```sh
$ cd /tmp
$ ln -s /etc etc.link
$ cd etc.link
$ pwd                  <== Use the bash built-in version
/tmp/etc.link
$ /bin/pwd             <== Use the coreutils version
/etc
$ 
```

### Some Implementations Do Not Support LP/PP Specifying Options

You may suppose that all we have to do is use the option "-L" or "-P" clearly not to depend on the default behavior. But unfortunately, some implementations don't support the options.

## Solutions

We suggest two solutions. One is that you make your shell script tolerant of both LP and PP.

The other is that you replace the pwd command with the following phrase.

> `pwd -P 2>/dev/null || pwd`

In case that your pwd supports "-P," the first pwd returns PP. If not, the second one returns PP after the first one silently exits with an error. But you may worry whether the second one inevitably returns PP or not. The pwd commands which don't support the option is too old. Such an old one always returns PP. We have investigated that, and we are confident. Don't worry.
