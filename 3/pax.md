# "pax" Command

This command is born to integrate two major archivers "tar" and "cpio." It appeared in the POSIX specification 1998 edition. Note that **"tar" and "cpio" have been removed** from the document in place of "pax."[1]

Thus, strictly speaking, you should use the "pax" command for archiving. Of course, it supports both the archive format even though it has yet another format "ustar." And, the recent versions of tar also know the ustar format.

## But Not So Popular

However, it's not confident to say that "pax" is popular. Some Linux distributions like "Debian," "Ubuntu," and so on don't install it on initial status. So, you should make sure that there is pax or tar on your computer and choose one of them with a shellscript like this:

### Dealing with tar archive with the care of compatibility

``` sh
if   type pax >/dev/null 2>&1; then pax -rs '!^/!./!' -f SOME_ARCHIVE.tar
elif type tar >/dev/null 2>&1; then tar -x            -f SOME_ARCHIVE.tar
fi
```

This example seems that pax argument is more complicated than tar's one. That is to keep compatible with the default behavior of tar command. In the case the path of the archive file starts from "/," it means an absolute-path, tar tries removing it while pax doesn't. The "-s" option is to make pax do the same behavior as tar.

---
1. The name "pax" has two meanings. One is "packs." It's the third-person singular present conjugation for "pack." The other is "peace" in Latin. There is a wish in this name to finish the power struggle between tar and cpio.