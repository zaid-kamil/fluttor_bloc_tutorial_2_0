import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class ResponsiveLayout extends StatelessWidget {
  final int selectedNavigation;
  final SlotLayoutConfig primaryNavMedium;
  final SlotLayoutConfig primaryNavLarge;
  final SlotLayoutConfig primaryNavSmall;
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;
  final Function(int) onDestinationSelected;

  const ResponsiveLayout({
    required this.primaryNavMedium,
    required this.primaryNavLarge,
    required this.primaryNavSmall,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
    required this.onDestinationSelected,
    this.selectedNavigation = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      transitionDuration: const Duration(milliseconds: 300),
      primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.mediumAndUp: primaryNavMedium,
        Breakpoints.largeAndUp: primaryNavLarge,
      }),
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key("Body small"),
          builder: (_) => mobileLayout,
        ),
        Breakpoints.medium: SlotLayout.from(
          key: const Key("Body medium"),
          builder: (_) => tabletLayout,
        ),
        Breakpoints.largeAndUp: SlotLayout.from(
          key: const Key("Body large"),
          builder: (_) => desktopLayout,
        ),
      }),
      bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: primaryNavSmall
      }),
    );
  }
}
