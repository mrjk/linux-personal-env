Linux is powerfull, but youre life will be better if you have configured your shell and all application you use.

## Installation

Those files can be put in your home, or system-wide. I personally use them as system-wide configuration, with Debian. If you use it with another system, you may need some ajustments, or even better, you can pick some snippets and directly add them to your configuration files.

## Features

Yeah, so what's upp? Basically, the first point was to make the difference between bash and login. So I updated the file to follow this rule. I made some clean, and I put some comments almost everywhere. 

Login feature:
* When changing user, a little description appears about the user, it's permission, home, uid, gid, if he has some keys in its home ... Only informational, but can make your life easier.
* A function which detects if you are connected in serial (mainly used for broken VMs), and set TMOUT in this case to avoid opened shell.

Bash features: 
* Builtin Variables for Colors and Regex (might be buggy, and not so easy to use)
* Dynamic and colored PS1 prompt, with fallback if too slow (see below)
* A list of predifined shell aliases and functions
* Completion enabled
* Command not found enabled
* Preset of programms for coloration (Less, tail, diff)
* Bash behaviour configuration

## Prompt usage
Example (in black and white):
```
jez@jezbordel:~/git/linux-personal-env/bash/profile.d tail -f /var/log/syslog & ; cat /IDontExists.txt
256 1:1 jez@jezbordel:~/git/linux-personal-env/bash/profile.d
```
Colors for:
* return code: give you the last return code of the last command, if not 0
* jobs: it give you currently running jobs, and paused jobs
* user: green if you are root, white if you are a normal user, yellow if you are a daemon user and red if the account does not support shell
* double colon: Colon is normally white, but it become yellow if the partition is 80% used, red if 95% used, and yellow if you are on Kernel filesystem (like ``/proc``, ``/sys``)
* path: Usually in blue, it becomes yellow if you cannot write on this path (soooo usefull when you move your ``CWD`` from another terminal)


## Notes

This may be improved to support git, svn, whatever shell. I guess I will need it later, so it may be implemented in some days. The point is nothing special, bu you might be interested to see how I set up the $PS1 variable.

Sorry for the gramma spelling, I don't like to read again what I wrote :p (except or code)

## License

Thoses files are licensed under the GNU GENERAL PUBLIC LICENSE 2. Please modify, update, fork, distribute, whatever!
