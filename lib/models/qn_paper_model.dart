class QnPaperModel {
  final String name;
  final int semester;
  final String month;
  final int year;
  final String link;
  final int scheme;

  QnPaperModel({
    required this.name,
    required this.semester,
    required this.month,
    required this.year,
    required this.link,
    required this.scheme,
  });
}

class QuestionPaperAddRequestModel{
  final String qnSubName;
  final String qnMonth;
  final int qnScheme;
  final int qnSemester;
  final int qnYear;
  final String qnLink;
  final String collage;

  QuestionPaperAddRequestModel({
    required this.qnSubName,
    required this.collage,
    required this.qnLink,
    required this.qnMonth,
    required this.qnScheme,
    required this.qnSemester,
    required this.qnYear
});
}
