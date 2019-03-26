title: "Project 42"
author: "irth"
timestamp: 1553598381


I've started a new project two days ago, the idea for which has been in my
head for quite a while, and I've even managed to implement a proof of concept
in Golang.

The basic idea is that two people log in on a website via Spotify, the app
fetches their music libraries from the Spotify API and computes the
intersection of their music libraries, so they can have a playlist they can
both listen to together.

The name **Project 42** is a codename, "42" in this case means *"four two"*,
because the app helps make playlists **for two** people.

I thought to myself that it might be a good idea to blog the progress, so that
I can keep track of what I learn and reference it later.

## Tech stack

Originally I wrote the proof of concept in Golang, mainly because I was
fascinated by that language at the time. Now, I wish to learn Ruby on Rails,
so naturally I chose that as the basis for the project.

I knew I needed to be able to run jobs in background (to fetch large music
libraries) and have a way to report the progress to the user. Golang has
wonderful features for that - [goroutines](https://gobyexample.com/goroutines)
and [channels](https://gobyexample.com/channels), and the
[`gorilla/websocket`](https://github.com/gorilla/websocket) library solves the
progress-reporting problem.

So I began looking for Rails-based alternatives, and turns out Rails has all I
need built in:

* **Active Job** is a framework provided by Rails for declaring and running
  background jobs in queues.

* **Active Cable** is Rails's solution for websocket communication, it is
  built into Rails since the 5th version and also provides a client-side
  library.

The last missing part was a library for the Spotify API, but a quick Google
search led me to [RSpotify](https://github.com/guilhermesad/rspotify) which
contains everything I need, including an
[OmniAuth](https://github.com/omniauth/omniauth) provider.

---

I really hope I can finish this project this time. I'll try to come up with
some deadlines to make sure I stay focused and I'll try to post a progress
update whenever I reach a deadline. Well, that's it for today.