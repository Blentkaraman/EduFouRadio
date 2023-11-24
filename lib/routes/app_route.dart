import 'package:auto_route/auto_route.dart';
import 'package:radio_app/features/auth/views/home_view.dart';
import 'package:radio_app/features/auth/views/radio_play_view.dart';
import 'package:radio_app/features/auth/views/view_sign_in/sign_in.dart';
import 'package:radio_app/features/auth/views/view_sign_in/sign_up.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: SignInRoute.page,
    ),
    AutoRoute(page: SignUpRoute.page, initial: true),
    AutoRoute(
      page: HomeRoute.page,
    ),
    AutoRoute(
      page: RadioPlayRoute.page,
    )
  ];
}
