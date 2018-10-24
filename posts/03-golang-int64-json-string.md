title: "Golang: an int64 that serializes into JSON as a string"
author: "irth"
timestamp: 1540413121

```golang
package utils

import (
    "encoding/json"
    "fmt"
    "strconv"
)

type ID int64

func (i ID) MarshalJSON() ([]byte, error) {
    return json.Marshal(fmt.Sprint(i))
}

func (i *ID) UnmarshalJSON(b []byte) error {
    var iStr string
    err := json.Unmarshal(b, &iStr)
    if err != nil {
        return err
    }

    val, err := strconv.ParseInt(iStr, 10, 64)
    if err != nil {
        return err
    }

    *i = ID(val)
    return nil
}
```

Because Javascript doesn't support 64 bit integers (everything is stored as a float64), if you're sending them as JSON in a JSON API response to the browser, you probably want to convert them to and from ints.

Here's a type you can use in your structs or wherever to do this automatically when (un)marshalling JSON.

---

#### about my previous blog post

So of course I can't ever get my shit together and be systematic with anything, so I failed to deliver on any promise from the previous blog. I'm fighting the urge to delete it and pretend nothing ever happened, but I don't think that's a good thing to do.

I've been reading a book, *The Antidote: Happiness for People Who Can't Stand Positive Thinking* by Oliver Burkeman, recently, and one thing it suggests is that setting goals and chasing them might actually get you further away from them (A so called *negative path to success* is proposed as an alternative, read the book if you want to know more I guess).

Therefore, I'm not going to set any goals or resolutions this time, and just try to write down whatever I learn. If I don't do that, too bad. Let's see how it goes.