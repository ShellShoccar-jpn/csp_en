# "zcat" Command

Even though most actual "zcat" implementations on various Unix could work equivalently as "`gunzip | cat`," that is a misunderstanding to speak strictly. The behavior of "zcat" is equivalent to "`uncompress | cat`." Some zcat fails to work like that:

``` sh
$ echo foo | gzip | zcat
stdin: not in compressed format
$ 
```

You had better use the "compress" command instead of gzip if you want to get the perfect compatibility for all Unix OSes.

``` sh
$ echo foo | compress | zcat
foo
$ 
```

## Important : In Case of Dealing with Small Files

"compress" doesn't compress the file when it judges that the file size becomes bigger than the original. The case occurs typically when the file is too small. So, the accident like the following would be able to happen.

``` sh
$ echo 1 > smallfile.txt
$ compress smallfile.txt
 -- file unchanged         <== It signs not compressed.
$ zcat smallfile.txt.Z
smallfile.txt.Z: No such file or directory
$ 
```

To avoid the accident, you should use "-f" option for compress. ("`compress -f`")