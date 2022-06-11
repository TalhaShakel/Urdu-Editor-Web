// import 'dart:convert';
// import 'dart:io' as io;
// // import 'dart:io';
// // import 'dart:html';
// // import 'dart:io' as io;

// import 'package:flutter/material.dart';

// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
// // import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class shared extends StatefulWidget {
//   /// Default Constructor
//   const shared({Key? key}) : super(key: key);

//   @override
//   State<shared> createState() => _MyAppState();
// }

// TextEditingController kaddu = TextEditingController();
// // Future<void> _createPDF() async {
// //   // text = "${urdutext2.text}";
// //   // print(urdutext2.text);
// //   try {
// //     PdfDocument document = PdfDocument();
// //     PdfPage page = document.pages.add();
// //     page.graphics.drawString('hello world',
// //         PdfTrueTypeFont(io.File('assets/arial.ttf').readAsBytesSync(), 14),
// //         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
// //         bounds: Rect.fromLTWH(
// //             0, 0, page.getClientSize().width, page.getClientSize().height),
// //         format: PdfStringFormat(
// //             textDirection: PdfTextDirection.rightToLeft,
// //             alignment: PdfTextAlignment.right,
// //             paragraphIndent: 35));
// //     List<int> bytes = document.save();
// //     document.dispose();

// //     AnchorElement(
// //         href:
// //             "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
// //       ..setAttribute("download", "output.pdf")
// //       ..click();
// //     print("Theek ho giya ");
// //   } catch (e) {
// //     print("object" + e.toString());
// //   }
// // }

// Future<void> pdf() async {
//   try {
//     PdfDocument document = PdfDocument();

// //Draw text

//     // document.pages.add().graphics.drawString(
//     //     'Hello World!!!', PdfStandardFont(PdfFontFamily.helvetica, 16),
//     //     brush: PdfBrushes.black, bounds: Rect.fromLTWH(10, 10, 300, 50));
//     //  PdfDocument document = PdfDocument();

//     PdfPage page = document.pages.add();
//     page.graphics.drawString('World',
//         PdfTrueTypeFont(io.File('assets/arial.ttf').readAsBytesSync(), 14.0),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)));

// //Saves the document
//     io.File('Output.pdf').writeAsBytes(document.save());

// //Disposes the document
//     List<int> bytes = document.save();

//     document.dispose();
//     html.AnchorElement(
//         href:
//             "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
//       ..setAttribute("download", "output.pdf")
//       ..click();
//     var text = "poka";
//     print("Theek ho giya $text");
//   } catch (e) {
//     print(e);
//   }
// }

// class _MyAppState extends State<shared> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             TextFormField(
//               controller: kaddu,
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   print(kaddu.text);
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   await prefs.setString('action', kaddu.text.toString());
//                 },
//                 child: Text("data")),
//             ElevatedButton(
//                 onPressed: () async {
//                   pdf();
//                   // _createPDF();
//                 },
//                 child: Text("download")),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;

class PDFSave extends StatefulWidget {

  @override
  _PDFSaveState createState() => _PDFSaveState();
}

class _PDFSaveState extends State<PDFSave> {

  final pdf = pw.Document();
  var anchor;

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';
    html.document.body?.children.add(anchor);
  }


  createPDF() async {
    
    try {
        // var fontData = File('arial.ttf').readAsBytesSync();
//  var ttf = pw.Font.ttf(fontData.buffer.asByteData());

final  font = await rootBundle.load("assets/arial.ttf");
final  ttf = pw.Font.ttf(font);
final pdf = pw.Document();
pw.Text(
  'Your text',
  textDirection:pw.TextDirection.rtl, // If you need in opp direction like urdu
  style: pw.TextStyle(
  // font: ttf,
  ));

  // pdf.addPage(
  //   pw.Page(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (pw.Context context) => pw.Column(
  //       children: [
  //         pw.Text("hello ",  style: pw.TextStyle(fontSize: 40,font: ttf  )),
  //       ],
  //     ),
  //   ),
  // );
  savePDF();
    } catch (e) {
      print(e);
      print('آپ کيسے ہيں');
    }

}
var tex = "ہيں",style;
// : TextStyle(fontFamily:"assets\Jameel Noori Nastaleeq" ),);
@override
  void initState() {
    super.initState();
    createPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
        appBar: AppBar(
      title: Text('PDF Creator'),
    ),
    body: Center(
      child:RaisedButton(
        child: Text('Press'),
        onPressed: () {
          anchor.click();
          Navigator.pop(context);
        },
      )
    ));
  }
}