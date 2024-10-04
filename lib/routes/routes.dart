import 'package:flutter/material.dart';
import 'package:facebook_feed/auth/login_scree.dart';
import 'package:facebook_feed/feed/comments.dart';
import 'package:facebook_feed/routes/routes_name.dart';

import '../auth/change_password.dart';
import '../auth/forgot_password.dart';
import '../auth/registration_screen.dart';
import '../auth/verify_password_reset.dart';
import '../feed/create_post_screen.dart';
import '../feed/feed_screen.dart';
import '../feed/update_post_screen.dart';
import '../models/post_model.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.logInScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LogInScreen(),
        );
      case RoutesName.registerScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegistrationScreen(),
        );
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPassword(),
        );
      case RoutesName.feedScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FeedScreen(),
        );
      case RoutesName.verifyPasswordReset:
        return MaterialPageRoute(
          builder: (BuildContext context) => const VerifyPasswordReset(),
        );
      case RoutesName.changePassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ChangePassword(),
        );
      case RoutesName.createPostScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CreatePostScreen(),
        );
      case RoutesName.updatePostScreen:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final PostModel postModel = arguments['postModel'] as PostModel;
        final int index = arguments['index'] as int;

        return MaterialPageRoute(
          builder: (BuildContext context) => UpdatePostScreen(
            postModel: postModel,
            index: index,
          ),
        );

      case RoutesName.comments:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final PostModel postModel = arguments['postModel'] as PostModel;
        final int index = arguments['index'] as int;

        return MaterialPageRoute(
          builder: (BuildContext context) => Comments(
            postModel: postModel,
            index: index,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
