# bash subshells

bash creates subshells in the following situations:
- for an expression surrounded by parentheses: `( ... )`
  - except directly inside `[[ ... ]]`, where parentheses are only used for 
    logical grouping.
- for every segment of a pipeline `|`, including the first one.
  - every subshell involved is a clone of the original shell in terms of content
    (process-wise, subshells can be forked from other subshells, before commands 
    are executed). 
  - Thus, modifications of subshells in earlier pipeline segments do not affect 
    later ones. 
  - By design, commands in a pipeline are launched simultaneously - sequencing 
    only happens through their connected stdin/stdout pipes). 
  - bash 4.2+ has shell option `lastpipe` (off by default), which causes the 
    last pipeline segment to _not run in a subshell_.
- for command substitution, `($(...))`
- for process substitution, `(<(...))`
  - typically creates 2 subshells
  - in the case of a simple command, there is a technique to only create one: 
    prepend the simple command with `exec (<(exec ...))`.
- background execution, `cmd &`

Combining these constructs will result in more than one subshell.

---

https://unix.stackexchange.com/a/138498/256865

A subshell starts out as an almost identical copy of the original shell process. Under the hood, the shell calls the fork system call1, which creates a new process whose code and memory are copies2. When the subshell is created, there are very few differences between it and its parent. In particular, they have the same variables. Even the $$ special variable keeps the same value in subshells: it's the original shell's process ID. Similarly $PPID is the PID of the parent of the original shell.

A few shells change a few variables in the subshell. Bash sets BASHPID to the PID of the shell process, which changes in subshells. Bash, zsh and mksh arrange for $RANDOM to yield different values in the parent and in the subshell. But apart from built-in special cases like these, all variables have the same value in the subshell as in the original shell, the same export status, the same read-only status, etc. All function definitions, alias definitions, shell options and other settings are inherited as well.

A subshell created by (…) has the same file descriptors as its creator. Some other means of creating subshells modify some file descriptors before executing user code; for example, the left-hand side of a pipe runs in a subshell3 with standard output connected to the pipe. The subshell also starts out with the same current directory, the same signal mask, etc. One of the few exceptions is that subshells do not inherit custom traps: ignored signals (trap '' SIGNAL) remain ignored in the subshell, but other traps (trap CODE SIGNAL) are reset to the default action4.

A subshell is thus different from executing a script. A script is a separate program. This separate program might coincidentally be also a script which is executed by the same interpreter as the parent, but this coincidence doesn't give the separate program any special visibility on internal data of the parent. Non-exported variables are internal data, so when the interpreter for the child shell script is executed, it doesn't see these variables. Exported variables, i.e. environment variables, are transmitted to executed programs.

Thus:

x=1
(echo $x)
prints 1 because the subshell is a replication of the shell that spawned it.

x=1
sh -c 'echo $x'
happens to run a shell as a child process of a shell, but the x on the second line has no more connection with the x on the second line than in

x=1
perl -le 'print $x'
or

x=1
python -c 'print x'
1 An exception is the ksh93 shell where the forking is optimised out and most of its side effects are emulated. 
2 Semantically, they're copies. From an implementation perspective, there's a lot of sharing going on. 
3 For the right-hand side, it depends on the shell. 
4 If you test this out, note that things like $(trap) may report the traps of the original shell. Note also that many shells have bugs in corner cases involving traps. For example ninjalj notes that as of bash 4.3, bash -x -c 'trap "echo ERR at \$BASH_SUBSHELL \$BASHPID" ERR; set -E; false; echo one subshell; (false); echo two subshells; ( (false) )' runs the ERR trap from the nested subshell in the “two subshells” case, but not the ERR trap from the intermediate subshell — set -E option should propagate the ERR trap to all subshells but the intermediate subshell is optimized away and so isn't there to run its ERR trap.