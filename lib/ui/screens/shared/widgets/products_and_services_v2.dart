// import 'package:flutter/material.dart';
//
//
// class ProductsAndServicesV2 extends StatelessWidget {
//   static const String route = '/ProductsAndServices';
//   const ProductsAndServicesV2({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
// CustomCardWidget(title: 'Techlonogy', description: 'asdfbgfnhgmjmhngbfvsdca',
//   buttonLabels: [], onButtonPressed: [
//     () => (){},
//         () => (){},
//         () => (){},
// ],)
//       ],
//     );
//   }
// }
//
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///old
// class CustomCardWidget extends StatelessWidget {
//   final String? title;
//   final String description;
//   final String imagePath;
//   final List<String>? buttonLabels;
//   final VoidCallback? onMainActionPressed;
//   final List<VoidCallback>? onButtonPressed;
//
//
//   const CustomCardWidget({
//     Key? key,
//     this.title,
//     required this.description,
//     required this.imagePath,
//      this.buttonLabels,
//     this.onMainActionPressed,
//     this.onButtonPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       margin: const EdgeInsets.all(10),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//       child: Container(
//         width: 100,
//         height: 450,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Placeholder image box
//             Container(
//               width: 600,
//               height: 400,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(50),
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(width: 40,),
//             // Title and Description
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       title!,
//                       style: const TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       // textAlign: TextAlign.left,
//                     ),
//         Container(
//           width: 10,
//         height: 5,
//         child: Text(title!),
//         )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//
//                 Wrap(
//                   children:[
//                     Container(
//                       width: 700,
//                       child: Text(
//                         description,
//                         style: const TextStyle(fontSize: 15),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                   ]
//                 ),
//
//                 const SizedBox(height: 20),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   alignment: WrapAlignment.center,
//                   children: List.generate(buttonLabels!.length, (index) {
//                     return ElevatedButton(
//                       onPressed: onButtonPressed != null && index < onButtonPressed!.length
//                           ? onButtonPressed![index]
//                           : () {},
//                       child: Text(buttonLabels![index]),
//                     );
//                   }),
//                 ),
//               ],
//
//             ),
//
//
//             const SizedBox(height: 20),
//
//             // Small Buttons
//           ],
//         ),
//       ),
//     );
//   }
// }
class CustomCardWidget extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed; // Optional click handler
  final List<VoidCallback>? onButtonPressed;

  const CustomCardWidget({
    Key? key,
    this.title,
    required this.description,
    required this.imagePath,
    this.buttonLabels,
    this.onMainActionPressed,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        width: 100,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image section
            Container(
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 40),
            // Title and Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  Row(
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 5,
                        child: Text(title!),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                Container(
                  width: 700,
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(buttonLabels?.length ?? 0, (index) {
                    return ElevatedButton(
                      onPressed: onButtonPressed != null && index < onButtonPressed!.length
                          ? onButtonPressed![index]
                          : () {},
                      child: Text(buttonLabels![index]),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    // If onMainActionPressed is provided, wrap in GestureDetector to make clickable
    return onMainActionPressed != null
        ? GestureDetector(
      onTap: onMainActionPressed,
      child: cardContent,
    )
        : cardContent;
  }
}

class CustomCardWidgetv2 extends StatelessWidget {
  final String? title;
  final String description;
  final String imagePath;
  final List<String>? buttonLabels;
  final VoidCallback? onMainActionPressed; // Optional click handler
  final List<VoidCallback>? onButtonPressed;

  const CustomCardWidgetv2({
    Key? key,
    this.title,
    required this.description,
    required this.imagePath,
    this.buttonLabels,
    this.onMainActionPressed,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        width: 700,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image section
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 40),
            // Title and Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  Row(
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 5,
                        child: Text(title!),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(buttonLabels?.length ?? 0, (index) {
                    return ElevatedButton(
                      onPressed: onButtonPressed != null && index < onButtonPressed!.length
                          ? onButtonPressed![index]
                          : () {},
                      child: Text(buttonLabels![index]),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    // If onMainActionPressed is provided, wrap in GestureDetector to make clickable
    return onMainActionPressed != null
        ? GestureDetector(
      onTap: onMainActionPressed,
      child: cardContent,
    )
        : cardContent;
  }
}
