import 'package:connectinno_task/core/router_navigation/app_router_name.dart';
import 'package:connectinno_task/features/auth/view/screen/auth_screen.dart';
import 'package:connectinno_task/features/home/view/screen/home_screen.dart';
import 'package:connectinno_task/features/notes_add/view/screen/notes_add_screen.dart';
import 'package:connectinno_task/features/profil/view/screen/profil_screen.dart';
import 'package:connectinno_task/features/register/view/screen/register_screen.dart';
import 'package:connectinno_task/features/root/root_screen.dart';
import 'package:connectinno_task/features/splash/view/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRouters.splash,
  routes: [
    GoRoute(
      path: AppRouters.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRouters.auth,
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: AppRouters.register,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: AppRouters.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRouters.profile,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: AppRouters.root,
      builder: (context, state) => const RootView(),
    ),
    GoRoute(
      path: AppRouters.notesAdd,
      builder: (context, state) => const NotesAddView(),
    ),
  ],
);
