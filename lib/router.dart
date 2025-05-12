import 'package:go_router/go_router.dart';

import 'Routes.dart';
import 'add_new_user_screen.dart';
import 'home_screen.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const MyHomePage(title: 'Home Page',),
    ),
    GoRoute(
      path: Routes.addNewUser,
      builder: (context, state) => const AddNewUserScreen(title: 'Add New User',),
    ),
  ]
);
