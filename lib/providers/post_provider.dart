import 'package:flutter/cupertino.dart';
import 'package:facebook_feed/models/post_model.dart';

class PostProvider with ChangeNotifier{
   List<PostModel> _posts = [];
   List<PostModel> get allPosts => _posts;
   void addPost(PostModel post) {
     _posts.insert(0,post);
     notifyListeners();
   }
   void removePost( int index){
     if (index >= 0 && index < _posts.length) {
       _posts.removeAt(index);
       notifyListeners();
     }
   }



   void updatePost(int index, PostModel newPost) {

     if (index >= 0 && index < _posts.length) {
       _posts[index] = newPost;
       notifyListeners();
     }
   }

}