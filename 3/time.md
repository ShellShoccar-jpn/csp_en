# "time" Command

This is a command to time command from start to end. However, the reporting format varies depending on vendors. POSIX defines the format clearly when you use it with the "-p" option and when C-locale. It's expressed with like the "printf" function as follows.

> `"real %f\nuser %f\nsys %f\n", <real seconds>, <user seconds>, <system seconds>`

But unfortunately, some implementations, which don't follow the latest POSIX yet, don't support the option. I certainly made sure that the built-in one of /bin/sh on IBM AIX 7.2 doesn't.

## How to Use It Safely

After all, what we have to do is to add "`command -p`" to the front of the "time" command. This idiom means to make the shell find out the command written after the idiom with the default value of "PATH," not to permit to search it from built-ins or shell-functions.

See the example.

``` sh
$ export LANG=C   <== Or, you can type "export LC_ALL=C"
$ command -p time -p sleep 1
real 1.00
user 0.00
sys 0.00
$ 
```

As I illustrated above, don't forget to reset the locale to "C" if you don't initialize about it at the top of your shell script.
