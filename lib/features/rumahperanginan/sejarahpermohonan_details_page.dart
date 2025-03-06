import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/infoCard.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';

class SejarahpermohonanDetailsPage extends StatefulWidget {
  const SejarahpermohonanDetailsPage({super.key});

  @override
  State<SejarahpermohonanDetailsPage> createState() =>
      _SejarahpermohonanDetailsPageState();
}

class _SejarahpermohonanDetailsPageState
    extends State<SejarahpermohonanDetailsPage> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          userName: "userName",
          pageName1: "Sejarah Permohonan",
          pageName2: "pageName2"),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0), // Adjust padding as needed,
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text('Maklumat Permohonan'),
                      subtitle: Text('Butiran permohonan'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Adds spacing
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table( // Adds border to the table
                                columnWidths: {
                                  0: FlexColumnWidth(2), // Adjust column sizes
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(2),
                                },
                                children: [
                                  // Table Rows (Example Data)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('No. Tempahan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('12/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Rumah Peranginan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Jenis Unit'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Tarikh Masuk'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Tarikh Keluar'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Bil. Malam Menginap'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Amaun (RM)'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Status Tempahan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Status Bayaran'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Maklumat Pemohon'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Adds spacing
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table( // Adds border to the table
                                columnWidths: {
                                  0: FlexColumnWidth(2), // Adjust column sizes
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(2),
                                },
                                children: [
                                  // Table Rows (Example Data)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Nama'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('12/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('No. Pengenalan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('No. Telefon'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Email'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Gred Penjawatan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Maklumat Pasangan'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Adds spacing
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table( // Adds border to the table
                                columnWidths: {
                                  0: FlexColumnWidth(2), // Adjust column sizes
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(2),
                                },
                                children: [
                                  // Table Rows (Example Data)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('Nama'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('12/02/2024'),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('No. Kad Pengenalan'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('15/02/2024'),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
