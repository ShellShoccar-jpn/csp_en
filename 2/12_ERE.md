# ERE Metacharacter Set

ERE looks upper compatible with BRE, and the literal meaning is also "Extended"-RE. However, **ERE is not compatible with BRE.** Be careful.

ERE mainly has the following differences from BRE;

* Supports fewer metacharacters; "`+`," "`?`" and  "`|`."
* The braces (quantifier) and parentheses (inclusion-operator) are no longer with the backslash. Thus, the meanings have switched between "`\(`...`\)`," "`\{`...`\}`" and "`(`...`)`," "`{`...`}`."
* **The backward reference operator is not supported officially.**[1]

As same as BRE section, I'll place the metacharacters into three subsets.

* Matching metacharacters (outside brackets)
* Matching metacharacters inside brackets
* Replacing metacharacters


## Matching metacharacters

Here is the first subset for ERE.

| Meta-chr.       | Meaning                                     |
| :---            | :---                                        |
| `^`             | Matches with the empty string before the head of the line. Thus, you can use it when you want to insert some string before the head. However, the special meaning affects only when it is at the top of the matching pattern string. Otherwise, it'll behaves as a usual letter. |
| `$`             | Matches with the empty string behind the tail of the line. Thus, you can use it when you want to insert some string behind the tail. However, the particular meaning affects only when it is at the tail of the matching pattern string. Otherwise, it'll behave like a usual letter. |
| `[`...`]`       | Matches with a letter if it's one of the enumerated in the bracket. |
| `[^`...`]`      | Matches with a letter if it's none of the enumerated in the bracket. (See the [next section](#Matching-Metacharacters-Inside-Brackets)) |
| `*`             | Quantifier: Matches with zero or more repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| `+`             | Quantifier: Matches with one or more repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| `{`*n*`}`       | Quantifier: Matches with *n* repetitions with which the previous character or phrase at the quantifier specifies (*n*>=1). The earlier quantifiers are stronger than laters about the intention of maximization. |
| `{`*n*`,}`      | Quantifier: Matches with *n* or more repetitions maximally with which the previous character or phrase at the quantifier specifies (*n*>=0). The earlier quantifiers are stronger than laters about the intention of maximization. |
| `{`*m*`,`*n*`}` | Quantifier: Matches with *m* or more and *n* or fewer repetitions maximally with which the previous character or phrase at the quantifier specifies (*m*>=0, *n*>=*m*). The earlier quantifiers are stronger than laters about the intention of maximization. |
| `?`             | Quantifier: Matches with zeno or one repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| *A*`\|`*B*      | "OR" Operator: It regards *A* and *B* as matching pattern strings, respectively. Then, it matches with *A* or *B*. The target scopes of the operator are generally to the head or tail of the pattern string, or, to the parentheses if they exist. For instance, "`^ABC\|DEF$`" means not "`^(ABC\|DEF)$`" but "`(^ABC)\|(DEF$)`." *Additionally, there is a tip about which you have to be careful.* (See ["Note" section](21_notes.md)) |
| `(`...`)`       | Inclusion Operator: The parentheses make a phrase of the string between them. The above quantifiers or the "OR" operator refers it. |
| `\`*x*          | If *x* is one of the metacharacters, the backslash in front of it disables the special meaning. So you can use *x* as the ordinal one. |
| `\\`            | Means `\` itself. |


## Matching Metacharacters Inside Brackets

It is completely the same as [BRE's](11_BRE.md#matching-metacharacters-inside-brackets).

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `^`               | Complementary Operator: If you locate it just behind the opening bracket (earlier than the following two operators if they exist), the bracketed phrase matches with any of the complementary characters which enumerated in it. For instance, the pattern string "`[^ABC]`" matches with "0," "1," "@," "D," "a," and so on, except "A" to "C." |
| *a*`-`*b*         | Range Operator: It's equivalent to all the letters from *a* to *z* in character code order. For instance, "`[0-9]`" means "`[0123456789]`," and "`[^ -%]`" means "`[^ !"#$%]`." If you want to mean the hyphen itself, you should locate it just before the closing bracket. |
| `]`               | If you want to use it without the special meaning, you have to locate it just behind the opening bracket. However, the simple circumflex is earlier if it exists. |

Here are the additional ones. It is also the same as BRE's.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `[:`*keyword*`:]` | POSIX Character Class: The part "*keyword*" is one of the following twelve keywords. **1:"alnum"** means all alphabets and digits. **2:"alpha"** means all alphabets. **3:"blank"** means the space and the tab. **4:"cntrl"** means all control characters. **5:"digit"** means all digits. **6:"graph"** means all visible characters (alphabets, digits and symbols except the space or the tab). **7:"lower"** means all small alphabets. **8:"print"** means all printable characters ("graph"+"blank"). **9:"punct"** means all punctuation characters (symbols except the space or the tab). **10:"space"** means all whitespace characters (SPC,HT,VT,CR,LF,FF). **11:"upper"** means all capital aphabets. **12:"xdigit"** means all hexadecimal digits (`[0-9A-Fa-f]`). When you use them actually, you can write it like "`[[:upper:][:digit:]]`." However, some environments accept "`[:`*keyword*`:]" instead of "`[[:`*keyword*`:]]" by mistake. |
| `[.`*string*`.]`  | For instance, "`[[.foo.]]`" is equivalent to "`\(foo\)\{1,\}`." However, **I have never seen any environments available.** Is that because the latter way would be sufficient? |
| `[=`*chr*`=]`     | For instance, "`[[=a=]]`" is equivalent to "`[aàâ]`." So, "`[[=a=]bc]`" also means "`[aàâbc]`." However, I have never seen it, neither! |


## Replacing metacharacters

It is also the same as BRE's, but there is no command which can support replacing with ERE in POSIX.

See the [BRE's](11_BRE.md#replacing-metacharacters) explanation or the [AWK's subset section](13_AWK_subset.md#replacing-metacharacters).


---
* Solaris 11 also has the POSIX compliant grep command, but it doesn't support it.
