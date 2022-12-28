import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/homescreen/widgets/all_image_gridview_container.dart';
import 'package:scotch/view/screens/homescreen/widgets/category_container.dart';
import 'package:scotch/view/screens/homescreen/widgets/newly_gridview_container.dart';
import 'package:scotch/view/screens/homescreen/widgets/home_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 45,
              child: CupertinoSearchTextField(
                prefixInsets: EdgeInsetsDirectional.fromSTEB(7, 3, 5, 2),
              ),
            ),
            kHeight10,
            Carousel(),
            kHeight10,
            const Text('Categories', style: textStyle),
            kHeight10,
            CategoryContainer(),
            kHeight10,
            const Text('Newly Launched', style: textStyle),
            kHeight10,
            NewlyGridviewContainer(),
            kHeight10,
            const Text('All items', style: textStyle),
            kHeight10,
            AllImageGridviewContainer(),
          ],
        ),
      ),
    );
  }
}
