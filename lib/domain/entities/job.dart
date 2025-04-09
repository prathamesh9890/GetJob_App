class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final bool isRemote;
  final bool isSaved;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.isRemote,
    required this.isSaved,
  });
}
