title: "Golang: separate third party code from your own"
author: "irth"
timestamp: 1541275171


I am using [BorgBackup](https://borgbackup.readthedocs.io/en/stable/) to backup my entire home, exluding some folders (cache, node_modules, etc).  
I want to have a backup of all my code (even though I keep it on github and my private [Gogs](https://gogs.io/) instance), so I didn't want to exclude the entire GOPATH, but because of all the installed third-party dependencies, it grew pretty big in size.

#### Solution:
Multiple GOPATH entries.

You can use multiple directories as your GOPATH.

```shell
$ go env GOPATH
/home/me/.local/share/go:/home/me/code/go
```

The way this works, `go get` defaults to the first directory (so, `~/.local/share/go`), so the third-party code lands there, and for my personal projects, I can manually create the directories in `~/code/go`. Go `import` statements check both directories.

This way I can put `~/.local/share/go` in my exclusion list and not waste space by backing up the third-party code.
