# Helpers for the Foundation Ink framework

## Introduction

The [Ink framework](https://github.com/zurb/ink) eases the pain of creating the responsive e-mail templates, but it come with a price. Consider this markup, which is needed for having 8 + 4 columns:

```html
<table class="container">
  <tr>
    <td>
      <table class="row">
        <tr>
          <td class="wrapper">
            <table class="columns eight">
              <tr>
                <td>
                  Eight Columns
                </td>
                <td class="expander"></td>
              </tr>
            </table>
          </td>
          <td class="wrapper last">
            <table class="columns four">
              <tr>
                <td>
                  Four Columns
                </td>
                <td class="expander"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
```

Wouldn't it be nicer if it was possible to write it more succinctly using Slim:

```slim
= container
  = row
    = columns.eight
      ' Eight Columns
    = columns.four.last
      ' Four Columns
```

... or even if using ERB:

```erb
<%= container do %>
  <%= row do %>
    <%= columns.eight do %>
      Eight Columns
    <% end %>
    <%= columns.four.last do %>
      Four Columns
    <% end %>
  <% end %>
<% end %>
```
...well this is what this gem does for you.


## Usage

Add do your Gemfile:

    gem 'inklet'    

In your templates use the "container", "row" and "columns" methods. 

## Contributing to inklet

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Roman Shterenzon. See LICENSE.txt for further details.