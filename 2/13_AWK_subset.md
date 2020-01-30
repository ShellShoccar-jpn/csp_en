# AWK's Subset of ERE Metacharacters

The AWK's subset supports most of ERE metacharacters except the brace quantifier "`{`...`}`." Although the 2008 Edition of POSIX recommends that every POSIX-compliant OSes should support it, most of them don't yet.

Moreover, the script parser in AWK command pre-processes the backslashed character "`\`*x*" before executing the script. Thus, the RE metacharacters in AWK are also affected. So, the available metacharacters are the following, eventually.

ERE mainly has the following differences from BRE;

As same as the former sections, I'll place the metacharacters into three subsets.

* Matching metacharacters (outside brackets)
* Matching metacharacters inside brackets
* Replacing metacharacters

## Matching metacharacters

| Meta-chr.       | Meaning                                     |
| :---            | :---                                        |
| `^`             | Matches with the empty string before the head of the line. Thus, you can use it when you want to insert some string before the head. However, the special meaning affects only when it is at the top of the matching pattern string. Otherwise, it'll behaves as a usual letter. |
| `$`             | Matches with the empty string behind the tail of the line. Thus, you can use it when you want to insert some string behind the tail. However, the particular meaning affects only when it is at the tail of the matching pattern string. Otherwise, it'll behave like a usual letter. |
| `[`...`]`       | Matches with a letter if it's one of the enumerated in the bracket. |
| `[^`...`]`      | Matches with a letter if it's none of the enumerated in the bracket. (See the [next section](#Matching-Metacharacters-Inside-Brackets)) |
| `*`             | Quantifier: Matches with zero or more repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| `+`             | Quantifier: Matches with one or more repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| `?`             | Quantifier: Matches with zeno or one repetitions maximally with which the previous character or phrase at the quantifier specifies. The earlier quantifiers are stronger than laters about the intention of maximization. |
| *A*`\|`*B*      | "OR" Operator: It regards *A* and *B* as matching pattern strings, respectively. Then, it matches with *A* or *B*. The target scopes of the operator are generally to the head or tail of the pattern string, or, to the parentheses if they exist. For instance, "`^ABC\|DEF$`" means not "`^(ABC\|DEF)$`" but "`(^ABC)\|(DEF$)`." *Additionally, there is a tip about which you have to be careful.* (See the [following section](21_note.md)) |
| `(`...`)`       | Inclusion Operator: The parentheses make a phrase of the string between them. The above quantifiers or the "OR" operator refers it. |
| `\\`            | Means `\` itself without the special meaning. |
| `\/`            | Means `/` itself without the special meaning. |
| `\"`            | Means `"` itself without the special meaning. |
| `\a`            | Means the control code "BEL" (0x07). |
| `\b`            | Means the control code "BS" (0x08). |
| `\f`            | Means the control code "FF" (0x0C). |
| `\n`            | Means the control code "LF" (0x0A). |
| `\r`            | Means the control code "CR" (0x0D). |
| `\t`            | Means the control code "HT" as known as "TAB" (0x09). |
| `\v`            | Means the control code "VT" (0x0B). |
| `\`*ddd*        | Means the letter of which character code is *ddd* in octal three digits, without the special meaning. For instance, "`\057`" means "`/`." |
| `\`*x*          | If *x* is one of the metacharacters, the backslash in front of it disables the special meaning. So you can use *x* as the ordinal one. If *x* is none of the letters in the above, it means undefinedly. |


## Matching Metacharacters Inside Brackets

"`\\`" and the latter are available due to the AWK script pre-processor.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `^`               | Complementary Operator: If you locate it just behind the opening bracket (earlier than the following two operators if they exist), the bracketed phrase matches with any of the complementary characters which enumerated in it. For instance, the pattern string "`[^ABC]`" matches with "0," "1," "@," "D," "a," and so on, except "A" to "C." |
| *a*`-`*b*         | Range Operator: It's equivalent to all the letters from *a* to *z* in character code order. For instance, "`[0-9]`" means "`[0123456789]`," and "`[^ -%]`" means "`[^ !"#$%]`." If you want to mean the hyphen itself, you should locate it just before the closing bracket. |
| `]`               | If you want to use it without the special meaning, you have to locate it just behind the opening bracket. However, the simple circumflex is earlier if it exists. |
| `\\`              | Means `\` itself without the special meaning. |
| `\/`              | Means `/` itself without the special meaning. |
| `\"`              | Means `"` itself without the special meaning. |
| `\a`              | Means the control code "BEL" (0x07). |
| `\b`              | Means the control code "BS" (0x08). |
| `\f`              | Means the control code "FF" (0x0C). |
| `\n`              | Means the control code "LF" (0x0A). |
| `\r`              | Means the control code "CR" (0x0D). |
| `\t`              | Means the control code "HT" as known as "TAB" (0x09). |
| `\v`              | Means the control code "VT" (0x0B). |
| `\`*ddd*          | Means the letter of which character code is *ddd* in octal three digits, without the special meaning. For instance, "`\057`" means "`/`." |

The additional ones are the same as ERE's.

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `[:`*keyword*`:]` | POSIX Character Class: The part "*keyword*" is one of the following twelve keywords. **1:"alnum"** means all alphabets and digits. **2:"alpha"** means all alphabets. **3:"blank"** means the space and the tab. **4:"cntrl"** means all control characters. **5:"digit"** means all digits. **6:"graph"** means all visible characters (alphabets, digits and symbols except the space or the tab). **7:"lower"** means all small alphabets. **8:"print"** means all printable characters ("graph"+"blank"). **9:"punct"** means all punctuation characters (symbols except the space or the tab). **10:"space"** means all whitespace characters (SPC,HT,VT,CR,LF,FF). **11:"upper"** means all capital aphabets. **12:"xdigit"** means all hexadecimal digits (`[0-9A-Fa-f]`). When you use them actually, you can write it like "`[[:upper:][:digit:]]`." However, some environments accept "`[:`*keyword*`:]" instead of "`[[:`*keyword*`:]]" by mistake. |
| `[.`*string*`.]`  | For instance, "`[[.foo.]]`" is equivalent to "`\(foo\)\{1,\}`." However, **I have never seen any environments available.** Is that because the latter way would be sufficient? |
| `[=`*chr*`=]`     | For instance, "`[[=a=]]`" is equivalent to "`[aàâ]`." So, "`[[=a=]bc]`" also means "`[aàâbc]`." However, I have never seen it, neither! |


## Replacing metacharacters

About AWK's replacing metacharacters, note the following two issues.

First, "`\`*n*" is unavailable even though BRE has it. Second, you have to write the simple ampersand "`&`", not having the special meaning, as "`\\&`" instead of "`\&`." That is because the AWK script pre-processor converts "`\\`" to "`\`" in advance.

Eventually, the available ones are these:

| Meta-chr.         | Meaning                                     |
| :---              | :---                                        |
| `&`               | Replaced with the whole part of the string which is matched by the matching pattern. |
| `\\&`             | Means `&` itself. |
| `\\`              | Means `\` itself. |
| `\/`              | Means `/` itself without the special meaning. |
| `\"`              | Means `"` itself without the special meaning. |
| `\a`              | Means the control code "BEL" (0x07). |
| `\b`              | Means the control code "BS" (0x08). |
| `\f`              | Means the control code "FF" (0x0C). |
| `\n`              | Means the control code "LF" (0x0A). |
| `\r`              | Means the control code "CR" (0x0D). |
| `\t`              | Means the control code "HT" as known as "TAB" (0x09). |
| `\v`              | Means the control code "VT" (0x0B). |
| `\`*ddd*          | Means the letter of which character code is *ddd* in octal three digits, without the special meaning. For instance, "`\057`" means "`/`." |
