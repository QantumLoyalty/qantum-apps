import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/flavors_config/flavor_config.dart';
import '../services/DeeplinkService.dart';
import '../view_models/HomeProvider.dart';

class AppBootstrap extends StatefulWidget {
  final Widget child;
  const AppBootstrap({super.key, required this.child});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  final DeeplinkService _deepLinkService = DeeplinkService();
  late Flavor flavor;

  @override
  void initState() {
    super.initState();

    flavor = FlavorConfig.instance.flavor!;

    _deepLinkService.init((link) {
      if (!mounted) return;

      if (flavor == Flavor.starReward || flavor == Flavor.bluewater) {
        final encodedLink = link.queryParameters['link'];
        if (encodedLink == null || encodedLink.isEmpty) return;

        print("AppBootstrap setDeepLinkParams: $encodedLink");
        context.read<HomeProvider>().setDeepLinkParams(encodedLink);
      } else if (flavor == Flavor.mhbc) {
        context.read<HomeProvider>().setDeepLinkParams(link.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}