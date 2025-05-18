import 'package:flutter/material.dart';

class TitleWithImageList extends StatelessWidget {
  final String title;
  final List<String> imagePaths; // List of local asset image paths

  const TitleWithImageList({
    Key? key,
    required this.title,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        const SizedBox(height: 10),
        // SizedBox(
        //   height: 100, // height for the image list
        //   child: ListView.separated(
        //     scrollDirection: Axis.vertical,
        //     itemCount: imagePaths.length,
        //     separatorBuilder: (_, __) => const SizedBox(width: 10),
        //     itemBuilder: (context, index) {
        //       return ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: Image.asset(
        //           imagePaths[index],
        //           width: 100,
        //           height: 100,
        //           fit: BoxFit.cover,
        //         ),
        //       );
        //     },
        //   ),
        // ),
        // SizedBox(
        //   height: 220, // Adjust as needed to fit the images
        //   child: GridView.builder(
        //     physics: const NeverScrollableScrollPhysics(), // disables scrolling
        //     shrinkWrap: true, // allows the GridView to size itself based on content
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3, // 3 items per row
        //       mainAxisSpacing: 10,
        //       crossAxisSpacing: 10,
        //       childAspectRatio: 1, // width and height are equal (square)
        //     ),
        //     itemCount: imagePaths.length,
        //     itemBuilder: (context, index) {
        //       return ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: Image.asset(
        //           imagePaths[index],
        //           fit: BoxFit.cover,
        //         ),
        //       );
        //     },
        //   ),
        // ),



      ],
    );
  }
}
