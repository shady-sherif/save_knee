import 'package:go_router/go_router.dart';
import 'package:save_knee_23/features/auth/views/login_view.dart';
import 'package:save_knee_23/features/auth/views/register_view.dart';
import 'package:save_knee_23/features/chat/views/chat_view.dart';
import 'package:save_knee_23/features/home/view_models/user_model.dart';
import 'package:save_knee_23/features/home/views/home_view.dart';
import 'package:save_knee_23/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kChatView = '/chatView';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, state) => const SplashView(),
      ),
      GoRoute(
        path: kChatView,
        builder: (_, state) {
          final doctorModel = state.extra as UserModel;
          return ChatView(doctorModel: doctorModel);
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (_, state) => const HomeView(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (_, state) => const RegisterView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (_, state) => const LoginView(),
      ),
    ],
  );
}
