# Just 3 Metacharacter Sets You Have to Learn

There are a lot of metacharacter sets for regular expression (RE) in various software, but the sets of them you have to learn are only the following three.

* Metacharacters of Basic Regular Expression (BRE) [1]
* Metacharacters of Extended Regular Expression (ERE) [2]
* AWK subset of ERE

ERE is almost a superset of BRE (but not completely). So, it's easy to learn. And the third one is also easy to remember because it's a subset of ERE. You can learn the three sets in the following sections.

Then, the reason you don't have to learn other various sets is that most of them are a superset of the three, especially ERE. Thus, the three are acceptable for almost all languages or libraries, and so on. For example, Perl RE (PCRE), JavaScript RE, and GNU's RE are supersets of ERE, respectively.

## Which Set Does Each Command Support Respectively?

Before you learn the metacharacter sets, you should know which set each command supports, respectively. The following table show that.

| Command                  | Supporting Metacharacter Set |
| :---                     | :---                         |
| AWK                      | AWK subset of ERE            |
| ed                       | Basic RE                     |
| egrep                    | Extended RE                  |
| ex                       | Basic RE                     |
| grep (without "-E" opt.) | Basic RE                     |
| grep (with "-E" opt.)    | Extended RE                  |
| more                     | Basic RE                     |
| sed                      | Basic RE                     |
| vi                       | Basic RE                     |

Note that GNU grep supports a couple of ERE metacharacters with a backslash, like "`\+`" and "`\|`," even though without the "-E" option, but they are incompliant extensions with POSIX.


---
* See ["9.3 Basic Regular Expressions"](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03) section on POSIX document.
* See ["9.4 Extended Regular Expressions"](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04) section on POSIX document.
