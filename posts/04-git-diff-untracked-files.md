title: "Git: include untracked and/or staged files in diffs"
author: "irth"
timestamp: 1540591689

### Include untracked files in a diff

`git diff` by default only takes into account the files that are already tracked. You may want to include untracked files to, e.g. when using `git diff --stat` to see how many lines are added and deleted.

To make `git diff` notice the untracked file you need to signal the

#### Intent to add

```shell
git add --intent-to-add [file]
git add -N [file]  # equivalend
```

What `git add -N` does is adds the `[file]` path to the index, without its contents (without staging it). Now, when `git diff` compares the file on disk to the index, all lines show up as newly added.

### Include staged files in a diff

Another set of files that `git diff` ignores are the staged files. To change that, run it with `--staged`.

```shell
git add --staged
```