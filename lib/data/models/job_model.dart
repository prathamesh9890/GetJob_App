class job_model {
  String? sId;
  String? title;
  String? company;
  String? location;
  String? description;
  bool? isRemote;
  bool? isSaved;

  job_model(
      {this.sId,
        this.title,
        this.company,
        this.location,
        this.description,
        this.isRemote,
        this.isSaved});

  job_model.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    company = json['company'];
    location = json['location'];
    description = json['description'];
    isRemote = json['isRemote'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['company'] = this.company;
    data['location'] = this.location;
    data['description'] = this.description;
    data['isRemote'] = this.isRemote;
    data['isSaved'] = this.isSaved;
    return data;
  }
}


