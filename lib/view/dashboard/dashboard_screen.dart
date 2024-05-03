import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/view/home/home_screen.dart';
import 'package:movie_app/view/search/search_screen.dart';

class DashbordScreen extends StatelessWidget {
  DashbordScreen({super.key});
  final controller = Get.put(DashbordController());
  final List<Widget> screens = [
    HomeScreen(),
    const SearchScreen(),
    const Text('Favorite'),
    const Text('profiel')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: screens.elementAt(controller.selectedIndex.value),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        // Set background color to black
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavigationItem('Home', Icons.home, 0),
            buildNavigationItem('Search', Icons.search, 1),
            buildNavigationItem('Favorite', Icons.favorite, 2),
            buildNavigationItem('Profile', Icons.person, 3),
            // buildNavigationItem(Icons.settings, 4),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationItem(String title, IconData icon, int index) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () => controller.onItemTapped(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: controller.selectedIndex.value == index
                    ? Colors.white
                    : Colors.grey,
              ),
              Text(
                controller.selectedIndex.value == index ? title : '',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DashbordController extends GetxController {
  final RxInt selectedIndex = RxInt(0);

  void onItemTapped(int index) {
    selectedIndex.value = index;
    // Implement your navigation logic here (e.g., route navigation)
  }
}
