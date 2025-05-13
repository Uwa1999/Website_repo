// import 'package:flutter/material.dart';
//
// class FilterPopContainer extends StatefulWidget {
//   final String title;
//   final List<Widget> children;
//   final List<Widget>? rowChildren;
//   final List<Widget>? bottomRowChildren;
//   // final bool isMinimize;
//   // final Function(bool) onMinimizeToggle;
//   final Function() onClose;
//   final double popUpWidth;
//   final double? containerHeight;
//
//   const FilterPopContainer({
//     super.key,
//     required this.title,
//     required this.children,
//     this.rowChildren,
//     this.bottomRowChildren,
//     // required this.isMinimize,
//     // required this.onMinimizeToggle,
//     required this.onClose,
//     required this.popUpWidth,
//     this.containerHeight,
//   });
//
//   @override
//   State<FilterPopContainer> createState() => _FilterPopContainerState();
// }
//
// class _FilterPopContainerState extends State<FilterPopContainer> with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;
//   late final Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0), // Start offscreen to the right
//       end: Offset.zero, // End at the current position
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//
//     // Start the animation when the widget is initialized
//     _animationController.forward();
//   }
//
//   void _handleClose() async {
//     // Reverse the animation to slide out
//     await _animationController.reverse();
//     // Invoke the onClose callback after the animation completes
//     widget.onClose();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final double? filterHeight = widget.isMinimize ? 50 : widget.containerHeight;
//
//     return Align(
//       alignment: Alignment.topRight,
//       child: SlideTransition(
//         position: _slideAnimation,
//         child: AnimatedContainer(
//           margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
//           duration: const Duration(milliseconds: 300),
//           width: widget.popUpWidth,
//           height: widget.containerHeight,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(-2, -2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                     border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 10),
//                     Text(
//                       widget.title,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const Spacer(),
//                     // IconButton(
//                     //   padding: EdgeInsets.zero,
//                     //   visualDensity: const VisualDensity(horizontal: -2.0, vertical: -2.0),
//                     //   onPressed: () {
//                     //     setState(() {
//                     //       widget.onMinimizeToggle(!widget.isMinimize);
//                     //     });
//                     //   },
//                     //   icon: Icon(
//                     //     widget.isMinimize ? Icons.home_max : Icons.minimize,
//                     //     size: 15,
//                     //   ),
//                     // ),
//                     IconButton(
//                       padding: EdgeInsets.zero,
//                       visualDensity: const VisualDensity(horizontal: -2.0, vertical: -2.0),
//                       onPressed: _handleClose,
//                       icon: const Icon(
//                         Icons.close,
//                         size: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // if (!widget.isMinimize)
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     child: Wrap(
//                       runSpacing: 10,
//                       crossAxisAlignment: WrapCrossAlignment.start,
//                       children: [...widget.children],
//                     ),
//                   ),
//                 ),
//               ),
//               // Show rowChildren only if the container is at full height
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 // height: widget.isMinimize ? 0 : 70,
//                 height: 70,
//                 padding: const EdgeInsets.all(15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [...widget.rowChildren ?? []],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 height: 70,
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                     border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
//                 child: Row(
//                   children: [...widget.bottomRowChildren ?? []],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }