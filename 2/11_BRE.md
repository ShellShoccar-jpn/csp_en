# BRE metacharacter set

In this book, I place a metacharacter set into three subsets, respectively.

* Matching metacharacters (outside brackets)
* Matching metacharacters inside brackets
* Replacing metacharacters

I will show you one by one.


## Matching metacharacters

The following table shows the metacharacters you can use for pattern matching. Note that most of them lose their special meanings when they are inside brackets (square brackets). So, I'll explain the metacharacters which are available inside brackets in the next section.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `^`               | Matches with the empty string before the head of the line. Thus, you can use it when you want to insert some string before the head. However, the special meaning affects only when it is at the top of the matching pattern string. Otherwise, it'll behaves as a usual letter. |
| `$`               | Matches with the empty string behind the tail of the line. Thus, you can use it when you want to insert some string behind the tail. However, the particular meaning affects only when it is at the tail of the matching pattern string. Otherwise, it'll behave like a usual letter. |
| `[`...`]`         | Matches with a letter if it's one of the enumerated in the bracket. |
| `[^`...`]`        | Matches with a letter if it's none of the enumerated in the bracket. (See the [next section](#Matching-Metacharacters-Inside-Brackets)) |
| `*`               | Quantifier: Matches with zero or more letters maximally with which the previous character or phrase at the quantifier specifies. |
| `\{`*n*`\}`       | Quantifier: Matches with *n* letters with which the previous character or phrase at the quantifier specifies (*n*>=1). |
| `\{`*n*`,\}`      | Quantifier: Matches with *n* or more maximally with which the previous character or phrase at the quantifier specifies (*n*>=0). |
| `\{`*m*`,`*n*`\}` | Quantifier: Matches with *m* or more and *n* or fewer letters maximally with which the previous character or phrase at the quantifier specifies (*m*>=0, *n*>=*m*). |
| `\(`...`\)`       | Inclusion Operator: The parentheses make a phrase of the string between them. The above quantifiers or the backward reference operator, which explained later, refers it. For instance, in case that the target string is "ABC123ABCABC", and the matching pattern is "`\([A-Z]*\)123\1*`." Then, "`\1`" matches the second "ABC." That is the following emphasized part, "ABC123**ABC**ABC." |
| `\`*n*            | Backward Reference Operator: Behaves as the string equivalent to the string between the *n*th parentheses (*n*>=1). |
| `\`*x*            | If *x* is one of the metacharacters, the backslash in front of it disables the special meaning. So you can use *x* as the ordinal one. |
| `\\`              | Means `\` itself. |


## Matching Metacharacters Inside Brackets

As I explained in the above, available metacharacters in square brackets are quite different from outside ones.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `^`               | Complementary Operator: If you locate it just behind the opening bracket (earlier than the following two operators if they exist), the bracketed phrase matches with any of the complementary characters which enumerated in it. For instance, the pattern string "`[^ABC]`" matches with "0," "1," "@," "D," "a," and so on, except "A" to "C." |
| *a*`-`*b*         | Range Operator: It's equivalent to all the letters from *a* to *z* in character code order. For instance, "`[0-9]`" means "`[0123456789]`," and "`[^ -%]`" means "`[^ !"#$%]`." When you want to mean the hyphen itself, you should locate it just before the closing bracket. If you want to write both the hyphen and the opening bracket without special meanings, write the hyphen later like this: "`[`...`[-]`"  |
| `]`               | If you want to use it without the special meaning, you have to locate it just behind the opening bracket. However, the simple circumflex is earlier if it exists. |

Moreover, the following metacharacters are also available in brackets, but some RE libraries misinterpret them due to some bugs even though POSIX defines them. So, it couldn't recommend using them.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `[:`*keyword*`:]` | POSIX Character Class: The part "*keyword*" is one of the following twelve keywords. **1:"alnum"** means all alphabets and digits. **2:"alpha"** means all alphabets. **3:"blank"** means the space and the tab. **4:"cntrl"** means all control characters. **5:"digit"** means all digits. **6:"graph"** means all visible characters (alphabets, digits and symbols except the space or the tab). **7:"lower"** means all small alphabets. **8:"print"** means all printable characters ("graph"+"blank"). **9:"punct"** means all punctuation characters (symbols except the space or the tab). **10:"space"** means all whitespace characters (SPC,HT,VT,CR,LF,FF). **11:"upper"** means all capital aphabets. **12:"xdigit"** means all hexadecimal digits (`[0-9A-Fa-f]`). When you use them actually, you can write it like "`[[:upper:][:digit:]]`." However, some environments accept "`[:`*keyword*`:]" instead of "`[[:`*keyword*`:]]" by mistake. |
| `[.`*string*`.]`  | For instance, "`[[.foo.]]`" is equivalent to "`\(foo\)\{1,\}`." However, **I have never seen any environments available.** Is that because the latter way would be sufficient? |
| `[=`*chr*`=]`     | For instance, "`[[=a=]]`" is equivalent to "`[aàâ]`." So, "`[[=a=]bc]`" also means "`[aàâbc]`." However, I have never seen it, neither! |


## Replacing metacharacters

In this context, "Replacing metacharacters" means the string, which is the B part like "s/A/B/," which is in the "sed" command. I'll explain these the following table.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `\`*n*            | Replaced with the string between the *n*th parentheses (*n*>=1). |
| `&`               | Replaced with the whole part of the string which is matched by the matching pattern. |
| `\\`              | Means `\` itself. |
