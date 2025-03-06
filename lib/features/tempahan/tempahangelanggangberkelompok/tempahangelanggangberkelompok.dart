import 'dart:convert';

TempahanGelanggangBerkelompok tempahanGelanggangBerkelompokFromJson(String str) => TempahanGelanggangBerkelompok.fromJson(json.decode(str));

String tempahanGelanggangBerkelompokToJson(TempahanGelanggangBerkelompok data) => json.encode(data.toJson());

class TempahanGelanggangBerkelompok {
    final List<dynamic> data;
    final int pageNo;
    final int totalItems;
    final int totalPages;

    TempahanGelanggangBerkelompok({
        required this.data,
        required this.pageNo,
        required this.totalItems,
        required this.totalPages,
    });

    // Named constructor for JSON deserialization
    TempahanGelanggangBerkelompok.fromJson(Map<String, dynamic> json)
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
