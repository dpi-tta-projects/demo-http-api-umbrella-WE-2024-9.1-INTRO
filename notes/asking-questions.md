# Asking Questions
Our rule: You’re only allowed to get stuck for 15 minutes before writing up a question.  
This course is question-driven, we need you to ask questions.

## Why?
Writing out what you’re struggling with will often help you solve it yourself.  
Writing well is an essential component of succeeding as a technologist (remote work, StackOverflow, GitHub, etc.)

## 5 Step Framework for Writing Excellent Questions
- State the problem you’re working on
- What is your code doing right now?
- What do you want it to be doing instead?
- Copy-paste the snippet(s) of code that you think are relevant.
- Describe what you’ve tried so far to resolve.

## Example
### 1. State the problem you’re working on
- I’m working on a basic Sinatra app where I need to display a welcome message on the homepage.

### 2. What is your code doing right now?
- Right now, when I navigate to the root URL `(/)`, I see a `“Not Found”` error message in the browser instead of my custom homepage.

### 3. What do you want it to be doing instead?
- I want the root URL to render my `index.erb` template, which contains a welcome message.

### 4. Copy-paste the snippet(s) of code that you think are relevant
```ruby
# app.rb
require "sinatra"

get("/") do
  erb(:index)
end
```
```html
<!-- index.erb -->
<h1>Welcome to my Sinatra app!</h1>
<p>This is the homepage.</p>
```

### 5. Describe what you’ve tried so far to resolve
- I have restarted the Sinatra server and verified that my views folder is in the correct location. I also double-checked the path in the erb method to ensure it correctly references index.erb, but the problem persists.

### Providing github url is also great

## Where to ask?
- discord
- study buddy
- stackoverflow
- ChatGPT

## Putting code snippets
using backticks `code` ` # your code `

` This is a code snippet `

```ruby
  def some_code()
    # some code goes here
  end
```

```ruby
# this is now ruby code
```

```ruby
pp "#{hello_world}"
```

```html
<h1>Hello, world!</h1>
```