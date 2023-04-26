import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/apiServices/qn_paper_services.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/models/qn_paper_model.dart';

class QnPaperSearchScreen extends StatefulWidget {
  const QnPaperSearchScreen({Key? key}) : super(key: key);

  @override
  State<QnPaperSearchScreen> createState() => _QnPaperSearchScreenState();
}

class _QnPaperSearchScreenState extends State<QnPaperSearchScreen> {
  late TextEditingController _searchController;
  late Future<List<QnPaperModel>?> _searchFuture;
  late String _searchFilter;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFuture = Future(() => []);
    _searchFilter = 'name';

    super.initState();
  }

  void _submitSearch() async {
    final text = _searchController.text;
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? collage = pref.getString('collage');
    setState(() {
      _searchFuture = _fetchData(text, collage!);
    });
  }

  Future<List<QnPaperModel>?> _fetchData(String text, String collage) async {
    try {
      if (_searchFilter == "semester") {
        List<QnPaperModel>? response =
            await QnPaperAPIServices.getQuestionPaperBySemester(text, collage);

        if (response == null) {
          throw Exception('No question paper found');
        }
        return response;
      } else if (_searchFilter == "name") {
        List<QnPaperModel>? response =
            await QnPaperAPIServices.getQuestionPaperByName(text, collage);

        if (response == null) {
          throw Exception('No question paper found');
        }
        return response;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201F15),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFFFC700),
                ),
              ),
              child: Row(
                children: [
                  buildDropdown(),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search Question paper',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      cursorColor: const Color(0xFFFFC700),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          LoginButton(
            text: 'Search',
            onPressed: () {
              _submitSearch();
            },
          ),
          Expanded(
            child: searchResult(),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<QnPaperModel>?> searchResult() {
    return FutureBuilder(
      future: _searchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFFC700),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final results = snapshot.data!;
          if (results.isEmpty) {
            return const Center(
              child: Text(
                'No results found. Search Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            );
          } else {
            return resultList(results);
          }
        }
        return const Center(
          child: Text(
            'Enter a search query to get started.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        );
      },
    );
  }

  ListView resultList(List<QnPaperModel> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white24,
            child: ListTile(
              title: Text(
                result.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              subtitle: Text(
                'Semester: ${result.semester}, Year: ${result.year} , Month: ${result.month}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  log("pressed ${result.link}");
                  final shareLink = result.link;
                  // Download the PDF file to the device's temporary directory
                  final match = RegExp(r'[-\w]{25,}').firstMatch(shareLink);
                  final fileId = match?.group(0);
                  log('fileID : $fileId');
                  final downloadUrl = 'https://drive.google.com/uc?export=download&id=$fileId';
                  final response = await http.get(Uri.parse(downloadUrl));
                  final bytes = response.bodyBytes;
                  final tempDir = await getTemporaryDirectory();
                  final file = File('${tempDir.path}/${result.name}.pdf');
                  await file.writeAsBytes(bytes);

                  // Display the PDF file using the PDFView widget
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PDFView(
                        filePath: file.path,
                        fitPolicy: FitPolicy.WIDTH,

                      ),
                    ),
                  );

                  // if (await canLaunchUrl(Uri.parse(result.link))) {
                  //   await launchUrl(Uri.parse(result.link));
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content:  Text('Can\'t Open Pdf !!!'),
                  //       backgroundColor: Colors.redAccent,
                  //     ),
                  //   );
                  // }
                },
                icon: const Icon(
                  FontAwesomeIcons.filePdf,
                  color: Color(0xFFFFC700),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Container buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFFFC700),
        ),
      ),
      child: DropdownButton<String>(
        underline: Container(
          color: Colors.transparent,
        ),
        icon: const Icon(
          FontAwesomeIcons.caretDown,
          color: Color(0xFFFFC700),
          size: 26,
        ),
        value: _searchFilter,
        items: const [
          DropdownMenuItem(
            value: 'name',
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'semester',
            child: Text(
              'Semester',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _searchFilter = value!;
          });
        },
      ),
    );
  }
}
