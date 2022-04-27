# Budget App

> The Ruby on Rails Budget App is about building a mobile web application where user can manage the budget: they have a list of transactions associated with a category, so that the user can see how much money they spent and on what.
> The project is following data model below: 
> ![diagram](https://github.com/microverseinc/curriculum-rails/blob/main/capstone/images/erd_diagram.png)
## Built With

- Ruby
- Ruby on Rails
- PostgreSQL

## Live Demo 

- [Check the app](https://fathomless-inlet-13455.herokuapp.com/)
- [Video Presentation](https://www.loom.com/share/443abd715e8140fa917faa549a8571d5)

## Getting Started

- [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) on your local machine 
- [Install Ruby on Rails](https://guides.rubyonrails.org/v5.1/getting_started.html)
- Clone [this repository](https://github.com/akucintavalent/budget)
  ```
  git clone git@github.com:akucintavalent/budget.git
  ```
- To get started, In the root directory run:
  ```
  gem install bundler
  ```
  Then run:
  ```
  bundle install
  ```
  To start the server run: 

  ```
  rails s
  ```
  Open the browser with `localhost:3000`

  
## After installing bundle

Please run the following commands `rails db:create` `rails db:migrate` `rails s`

## Tests
```
bundle exec rspec
```
Or
```
rspec spec
```
### To track linter errors locally follow these steps:  

Track linter errors run:
```
rubocop
```

## Author

:man: **Bohdan Shcherbak**

- [GitHub](https://github.com/akucintavalent)
- [LinkedIn](https://www.linkedin.com/in/bohdan-shcherbak/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Meri-MG/budget-app-rails/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Thanks [Gregoire Vella on Behance](https://www.behance.net/gregoirevella) for the original design idea.

## 📝 License

This project is [MIT](./MIT.md) licensed.