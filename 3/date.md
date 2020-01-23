# "date" command

This is one of the commands which has a lot of vendor-unique functions because the original "date" doesn't have enough features. But, you may use only the following functions if you care about compatibility.

* "-u" option (display in "UTC" timezone)
* "+*format*" (to define the format for date and time)

Note that the available macro sequences for the format are written in the last paragraph of "Conversion Specifications" on [the POSIX man page of "date."](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/date.html) You should make sure that.

## To do the Mutual Transformation

Unfortunately, the original "date" doesn't support the mutual transformation between the usual time and the UNIX time.[^unittime] So, we made the command ["utconv"](https://github.com/ShellShoccar-jpn/misc-tools/blob/master/utconv) to do it. Of course, it is in POSIX compliant shellscript.

### example

What time in UNIX time is for 2015-08-16 10:00:00 JST?

```
$ export TZ=JST-9
$ echo 20150816100000 | utconv
1439686800
$
```

And, can the command invert the UNIX time to the original one correctly?

```
$ export TZ=JST-9
$ echo 1439686800 | utconv -r
20150816100000
$
```

For your information, the ideas which the command followed are the Fairfield's congruence and one implementation code for gmtime() in the standard C library. The former is convert from the usual time to UNIX time. The latter is for the opposite.

[^unittime]: Unix time, also known as "Epoch time," is a monotonic number of seconds from 1970-01-01 (UTC).
