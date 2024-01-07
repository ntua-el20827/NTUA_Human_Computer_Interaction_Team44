// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// // Model

// class QuizModel extends FlutterFlowModel {
//   ///  State fields for stateful widgets in this page.

//   final unfocusNode = FocusNode();

//   /// Initialization and disposal methods.

//   void initState(BuildContext context) {}

//   void dispose() {
//     unfocusNode.dispose();
//   }

//   /// Action blocks are added here.

//   /// Additional helper methods are added here.
// }

// //

// class QuizPage extends StatefulWidget {
//   const QuizPage({Key? key}) : super(key: key);

//   @override
//   _QuizPageWidgetState createState() => _QuizPageWidgetState();
// }

// class _QuizPageWidgetState extends State<QuizPage> {
//   late QuizModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => QuizModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isiOS) {
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//           statusBarBrightness: Theme.of(context).brightness,
//           systemStatusBarContrastEnforced: true,
//         ),
//       );
//     }

//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).info,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).info,
//           automaticallyImplyLeading: false,
//           title: Align(
//             alignment: AlignmentDirectional(0, 0),
//             child: Text(
//               'ArtVenture',
//               style: FlutterFlowTheme.of(context).titleLarge.override(
//                     fontFamily: 'MonteCarlo',
//                     fontSize: 30,
//                   ),
//             ),
//           ),
//           actions: [],
//           centerTitle: false,
//           elevation: 2,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Stack(
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0.7),
//                 child: FFButtonWidget(
//                   onPressed: () {
//                     print('Button pressed ...');
//                   },
//                   text: 'Register to Create Events',
//                   options: FFButtonOptions(
//                     width: 322,
//                     height: 59,
//                     padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//                     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                     color: FlutterFlowTheme.of(context).alternate,
//                     textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                           fontSize: 16,
//                         ),
//                     elevation: 3,
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional(0, 0.4),
//                 child: FFButtonWidget(
//                   onPressed: () {
//                     print('Button pressed ...');
//                   },
//                   text: 'Continue Without Registration',
//                   options: FFButtonOptions(
//                     width: 322,
//                     height: 59,
//                     padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//                     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                     color: FlutterFlowTheme.of(context).secondary,
//                     textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 16,
//                         ),
//                     elevation: 3,
//                     borderSide: BorderSide(
//                       color: Colors.transparent,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional(0, -0.2),
//                 child: Text(
//                   'Welcome to ArtVenture',
//                   textAlign: TextAlign.center,
//                   style: FlutterFlowTheme.of(context).bodyMedium.override(
//                         fontFamily: 'Poppins',
//                         fontSize: 40,
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
