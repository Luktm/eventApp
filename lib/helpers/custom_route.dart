import 'package:flutter/material.dart';

// class CustomRoute<T> extends MaterialPageRoute<T> {
//   CustomRoute({WidgetBuilder builder, RouteSettings settings})
//       : super(
//           builder: builder,
//           settings: settings,
//         );

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     if (settings.arguments) {
//       return child;
//     }

//     return ScaleTransition(
//       scale: Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(
//         CurvedAnimation(
//           parent: animation,
//           curve: Curves.fastOutSlowIn,
//         ),
//       ),
//       child: child,
//     );
//   }
// }

// class CustomPageTransitionBuilder extends PageTransitionsBuilder {
//   @override
//   Widget buildTransitions<T>(
//     PageRoute<T> route,
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     if (route.settings.arguments) {
//       return child;
//     }

//     return ScaleTransition(
//       scale: Tween<double>(
//         begin: 0.0,
//         end: 1.0,
//       ).animate(
//         CurvedAnimation(
//           parent: animation,
//           curve: Curves.fastOutSlowIn,
//         ),
//       ),
//       child: child,
//     );
//   }
// }





class CustomRoute extends PageRouteBuilder {
  final Widget page;

  CustomRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAniamtion,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
