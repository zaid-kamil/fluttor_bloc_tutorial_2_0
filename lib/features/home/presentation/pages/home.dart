import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/pages/list_images.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/pages/upload_image.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/pages/view_image.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/widgets/two_column_view.dart';
import 'package:flutter_bloc_tutorial/shared/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedNavigation = 0;

  void onDestinationSelected(int index) {
    setState(() {
      selectedNavigation = index;
    });
  }

  SlotLayoutConfig _buildPrimaryNavMedium() {
    return SlotLayout.from(
      key: const Key("Primary Navigation medium"),
      builder: (_) => AdaptiveScaffold.standardNavigationRail(
        selectedIndex: selectedNavigation,
        onDestinationSelected: onDestinationSelected,
        destinations: railDestinations,
        padding: EdgeInsets.all(0),
      ),
    );
  }

  SlotLayoutConfig _buildPrimaryNavSmall() {
    return SlotLayout.from(
      key: const Key("Bottom Navigation"),
      inAnimation: AdaptiveScaffold.bottomToTop,
      outAnimation: AdaptiveScaffold.topToBottom,
      builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
        destinations: destinations,
        currentIndex: selectedNavigation,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }

  SlotLayoutConfig _buildPrimaryNavLarge() {
    return SlotLayout.from(
      key: const Key("Primary Navigation large"),
      builder: (_) => AdaptiveScaffold.standardNavigationRail(
        selectedIndex: selectedNavigation,
        destinations: railDestinations,
        onDestinationSelected: onDestinationSelected,
        extended: true,
        padding: EdgeInsets.all(0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      transitionDuration: const Duration(milliseconds: 300),
      primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.mediumAndUp: _buildPrimaryNavMedium(),
        Breakpoints.largeAndUp: _buildPrimaryNavLarge(),
      }),
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key("Body small"),
          builder: (_) => selectPage(selectedNavigation),
        ),
        Breakpoints.mediumAndUp: SlotLayout.from(
          key: const Key("Body medium"),
          builder: (_) => TwoColumnView(
            selectedNavigation: selectedNavigation,
            left:
                selectedNavigation == 0 ? ListImagesPage() : UploadImagePage(),
            right: ViewImagePage(),
          ),
        ),
        Breakpoints.largeAndUp: SlotLayout.from(
          key: const Key("Body large"),
          builder: (_) => TwoColumnView(
            selectedNavigation: selectedNavigation,
            left:
                selectedNavigation == 0 ? ListImagesPage() : UploadImagePage(),
            right: ViewImagePage(),
          ),
        ),
      }),
      bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: _buildPrimaryNavSmall()
      }),
    );
  }

  Widget selectPage(int selectedNavigation) {
    if (selectedNavigation == 0) {
      return ListImagesPage();
    } else {
      return UploadImagePage();
    }
  }
}
