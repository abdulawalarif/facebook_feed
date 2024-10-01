import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/providers/post_provider.dart';
import 'package:facebook_feed/routes/routes.dart';
import 'package:facebook_feed/routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PostProvider()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.logInScreen,
          onGenerateRoute: Routes.generatedRoute,
        ),
      );
    },);
  }
}

