import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  late Future<List<QnPaperModel>> _searchFuture;
  late String _searchFilter;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFuture = Future(() => []);
    _searchFilter = 'name';

    super.initState();
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
              QnPaperAPIServices.getQuestionPaperBySemester("0");
            },
          ),
        ],
      ),
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
