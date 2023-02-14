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
function _xs {
    git branch --merged >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
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
    N=${2:-*}
    git add -u && git commit -n -m "*"
    git format-patch HEAD~1 --stdout > tmp/$N.patch
    git reset --hard HEAD^
}
function _sa {
    N=${2:-*}
    git am -3 < $N
}
# commit
function _a {
    if [ $# -le 1 ]
      then
        git add -u
      else
        git add "${@:2}"
    fi
}
function _aa {
    git add .
}
function _ap {
    git add -p "${*:2}"
}
function _r {
    git rebase -i HEAD~$2
}
function _rr {
    R=${2:-origin/master}
    git rebase $R
}
function _cm {
    git commit
}
function _c {
    if [ $# -le 1 ]
      then
        git commit -m "*"
      else
        git commit -m "${*:2}"
    fi
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
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if [ "$BRANCH" == "master" ]; then
        echo "Refusing to run on master"; exit 1;
    fi
    git push -u $R $BRANCH
}
function _p {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git push
}
function _pf {
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if [ "$BRANCH" == "master" ]; then
        echo "Refusing to run on master"; exit 1;

    fi
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
