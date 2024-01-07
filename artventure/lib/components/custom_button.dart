// // components/custom_button.dart

// import 'package:flutter/material.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final Color color;
//   final VoidCallback onPressed;

//   const CustomButton({
//     Key? key,
//     required this.text,
//     required this.color,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FFButtonWidget(
//       onPressed: onPressed,
//       text: text,
//       options: FFButtonOptions(
//         width: 322,
//         height: 59,
//         padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//         iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//         color: color,
//         textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//               fontFamily: 'Poppins',
//               color: Colors.white,
//               fontSize: 16,
//             ),
//         elevation: 3,
//         borderSide: BorderSide(
//           color: Colors.transparent,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
//       ),
//     );
//   }
// }
