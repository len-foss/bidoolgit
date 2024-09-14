# bidoolgit
Helper script to shorten Git

![Logo](bidoolgit.webp)

The aim is to be most efficient while have very little to type and remember.

This is a personal workflow, simple enough to be adapted to remove any
dependencies it has, or serve as a template for a similar workflow.
There are many ways to use `git` efficiently.

For instance, by developing one feature at a time, I can almost always `git add -u`
for the next commit, so this command has a shortcut, `g a`.
Adding specific files only with `git add path/to/file` is a much rarer occurrence
so there is nothing to shorten it.
If instead you always have multiple commits in your diff, it would be preferable
to have this as a shortcut for `git add -p`.

Why use this approach rather than git aliases or yet another one?
Simply because this approach is extremely generic and so can be applied
to completely different settings, without polluting the general namespace.
See for example `bidoolgi`.

## Requirements

One part of the workflow depends on [git-absorb](https://github.com/tummychow/git-absorb).
It can be skipped entirely, but it really facilitates good commit hygiene.
This part also depends on [pre-commit](https://pre-commit.com/),
to solve the interaction between the two.

## Install

Copy the `g.sh` script in a folder on your path as `g`.
Make sure it is executable, using `chmod +x` if needed.
In Ubuntu, `~/bin` is on your path, in doubt check with `echo $PATH`.

Another approach, to keep the file under its git repo, is to put in your path a `g` file with content:
```bash
#!/bin/bash
bash ~/src/bidoolgit/g.sh "$@"
```
So that the script is always up-to-date.

## Usage

### status
To check the current status, use `g s`.
To see the diff, use `g d` or `g dc` to see the staged diff.
To check the last commit, use `g sh`.

### branches
To checkout or create a branch, use `g ch $BRANCHNAME`.
To list all local branches, use `g b`; to list all branches, use `g ba`.
To delete a branch, use `g x $BRANCHNAME`.

### commit
To stage all changes, use `g a`.
To stage everything, including untracked files, use `g aa`.

Since we should be working with atomic commits,
these two commands should cover almost all adds.
Working on several commits at the same time requires an additional
selection step which is unnecessary overhead.
Note that similarly it you can use a global `.gitignore`
and a local `tmp` folder to ensure you can always add all untracked
when necessary.

You can use `g ap` for `git add -p` and `g dr` to reset the staging area,
which cover the exceptions to this workflow.

To commit without a message, use `g c`.
Use `g am` to amend the last commit.
Use `g cp $HASH` to cherry-pick `$HASH` commit.

### remotes
To fetch all remotes, use `g f`, then `g m` to merge.
To push the current branch on the default remote, use `g pb`;
it uses `origin`, or you can use `g pb $REMOTE`.
To force-push a tracked branch, use `g pf`.

### rebase
To rebase the last `$I` commits, use `g r $I`.
To rebase on `origin/master`, use `g rr`,
or specify a base branch with `g rr $BASE`.

### stash
To stash 'in', use `g si`.
To stash 'out, use `g so`.

To stash in a patch, use `g sp name`.
To restore this patch, use `g sa tmp/name`
It will create a temporary commit to hold the patch.

### undo
Undo the last commit (keeping the changes) with `g h`.

You can check the `reflog` by using `g ref`.
You can then rewind to a given state with `g rb`.

Using the reflog is the way to cancel any action, including
squashing commits, or messing up a rebase.
As such, it provides ultimate confidence that it is impossible
to ever lose any work because of git.

### absorb
Git absorb is your best friend to have a good commit history
on a feature branch without much efforts.

To run absorb, use `g j` (mnemonic is 'join').
One current limitation of absorb is that it does not stop on pre-commit hooks.
Which means the linting will actually be skipped.
To avoid this, run `g jp` ('join/pre-commit').
This will save affected files, run absorb,
and then run pre-commit on these files.
If there is a diff, run the absorb phase again as needed.

In case absorb failed to rebase, you can rebase with `g jr`
(by default on `origin/master`, you can specify an optional base).

## configuration and multiple git identities

The standard approach to manage multiple git identities is to use separate folders for each one.
Typically, the `.gitconfig` should contain something of the form: 
```bash
[includeIf "gitdir:~/src_gid/"]
	path = ~/src_gid/.gitconfig
```
Then in `.ssh/config` you can specify the identity file to use:
```bash
Host githubgid.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_gid
```
The command `g cl` will clone the repository while setting the right host if the file `.githubhost` is present with content `gid` (the file is named `githubhost` but there is nothing tied to github, it works the same with Gitea or Gitlab).

You can check the current configuration (in edit mode) with `g cfg`.
