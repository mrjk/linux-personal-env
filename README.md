Linux is powerful, but you can make your life easier if you have configured your shell and applications you use.


Currently, I provide a bash (shell) configuration and a list of package. More things may come later.

## Shell 

These files can be put in your home, or system-wide. I personally use them as system-wide configuration, with Debian. If you use it with another distribution, you may need some adjustments; or even better, you can pick some code snippets and directly add them to your configuration files.

### Features

Basically, the first point was to make the difference between bash and login. So I updated the file to follow this rule. I made some clean, and I put some comments almost everywhere. 

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

Each feature is not enabled by default, but you can enable them by calling the proper function.

### Prompt usage
Example (in black and white):
```
jez@jezbordel:~/git/linux-personal-env/bash/profile.d tail -f /var/log/syslog & ; cat /IDontExists.txt
256 1:1 jez@jezbordel:~/git/linux-personal-env/bash/profile.d
```
Colors explanation:
* return code: it gives you the last return code of the last command, if not null
* jobs: it gives you running jobs, and paused jobs
* user: green if you are root, white if you are a normal user, yellow if you are a daemon user and red if the account doesn't allow shell
* double colon: usually white, it becomes yellow if the partition is 80% used, red if 95% used, and yellow if you are on Kernel filesystem (like ``/proc``, ``/sys``)
* path: usually in blue, it becomes yellow if you cannot write on this path (soooo usefull when you move your ``CWD`` from another terminal)

Note: This prompt can be a bit buggy, especially when your system become slow, or when you are on slow responding file systems. If the prompt detects some slowness, it will fall back to a simpler prompt. It is still experimental, but I didn't have any issue with that for now. You can edit some variables to modify its behaviour directly into the files.

## Package list

It is a list of basic package I personnally use on my Debian systems. Feel free to google them to know what they do, and to adapt the package name to your distro. Nothing more.


## Notes

Bash:
* The prompt may be improved to support git, svn, whatever shell. I guess I will need it later, so it may be implemented in some days. The point is nothing special, bu you might be interested to see how I set up the $PS1 variable. 
Package list:
* The default package (Debian) list can be also useful.

Sorry for the gramma spelling, I don't like to read again what I wrote :p (except for coding)

## License

Thoses files are licensed under the GNU GENERAL PUBLIC LICENSE 2. Please modify, update, fork, distribute, whatever!
