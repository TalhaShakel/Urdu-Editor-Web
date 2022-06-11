import 'dart:io' as io;

import 'package:asaan_urdu/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fontsize = TextEditingController();
  SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;

  String _lastWords = '';
  // SpeechRecognition? _speechRecognition;
  // bool _isAvailable = false;
  // bool _isListening = false;

  String resultText = "";

  var footer = TextEditingController();

  var header = TextEditingController();

  bool showheader = false;

  var bold = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        listenFor: Duration(minutes: 1),
        // onSoundLevelChange: null,
        localeId: 'ur-PK',
        onResult: _onSpeechResult);
    // _lastWords = urdutext.text;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    urdutext.text = urdutext.text + _lastWords;
    controller.setText(urdutext.text);
    var kaddu = urdutext.text;

    setState(() {});
  }

  var urdutext3 = TextEditingController();
  String text = "Hello";

  Future<void> _createPDF() async {
    text = "${urdutext2.text}";
    print(urdutext2.text);
    try {
      PdfDocument document = PdfDocument();
      PdfPage page = document.pages.add();
      page.graphics.drawString(
          '${urdutext2.text}', PdfStandardFont(PdfFontFamily.helvetica, 20),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: Rect.fromLTWH(
              0, 0, page.getClientSize().width, page.getClientSize().height),
          format: PdfStringFormat(
              textDirection: PdfTextDirection.rightToLeft,
              alignment: PdfTextAlignment.right,
              paragraphIndent: 35));
      List<int> bytes = document.save();
      document.dispose();

      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", "output.pdf")
        ..click();
      print("Theek ho giya $text");
    } catch (e) {
      print("object" + e.toString());
    }
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  var urdutext = TextEditingController();
  var urdutext2 = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    urdutext2.text = _lastWords;
  }

  var siz = 12.1;

  @override
  Widget build(BuildContext context) {
    // _lastWords =
    //     "کی دنیا بھر کی آنکھیں تو ابھی تک جواب نہیں ملی اور جو ڈاکٹر ہے وہ منتھلی 35000 کیا تمہارا میں ان سب میں سے تھوڑا اور میں منتقلی سے رابطہ کیا تم ہارو میرے پاس ایک اللہ پاک کا شکر ہے کہ میں نے اتنی سی عمر میں اتنا کمالیہ";
    // var urdutext = TextEditingController(text: _lastWords.toString());
    // _lastWords = urdutext.text;
    // var kamina = _lastWords;
    // urdutext.text = kamina;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: ,
      //You should use `Scaffold` if you have `TextField` in body.
      //Otherwise on focus your `TextField` won`t scroll when keyboard popup.
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 19, 36, 133), Colors.blueAccent]),
          ),
          child: Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.9,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: button(
                                  height: 40,
                                  onPressed: () {
                                    footer.clear();
                                    header.clear();
                                    urdutext.clear();
                                  },
                                  text: "Create new project",
                                  width: 150),
                            ),
                            button(
                                onPressed: () {
                                  _createPDF();
                                },
                                text: "Download",
                                height: 40,
                                width: 150),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: button(
                                  onPressed: _speechToText.isNotListening
                                      ? _startListening
                                      : _stopListening,
                                  text: "listen",
                                  height: 40,
                                  width: 150),
                            ),
                            button(
                                onPressed: () {
                                  bold == false ? bold = true : bold = false;
                                  try {
                                    print(controller);
                                  } catch (e) {
                                    print(e.toString() + "bhaag ja");
                                    // print(controller);
                                  }
                                  setState(() {});
                                },
                                text: "Bold",
                                height: 40,
                                width: 150),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 150,
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]+')),
                                ],
                                controller: fontsize,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hoverColor: Colors.white,
                                    hintText: "Enter font size",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: button(
                                  onPressed: () {
                                    var c = double.parse(fontsize.text);
                                    siz = c;
                                    print(siz);
                                    setState(() {});
                                  },
                                  height: 40,
                                  width: 150,
                                  text: "Font Size"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // docs page
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        //Body Container
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    maxLines: null,
                                    textInputAction: TextInputAction.next,
                                    controller: urdutext2,
                                    // If listening is active show the recognized words
                                    // "$_lastWords",

                                    style: TextStyle(fontSize: 25),
                                  ),
                                  // Container(
                                  //   color: Colors.white,
                                  //   // height: 200.0,
                                  //   alignment: Alignment.center,
                                  //   child: Directionality(
                                  //     textDirection: TextDirection.rtl,
                                  //     child: TextFormField(
                                  //       textAlign: TextAlign.right,
                                  //       maxLines: null,
                                  //       textInputAction: TextInputAction.next,
                                  //       controller: urdutext,
                                  //       // If listening is active show the recognized words
                                  //       // "$_lastWords",

                                  //       style: TextStyle(
                                  //           fontWeight: bold
                                  //               ? FontWeight.bold
                                  //               : FontWeight.normal,
                                  //           fontSize: siz.toDouble()),
                                  //     ),
                                  //   ),
                                  // ),
                                  HtmlEditor(
                                    controller: controller,
                                    htmlEditorOptions: HtmlEditorOptions(
                                      hint: 'Your text here...',
                                      shouldEnsureVisible: true,
                                      //initialText: "<p>text content initial, if any</p>",
                                    ),
                                    otherOptions: OtherOptions(
                                      height: 400,
                                    ),
                                  ),
                                  // Text("$_lastWords")

                                  //TextField nearly at bottom
                                ],
                              ),
                            ),
                          ),
                        ),

                        //Footer Container
                        //Here you will get unexpected behaviour when keyboard pops-up.
                        //So its better to use `bottomNavigationBar` to avoid this.
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:
      //       // If not yet listening for speech start, otherwise stop
      //       _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
    );
  }
}
