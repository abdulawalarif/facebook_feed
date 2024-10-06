# Flutter dart project for integrating Facebook news feed.

## AFlutter project where I have implemented Facebook feed UI CRUD with comments, reactions and so on.



![Login and reaction](<one.gif>) 

This project is for integrating Facebook feed Graph API into your applications.  This codebase is only for the UI, and there is no backend integration. The features are the following:

* Authenticating: User login/registrations/ forgot passwords (Password recovery).
* Creating posts with different backgrounds and image posting.
* Load posts on the UI interacting with the provider and a fake model.
* Commenting on posts.
* React different emojis.


## Run Locally

Clone the project

```bash
  git clone https://github.com/abdulawalarif/facebook_feed.git
```

Go to the project directory

```bash
  cd facebook_feed
```

Install dependencies

```bash
  flutter pub get
```

Connect a physical device or start a virtual device on your machine

```bash
  flutter run
```


## How to tweak this project for your own uses

It's a good starter boilerplate, For Facebook feed integration into your applications. Change the emoji according to the latest Facebook guidelines.
Interact with the provider for sending posts to the server and fetching them from the servers.

## Found a bug?

If you found an issue or would like to submit an improvement to this project,
please submit an issue using the issues tab above. If you would like to submit a PR with a fix, reference the issue you created!


## Known issues (Work in progress)
*  Single image preview.
*  Reaction implementation with each post with keys.
*  Comment on children based on the parent's comments.
*  Expending the post after 10 lines of text.
*  Like and reaction count below every post.



## Author

- [@abdulawalarif](https://github.com/abdulawalarif)
  
## License

[MIT](https://choosealicense.com/licenses/mit/)


