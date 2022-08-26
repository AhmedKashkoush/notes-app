// import 'package:flutter/material.dart';

// class ColorSelectCircle extends StatefulWidget {
//   final Color color;
//   final int radius;
//   final void Function(Color) onColorSelect;
//   const ColorSelectCircle({ Key? key }) : super(key: key);

//   @override
//   State<ColorSelectCircle> createState() => _ColorSelectCircleState();
// }

// class _ColorSelectCircleState extends State<ColorSelectCircle> {

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedColor = AppColors.colors[index];
//                                   });
//                                 },
//                                 child: CircleAvatar(
//                                   radius:
//                                       _selectedColor == AppColors.colors[index]
//                                           ? widget.radius +5
//                                           : widget.radius,
//                                   backgroundColor:
//                                       AppColors.colors[index].withOpacity(0.4),
//                                   child: CircleAvatar(
//                                     radius: 13,
//                                     backgroundColor: AppColors.colors[index],
//                                     child: Center(
//                                       child: AnimatedScale(
//                                         scale: _selectedColor ==
//                                                 AppColors.colors[index]
//                                             ? 1
//                                             : 0,
//                                         duration: const Duration(
//                                           milliseconds: 300,
//                                         ),
//                                         curve: Curves.easeInOut,
//                                         child: Icon(
//                                           Ionicons.checkmark,
//                                           color: AppColors.blackColorList
//                                                   .contains(
//                                                       AppColors.colors[index])
//                                               ? Colors.black
//                                               : Colors.white,
//                                           size: 18,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//   }
// }