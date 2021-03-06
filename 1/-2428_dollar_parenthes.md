# "`$(`...`)`" Operator

I recommend you to use this operator instead of the back quotation operator "\`...\`" because we can use the former with simple usage. However, you have to be careful a little about this. That is because some versions of Bash shells wrongly work for this operator.

## Should Not Use the "case" Construction in This Operator

The following example doesn't work correctly on Bash version 3 due to a bug.

```sh
msg=$(
      case "$message" in
        'NO_ERROR') echo 'OK'             ;;
                 *) echo "ERROR: $message";;
      esac                                  
     )
```

The cause is that Bash ver.3 regards the ")" operator for the case construction as the terminator for "$(" by mistake.

If you want to use the case construction in this operator, you had better use the "if" construction instead, or you can [use the back quotation operator "\`...\`" carefully.](-60.md)

## Put `$$` in Double Quotation in This Operator

"$$" is one of the built-in shell variables, which convert into its own process ID, but there are some circumstances it doesn't work. It also happens on Bash version 4. Try the phrase "`echo $(echo $$'')`" on it if Bash 3 or 4 is available on your computer. Then, you can see the reaction like this:

```sh
$ echo $(echo $$'')
                            <== No process ID displayed!
$ 
```

However, the phenomenon won't happen when you put $$ in the double quotation.

```sh
$ echo $(echo "$$"'')
12345
$ 
```

So, I recommend that you use "$$" instead of $$ to consider the bash bug.
