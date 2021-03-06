#!/bin/bash

# status
function _s {
    git status
}
function _sh {
    git show
}
function _d {
    git diff
}
function _dc {
    git diff --cached
}
function _dr {
    git reset
}
# branches
function _b {
    git branch -a
}
function _x {
    git branch -D $2
}
function _ch {
    git checkout $2 2>/dev/null || git checkout -b $2
}
function _f {
    git fetch --all
}
function _m {
    git merge
}
# stash
function _si {
    git stash
}
function _so {
    git stash pop
}
function _sp {
    git add -u && git commit -n -m "*"
    git format-patch HEAD~1 --stdout > tmp/$2.patch
    git reset --hard HEAD^
}
function _sa {
    git am -3 < $2
}
# commit
function _a {
    git add -u
}
function _aa {
    git add .
}
function _ap {
    git add -p
}
function _r {
    git rebase -i HEAD~$2
}
function _rr {
    R=${2:-origin/master}
    git rebase $R
}
function _c {
    git commit -m "*"
}
function _am {
    git commit --amend
}
function _cp {
    git cherry-pick $2
}
function _j {
    git absorb --and-rebase
}
function _jp {
    FS=$(git diff --cached --name-status | cut -f2 | tr '\n' ' ')
    git absorb --and-rebase
    pre-commit run --files $FS
}
function _jr {
    B=${2:-master}
    git rebase -i --autosquash $B
}
function _pb {
    R=${2:-origin}
    git push -u $R `git rev-parse --abbrev-ref HEAD`
}
function _pf {
    git push -f
}
# undo
function _h {
    git reset HEAD~
}
function _ref {
    git reflog
}
function _rb {
    git reset HEAD@{$2}
}

_$1 "$@"
