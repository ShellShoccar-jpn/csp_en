# Notes

To close, I told you some points to note when using the metacharacters.

## `|`: OR Operator

Some implementations don't accept the OR operator "`|`" which locates at the head/tail of the phrase, or also of the whole pattern string.

For instance, when you want to match words which mean a kind of weight, like "*n*kg," "*n*g," "*n*mg," and also "*n*" (no unit), you might write a pattern like "`[0-9]+(kg|g|mg|)`." However, such the pattern could fail.

```sh
(This happens on some versions of macOS and OpenBSD.)

$ echo 2kg | grep -E '[0-9]+(kg|g|mg|)'
grep: empty (sub)expression
$ 
```

I confirmed this symptom presents on macOS 10.16 and OpenBSD 6.0, at least. It seems that the cause is in the RE library because the same symptom also presents AWK and sed (when it works on ERE mode [1]). Both OSes use Henry Spencer's RE library.

### Solution

Try the empty parentheses "`()`." as a dummy phrase to give phrases to both sides of the operator, like this:

```sh
$ echo 2kg | grep -E '[0-9]+(kg|g|mg|())'
2kg
$ 
```

---

* The sed command on these OSes is extended and has ERE mode, which is turned on by the "-r" option.