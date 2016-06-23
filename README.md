# Ruby Transformations

### Exercise 1

Create a method to accept string as an argument, and return a string of length 26.

The objective is to detect if letters of the english alphabet (upper or lower case) are present anywhere in the string, and to set each of the 26 characters corresponding to each letter to either '1' if present, '0' if not.

So if an 'a' or an 'A' appears anywhere in the argument string (any number of times), set the first character of the returned string to '1' otherwise to '0', if 'b' or 'B' the the second to '1', and so on for the rest of the alphabet.

So the returned string consists only of '1's and '0's.

`letter_occurance_check("abcz") # => "11100000000000000000000001"`

when nil or blank string given it should return string with all 0

### Exercise 2

Create a **sum_args** method which sums all given arguments

### Exercise 3

Create two methods:
- **to_camel_case** which changes underscore case string  to a camelcase string `to_camel_case("this_is_string") => "thisIsString"`

- **to_capital_case** which changes underscore case string to a capitalized case string
`
to_capital_case("this_is_string") => "ThisIsString"
`


### Exercise 4

Implement a **prepare_image_details** method which accepts image_id and image_data as a hash

`prepare_image_details(10, image_data)`

image_data:

```
      {
        "original" => {"format"=>"jpg", "geometry"=>"1440x900"},
        IMAGE_TYPE => { "format" => jpeg|jpg|png , "geometry" => WIDTHxHEIGHT },
        ...
      }

```

Result:

```
[
      {
        width: 1440, height: 900, content_type: "image/jpeg", image_type: "original",
        image_url: "http://images_server.com/images/10/original.jpg"
      },
      {
        width: WIDTH, height: HEIGHT, content_type: "image/jpeg|png", image_type: IMAGE_TYPE,
        image_url: "http://images_server.com/images/10/IMAGE_TYPE.format"
      }, ...
]

```

Requirements:
- image_url: `"http://images_server.com/images/IMAGE_ID/IMAGE_TYPE.FORMAT"`
- content_type: `image/png` for `png` format, `image/jpeg` for `jpeg|jpg` formats



## Setup

### To install dependencies

    bundle install

### Run tests

To run tests execute

    bundle exec rspec spec

Good luck!
