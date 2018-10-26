title: "Golang: allow calling DELETE handlers via POST"
author: "irth"
timestamp: 1540592978

I was designing an API recently and wanted to use all the fancy methods that HTTP provides.

One of those methods was `DELETE`.

The problem with all these methods is that I can't send them from e.g. a form without javascript.

The solution I used was to add a fallback POST method handler.

To avoid code repetition, I created a little helper function which I wanted to share today:

```golang
func FauxDelete(f http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			r.Method = "DELETE"
		}

		f(w, r)
	}
}

```

This allows me to write a single handler for GET and DELETE (because most of work in both of those handlers is related to finding the resource in the database, I merged them), and then reuse it for the fallback route.

```golang
func GetOrDelete(w http.ResponseWriter, r *http.Request) {
    // <common code>
    user, err := requireAuth(r, w)
    if err != nil {
        return
    }

    // parse the id from the url
    id, err := strconv.ParseInt(mux.Vars()["id"], 10, 64)
    if err != nil {
        // write http error
        return
    }

    resource := Resource{}
    err := GetResource(&resource, id)

    if err != nil {
        // write http error
        return
    }
    // </common code>

    if (r.Method == "DELETE") {
        err := DeleteResource(&resource)
        // handle err or write a response
        return
    }

    // write the OK response
    writeJSON(w, resource)
}
```

As you can see, it wouldn't make sense to have separate handlers for `DELETE` and `GET` as most of the code is common.

And, thanks to the `FauxDelete` function this handler can now be reused as is:

```golang
    // using gorilla mux
    r.HandleFunc("/resources/{id}", GetOrDelete).
        Methods("GET", "DELETE")
    r.HandleFunc("/resources/{id}/delete", FauxDelete(GetOrDelete)).
        Methods("POST")
```