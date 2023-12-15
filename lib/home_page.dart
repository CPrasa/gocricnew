import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gocric/Widget/AppBarWidget.dart';
import 'package:gocric/Widget/NavBar.dart';
import 'package:gocric/card.dart';
import 'package:intl/intl.dart';
import 'api_service.dart';
import 'api_service_date.dart';

void main() {
  runApp(const MyApp());
}

String dateText = '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoCric',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic> apiData;
  late Map<String, dynamic> apiDataByDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataDate();
  }

  Future<void> fetchData() async {
    try {
      final data = await ApiService.fetchData();
      apiData = data;
      setState(() {
        apiData = data;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataDate() async {
    try {
      final datas = await ApiServicedate.fetchDataDate();
      apiDataByDate = datas!;
      setState(() {
        apiDataByDate = datas;
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  String selectedFilter = 'Live';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final List<String> filters = ['Live', 'Yesterday', 'Today', 'Tomorrow'];

    return Scaffold(
      drawer: NavBar(),
      appBar: const AppBarWidget(),
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        color: Colors.deepPurple.shade200,
        items: [
          Icon(Icons.home),
          Icon(Icons.newspaper_outlined),
          Icon(Icons.settings),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  /*
                  _buildHeader(),*/
                  Expanded(
                    child: _buildBody(filters),
                  ),
                ],
              ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(5),
  //         child: Image.asset(
  //           'assets/images/ground.jpg',
  //           width: 378,
  //           height: 178,
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDatePickerIcon(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
            selectedFilter = '';
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.calendar_month,
              color: Colors.deepPurple,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<String> filters) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        _buildFilterChips(filters),
        const SizedBox(height: 20),
        _buildSelectedDateText(),
      ],
    );
  }

  Widget _buildFilterChips(List<String> filters) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: filters.length + 1, // Add 1 for the calendar icon chip
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == filters.length) {
            // Calendar icon chip
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildDatePickerIcon(context),
            );
          } else {
            final filter = filters[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                    if (filter == 'Live') {
                      dateText = DateTime.now().toString();
                    } else if (filter == 'Yesterday') {
                      dateText = DateTime.now()
                          .subtract(const Duration(days: 1))
                          .toString();
                    } else if (filter == 'Today') {
                      dateText = DateTime.now().toString();
                    } else if (filter == 'Tomorrow') {
                      dateText = DateTime.now()
                          .add(const Duration(days: 1))
                          .toString();
                    }
                  });
                },
                child: Chip(
                  backgroundColor:
                      selectedFilter.toLowerCase() == filter.toLowerCase()
                          ? Colors.deepPurple.shade500
                          : Colors.deepPurple.shade200,
                  side: const BorderSide(
                    color: Color.fromRGBO(245, 247, 249, 1),
                  ),
                  label: Text(filter),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSelectedDateText() {
    if (selectedFilter == 'Live') {
      dateText = DateFormat('yyyyMMdd').format(selectedDate);
    } else if (selectedFilter == 'Yesterday') {
      dateText = DateFormat('yyyyMMdd')
          .format(selectedDate.toLocal().subtract(const Duration(days: 1)));
    } else if (selectedFilter == 'Today') {
      dateText = DateFormat('yyyyMMdd').format(selectedDate.toLocal());
    } else if (selectedFilter == 'Tomorrow') {
      dateText = DateFormat('yyyyMMdd')
          .format(selectedDate.toLocal().add(const Duration(days: 1)));
    } else {
      dateText = DateFormat('yyyyMMdd').format(selectedDate.toLocal());
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            if (selectedFilter == 'Live') ...[
              for (int i = 0; i < apiData['Stages'].length; i++)
                ProductCard(
                  team1Name: apiData['Stages'][i]['Events'][0]['T1'][0]['Nm'],
                  team2Name: apiData['Stages'][i]['Events'][0]['T2'][0]['Nm'],
                  team1Overs1:
                      apiData['Stages'][i]['Events'][0]['Tr1CO1'] != null
                          ? '(${apiData['Stages'][i]['Events'][0]['Tr1CO1']})'
                          : '',
                  team1Overs2:
                      apiData['Stages'][i]['Events'][0]['Tr1CO2'] != null
                          ? '(${apiData['Stages'][i]['Events'][0]['Tr1CO2']})'
                          : '',
                  team1Score1: apiData['Stages'][i]['Events'][0]['Tr1C1'] !=
                          null
                      ? '${apiData['Stages'][i]['Events'][0]['Tr1C1'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr1CW1'].toString()}'
                      : 'yet to bat',
                  team1Score2: apiData['Stages'][i]['Events'][0]['Tr1C2'] !=
                          null
                      ? '${apiData['Stages'][i]['Events'][0]['Tr1C2'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr1CW2'].toString()}'
                      : '',
                  team2Score1: apiData['Stages'][i]['Events'][0]['Tr2C1'] !=
                          null
                      ? '${apiData['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : 'yet to bat',
                  team2Score2: apiData['Stages'][i]['Events'][0]['Tr2C2'] !=
                          null
                      ? '${apiData['Stages'][i]['Events'][0]['Tr2C2'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr2CW2'].toString()}'
                      : '',
                  team2Overs1:
                      apiData['Stages'][i]['Events'][0]['Tr2CO1'] != null
                          ? '(${apiData['Stages'][i]['Events'][0]['Tr2CO1']})'
                          : '(0.0)',
                  team2Overs2: apiData['Stages'][i]['Events'][0]['Tr2C2'] !=
                          null
                      ? '${apiData['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : '',
                  status:
                      '${apiData['Stages'][i]['Events'][0]['EtTx']} (${apiData['Stages'][i]['Events'][0]['ErnInf']})\n${apiData['Stages'][i]['Events'][0]['EpsL']}',
                  commentary: apiData['Stages'][i]['Events'][0]['ECo'],
                ),
            ],
            if (selectedFilter == 'Today') ...[
              // Text(
              //   dateText,
              //   style: const TextStyle(fontSize: 18),
              // )

              for (int i = 0; i < apiDataByDate['Stages'].length; i++)
                ProductCard(
                  team1Name: apiDataByDate['Stages'][i]['Events'][0]['T1'][0]
                      ['Nm'],
                  team2Name: apiDataByDate['Stages'][i]['Events'][0]['T2'][0]
                      ['Nm'],
                  team1Overs1: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr1CO1'] !=
                          null
                      ? '(${apiDataByDate['Stages'][i]['Events'][0]['Tr1CO1']})'
                      : '',
                  team1Overs2: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr1CO2'] !=
                          null
                      ? '(${apiDataByDate['Stages'][i]['Events'][0]['Tr1CO2']})'
                      : '',
                  team1Score1: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr1C1'] !=
                          null
                      ? '${apiDataByDate['Stages'][i]['Events'][0]['Tr1C1'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr1CW1'].toString()}'
                      : 'yet to bat',
                  team1Score2: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr1C2'] !=
                          null
                      ? '${apiDataByDate['Stages'][i]['Events'][0]['Tr1C2'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr1CW2'].toString()}'
                      : '',
                  team2Score1: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr2C1'] !=
                          null
                      ? '${apiDataByDate['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : 'yet to bat',
                  team2Score2: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '${apiDataByDate['Stages'][i]['Events'][0]['Tr2C2'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr2CW2'].toString()}'
                      : '',
                  team2Overs1: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr2CO1'] !=
                          null
                      ? '(${apiDataByDate['Stages'][i]['Events'][0]['Tr2CO1']})'
                      : '(0.0)',
                  team2Overs2: apiDataByDate['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '${apiDataByDate['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : '',
                  status:
                      '${apiDataByDate['Stages'][i]['Events'][0]['EtTx']} (${apiDataByDate['Stages'][i]['Events'][0]['ErnInf']})\n${apiDataByDate['Stages'][i]['Events'][0]['EpsL']}',
                  commentary: apiDataByDate['Stages'][i]['Events'][0]['ECo'],
                ),
            ],
            if (selectedFilter == 'Tomorrow') ...[
              Text(
                dateText,
                style: const TextStyle(fontSize: 18),
              )
            ],
            if (selectedFilter == 'Yesterday') ...[
              Text(
                dateText,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ],
        ),
      ),
    );
  }
}
