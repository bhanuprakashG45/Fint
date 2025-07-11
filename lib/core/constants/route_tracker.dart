import 'package:fint/core/constants/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteTracker extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _saveRoute(route.settings.name);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _saveRoute(newRoute?.settings.name);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _saveRoute(previousRoute?.settings.name);
  }

  void _saveRoute(String? route) async {
    final prefs = await SharedPreferences.getInstance();
    if (route != null) {
      await prefs.setString('last_screen', route);
      print('Saved route: $route');
    }
  }
}
