import 'package:flutter/material.dart';
import 'package:promis/components/custom_appbar.dart';
import 'package:promis/components/infoCard.dart';
import 'package:promis/features/tempahan/tempahangelanggang/custom_drawer.dart';
import 'package:promis/shared/color.dart';

class TerimaankelompokDetailsPage extends StatefulWidget {
  const TerimaankelompokDetailsPage({super.key});

  @override
  State<TerimaankelompokDetailsPage> createState() => _TerimaankelompokDetailsPageState();
}

class _TerimaankelompokDetailsPageState extends State<TerimaankelompokDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(userName: "userName", pageName1: "Terimaan Berkelompok", pageName2: "pageName2"),
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0), // Adjust padding as needed,
                child: Column(
                  children: [
                    TabBar(
                tabs: [
                  Tab(text: 'Maklumat Permohonan'),
                  Tab(text: 'Kronologi Permohonan'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // First tab content
                    SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  1, // Since it's a map, we only have one item
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Infocard(
                                                      data: [
                                                        {
                                                          'Nama Pemohon':
                                                              'namaPemohon'
                                                        },
                                                        {
                                                          'No. Kad Pengenalan':
                                                              'idPemohon'
                                                        },
                                                        // {'Negeri': 'namaPemohon'},
                                                        // {'Tarikh Permohonan': 'namaPemohon'},
                                                        // {'Jenis Perumahan': 'namaPemohon'},
                                                      ],
                                                    ),
                                                    Infocard(
                                                      data: [
                                                        {
                                                          'Nama Pemohon':
                                                              'namaPemohon'
                                                        },
                                                        {
                                                          'No. Kad Pengenalan':
                                                              'idPemohon'
                                                        },
                                                        // {'Negeri': 'namaPemohon'},
                                                        // {'Tarikh Permohonan': 'namaPemohon'},
                                                        // {'Jenis Perumahan': 'namaPemohon'},
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Second tab content
                    SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Maklumat Permohonan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Age',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Role',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: const <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('Sarah')),
                                      DataCell(Text('19')),
                                      DataCell(Text('Student')),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('Janine')),
                                      DataCell(Text('43')),
                                      DataCell(Text('Professor')),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('William')),
                                      DataCell(Text('27')),
                                      DataCell(Text('Associate Professor')),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                  ],
                ),
                ),
            )
          ],
        ),
      ),
    );
  }
}