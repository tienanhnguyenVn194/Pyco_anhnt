class Name {
  String title;
  String first;
  String last;

  Name(this.title, this.first, this.last);

  Name.fromMap(Map<String, dynamic> map)
      : this.title = map["title"],
        this.first = map["first"],
        this.last = map["last"];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["first"] = first;
    map["last"] = last;
    return map;
  }

  toJson() {
    return {"title": title, "first": first, "last": last};
  }

  toJsonString() {
    return '{"title": "${title}", "first": "${first}", "last": "${last}"}';
  }
}