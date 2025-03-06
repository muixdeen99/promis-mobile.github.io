import 'dart:convert';

TempahanGelanggang tempahanGelanggangFromJson(String str) => TempahanGelanggang.fromJson(json.decode(str));

String tempahanGelanggangToJson(TempahanGelanggang data) => json.encode(data.toJson());

class TempahanGelanggang {
    final List<dynamic> data;
    final int pageNo;
    final int totalItems;
    final int totalPages;

    TempahanGelanggang({
        required this.data,
        required this.pageNo,
        required this.totalItems,
        required this.totalPages,
    });

    // Named constructor for JSON deserialization
    TempahanGelanggang.fromJson(Map<String, dynamic> json)
        : data = List<dynamic>.from(json["data"].map((x) => x)),
          pageNo = json["pageNo"],
          totalItems = json["totalItems"],
          totalPages = json["totalPages"];

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "pageNo": pageNo,
        "totalItems": totalItems,
        "totalPages": totalPages,
    };
}
