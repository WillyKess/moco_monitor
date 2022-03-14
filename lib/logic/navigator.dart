import 'package:get_it/get_it.dart';
import 'package:moco_monitor/logic/storage.dart';
import 'package:moco_monitor/pages/class.dart';
import 'package:moco_monitor/pages/home.dart';
import 'package:moco_monitor/pages/login.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// bool hasValidCredentials = (RM.get('prefs').state as Prefs).hasValidCredentials;
bool hasValidCredentials = GetIt.instance<Prefs>().hasValidCredentials;
final InjectedNavigator myNavigator = RM.injectNavigator(
  debugPrintWhenRouted: true,
  // Define your routes map
  routes: {
    '/': (RouteData data) => const Home(),
    // redirect all paths that starts with '/home' to '/' path
    '/login': (RouteData data) => const LoginScreen(),
    //  '/classes': (RouteData data) => const ClassesView
    '/classes/:id': (RouteData data) {
      // Extract path parameters from dynamic links
      // OR inside Page2 you can use `context.routeData.pathParams['id']`
      final String? id = data.pathParams['id'];
      return id == null ? const Home() : Class(id: id);
      // '/page3/:kind(all|popular|favorite)': (RouteData data) {
      // Use custom regular expression
      //  final kind = data.pathParams['kind'];
      //  return Page3(kind: kind);
    },
    // Use custom regular expression
  },
  //  '/page4': (RouteData data) {
  // Extract query parameters from links
  // Ex link is `/page4?age=4`
  //  final age = data.queryParams['age'];
  // OR inside Page4 you can use `context.routeData.queryParams['age']`
  //  return Page4(age: age);
  // },
  // Using sub routes
  // '/page5': (RouteData data) => RouteWidget(
  //       builder: (Widget routerOutlet) {
  //         return MyParentWidget(
  //           child: routerOutlet;
  // OR inside MyParentWidget you can use `context.routerOutlet`
  //             )
  //           },
  //           routes: {
  //             '/': (RouteData data) => Page5(),
  //             '/page51': (RouteData data) => Page51(),
  //           },
  //         ),
  //  },
  //
  // Called after a location is resolved and just before navigation.
  // It is used for route guarding and global redirection.
  onNavigate: (RouteData data) {
    final toLocation = data.location;
    if (toLocation == '/' && !hasValidCredentials) {
      return data.redirectTo('/login');
    }
    if (toLocation == '/login' && hasValidCredentials) {
      return data.redirectTo('/');
    }

    //You can also check query or path parameters
    //  if (data.queryParams['userId'] == '1') {
    //    return data.redirectTo('/superUserPage');
    //  }
  },
  //
  // Called when route is going back.
  // It is used to prevent leaving pages before date is validated
  //  onNavigateBack: (RouteData? data) {
  //    if(data== null){
  //      // data is null when the back Button of Android device is hit and the route
  //      // stack is empty.

  //      // returning true we will exit the app.
  //      // returning false we will stay on the app.
  //      return false;
  //    }
  //    final backFrom = data.location;
  //    if (backFrom == '/SingInFormPage' && hasValidCredentials) {
  //      RM.navigate.toDialog(
  //        AlertDialog(
  //          content: Text('The form is not saved yet! Do you want to exit?'),
  //          actions: [
  //            ElevatedButton(
  //              onPressed: () => RM.navigate.forceBack(),
  //              child: Text('Yes'),
  //            ),
  //            ElevatedButton(
  //              onPressed: () => RM.navigate.back(),
  //              child: Text('No'),
  //            ),
  //          ],
  //        ),
  //      );

  //      return false;
  //    }
  //  },
);
