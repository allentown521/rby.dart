import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rby/rby.dart';
import 'package:flutter/cupertino.dart';

/// Determines the transition of the [RbyPage].
enum PageRouteType { platform, slide, fade, cupertino }

class RbyPage<T> extends Page<T> {
  const RbyPage({
    required this.builder,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.pageRouteType = PageRouteType.platform,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final WidgetBuilder builder;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  /// Determines which page route is used.
  final PageRouteType pageRouteType;

  @override
  Route<T> createRoute(BuildContext context) {
    final theme = Theme.of(context);

    switch (pageRouteType) {
      case PageRouteType.platform:
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
            continue slide;
          case TargetPlatform.iOS:
            continue cupertino;
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            continue fade;
        }
      slide:
      case PageRouteType.slide:
        return SlidePageRoute(
          settings: this,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        );
      cupertino:
      case PageRouteType.cupertino:
        return CupertinoPageRoute(
          settings: this,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        );
      fade:
      case PageRouteType.fade:
        return FadePageRoute(
          settings: this,
          duration: theme.animation.short,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        );
    }
  }
}
