# Anatomy of an HTTP request

**HTTP** stands for **HyperText Transfer Protocol** — it’s the foundation of data communication on the web.

**HTTP is the language that a client and web servers use to talk to each other.**

- When you type a URL, or click on a link, or submit a form and hit Enter, your client sends an HTTP request to the server.
- The server sends back an HTTP response, usually containing HTML, CSS, or JSON.
- Your client displays the result.

![client-server](/images/client-server.png)

_Let’s imagine your browser is a customer in a restaurant. The HTTP request is your order. The server is the kitchen. And the HTTP response is your food._

## HTTP request and response cycle

Requests and responses are plain text files.
Here is how request looks like:

```html
GET /wiki/Chicago HTTP/1.1
Host: en.wikipedia.org
```
The first line is called the request line. It has three parts:

- **Verb:** Specifies the desired action (_e.g., GET, POST, PATCH, DELETE_).
- **Resource path:** Indicates the resource's address (_/wiki/Chicago_).
- **The HTTP version:** In this example, _HTTP/1.1_ (and it's most common used).

Second line are a list of key-value pairs called **headers:** The Host header is required: it specifies the address of the server (in this example, _en.wikipedia.org_).

Wikipedia’s server sends back the response (that is also plain text file ):

```html
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Chicago - Wikipedia</title>

  <!-- Hundreds more lines of HTML describing Chicago -->
```

The first line of the response is the **status line**. It has three parts:
- **The HTTP version** (in this example, **HTTP/1.1**).
- **A status code** (in this example, **200**). Other common [status codes](https://http.cat/):
  - **404** (resource not found), 
  - **500** (internal server error), 
  - **403** (don’t have permission to access), 
  - **302** (“redirect”, or “keep on moving to a different URL”), etc.
- **Reason phrase** which is a description of status code (in this example, **OK**).

Second line has a list of key-value pairs called **headers**.  
The `Content-Type` let the client know what format of the content is being returned (in this example, **text/html** (Hypertext Markup Language)).  
After the headers comes a blank line.  
Everything after the blank line is the **body** of the response. In this example, the source code for a whole HTML document about Chicago.  

[Chicago Wikipedia page](https://en.wikipedia.org/wiki/Chicago)

## Placing requests with a browser

**URL** (Uniform Resource Locator, also known as Uniform Resource Identifier — URI)

![client-server](/images/anatomy-of-url.png)

- The scheme can either be **http** or **https**. 
  - **http**, the request is sent from client to server in plain text. That means all the computers along the way could, in theory, read the contents of the request; which isn’t very secure.
  - **https**, encrypted and secured request (use it)
- After the :// up until the first slash (/) it encounters is the **host**.
- Everything from the first / onwards is the **resource path**.

**The address bars of browsers can only place GET requests.**

## API client

- [Envoy](https://envoy.firstdraft.com/users/sign_in) 
- [Chatter](https://chatter.matchthetarget.com/users/sign_in)

Here we can GET:
- `/`: Displays all of the tweets from everyone.
- `/ellen`: Displays a single user’s profile.
- `/alice/feed`: Displays the signed in user’s feed (must be signed in as that user).

### Log in

```html
POST /users/sign_in HTTP/1.1
Host: chatter.matchthetarget.com
Content-Type: application/x-www-form-urlencoded

email=alice@example.com&password=password&remember_me=true
```
POST request:

- The `Content-Type` header is set to `application/x-www-form-urlencoded`.
- The **body** of the request is a **“query string”** - key-value pairs. Each label (or key) is separated from its value by an `=`.
- The key/value pairs are separated from each other by an `&`.
- In this case, the labeled values are the inputs a user is expected to type into the form, e.g.:  
`email → alice@example.com`  
`password → password`  
`remember_me → true`  

This HTTP request is exactly the same as the request that the browser sends when we fill out the form on the login page.

### Get a user’s profile

```html
GET /eve HTTP/1.1
Host: chatter.matchthetarget.com
```

### Get a user’s feed

```html
GET /alice/feed HTTP/1.1
Host: chatter.matchthetarget.com
```

### Post a tweet
```html
POST /tweets HTTP/1.1
Host: chatter.matchthetarget.com
Content-Type: application/x-www-form-urlencoded

tweet[body]=Hello from Envoy!
```

## Pirate Weather
If companies want third-party apps to integrate their services, then they will accept HTTP requests and return the information in formats that are easy for apps to parse and use — usually, JSON or XML. These requests are called **“API requests”** or **“API calls”**.  

[Pirate Weather](https://pirateweather.net/en/latest/) is a service that will returned very detailed weather information in response to HTTP requests like this:

```html
GET /forecast/FIND_THE_PIRATE_WEATHER_API_KEY_IN_COURSE_SECRETS_AND_PUT_IT_HERE/41.8887,-87.6355 HTTP/1.1
Host: api.pirateweather.net
```

[secrets](https://learn.firstdraft.com/runs/76/learner/secrets)

## Google Maps

```html
GET /maps/api/geocode/json?address=Merchandise Mart Chicago&key=FIND_THE_GMAPS_KEY_API_KEY_IN_COURSE_SECRETS_AND_PUT_IT_HERE HTTP/1.1
Host: maps.googleapis.com
```

## OpenAI

```html
POST /v1/chat/completions HTTP/1.1
Host: api.openai.com
Authorization: Bearer FIND_THE_OPENAI_API_KEY_IN_COURSE_SECRETS_AND_PUT_IT_HERE
Content-Type: application/json

{
  "model": "gpt-4o",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant who talks like Shakespeare."
    },
    {
      "role": "user",
      "content": "Hello!"
    }
  ]
}
```