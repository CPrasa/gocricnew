import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gocric/Widget/appBarWidget.dart';
import 'package:gocric/Widget/navbar.dart';
import 'package:gocric/card.dart';
import 'package:gocric/news_page.dart';
import 'package:intl/intl.dart';
import 'API Services/api_service.dart';
import 'API Services/api_service_date.dart';
import 'API Services/api_service_yesterday.dart';
import 'API Services/api_service_tomorrow.dart';

void main() {
  runApp(const MyApp());
}

String dateText = '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
  late Map<String, dynamic> apiDataYesterday;
  late Map<String, dynamic> apiDataTomorrow;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataDate();
    fetchDataYesterday();
    fetchDataTomorrow();
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

  Future<void> fetchDataYesterday() async {
    try {
      final data1 = await ApiServiceYesterday.fetchDataYesterday();
      apiDataYesterday = data1!;
      setState(() {
        apiDataYesterday = data1;
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataTomorrow() async {
    try {
      final data2 = await ApiServiceTomorrow.fetchDataTomorrow();
      apiDataTomorrow = data2!;
      setState(() {
        apiDataTomorrow = data2;
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

  int index = 0;

  @override
  Widget build(BuildContext context) {
    // final List<String> filters = ['Live', 'Yesterday', 'Today', 'Tomorrow'];

    return Scaffold(
      drawer: NavBar(),
      appBar: const AppBarWidget(),
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        color: Colors.deepPurple.shade200,
        items: const [
          Icon(
            Icons.home,
            color: Colors.deepPurple,
          ),
          Icon(
            Icons.newspaper_outlined,
            color: Colors.deepPurple,
          ),
        ],
        index: index,
        onTap: (selectedindex) {
          setState(() {
            index = selectedindex;
          });
        },
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
                    child: getselectedwidget(index: index),

                    // _buildBody(filters),
                  ),
                ],
              ),
      ),
    );
  }

  Widget getselectedwidget({required int index}) {
    final List<String> filters = ['Live', 'Yesterday', 'Today', 'Tomorrow'];
    Widget widget;
    switch (index) {
      case 0:
        widget = _buildBody(filters);
        break;
      case 1:
        widget = const NewsPage();
        break;
      default:
        widget = _buildBody(filters);
        break;
    }
    return widget;
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
              color: Color.fromARGB(255, 255, 255, 255),
              size: 40,
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
                      ? '(${apiData['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiData['Stages'][i]['Events'][0]['Tr2CW1'].toString()})'
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
                      ? '(${apiDataByDate['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataByDate['Stages'][i]['Events'][0]['Tr2CW1'].toString()})'
                      : '',
                  status:
                      '${apiDataByDate['Stages'][i]['Events'][0]['EtTx']} (${apiDataByDate['Stages'][i]['Events'][0]['ErnInf']})\n${apiDataByDate['Stages'][i]['Events'][0]['EpsL']}',
                  commentary: apiDataByDate['Stages'][i]['Events'][0]['ECo'],
                ),
            ],
            if (selectedFilter == 'Tomorrow') ...[
              // Text(
              //   dateText,
              //   style: const TextStyle(fontSize: 18),
              // ),
              for (int i = 0; i < apiDataTomorrow['Stages'].length; i++)
                ProductCard(
                  team1Name: apiDataTomorrow['Stages'][i]['Events'][0]['T1'][0]
                      ['Nm'],
                  team2Name: apiDataTomorrow['Stages'][i]['Events'][0]['T2'][0]
                      ['Nm'],
                  team1Overs1: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr1CO1'] !=
                          null
                      ? '(${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1CO1']})'
                      : '',
                  team1Overs2: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr1CO2'] !=
                          null
                      ? '(${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1CO2']})'
                      : '',
                  team1Score1: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr1C1'] !=
                          null
                      ? '${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1C1'].toString()}/${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1CW1'].toString()}'
                      : 'yet to bat',
                  team1Score2: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr1C2'] !=
                          null
                      ? '${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1C2'].toString()}/${apiDataTomorrow['Stages'][i]['Events'][0]['Tr1CW2'].toString()}'
                      : '',
                  team2Score1: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr2C1'] !=
                          null
                      ? '${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : 'yet to bat',
                  team2Score2: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2C2'].toString()}/${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2CW2'].toString()}'
                      : '',
                  team2Overs1: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr2CO1'] !=
                          null
                      ? '(${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2CO1']})'
                      : '(0.0)',
                  team2Overs2: apiDataTomorrow['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '(${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataTomorrow['Stages'][i]['Events'][0]['Tr2CW1'].toString()})'
                      : '',
                  status:
                      '${apiDataTomorrow['Stages'][i]['Events'][0]['EtTx']} (${apiDataTomorrow['Stages'][i]['Events'][0]['ErnInf']})\n${apiDataTomorrow['Stages'][i]['Events'][0]['EpsL']}',
                  commentary: apiDataTomorrow['Stages'][i]['Events'][0]['ECo'],
                ),
            ],
            if (selectedFilter == 'Yesterday') ...[
              // Text(
              //   dateText,
              //   style: const TextStyle(fontSize: 18),
              // ),
              for (int i = 0; i < apiDataYesterday['Stages'].length; i++)
                ProductCard(
                  team1Name: apiDataYesterday['Stages'][i]['Events'][0]['T1'][0]
                      ['Nm'],
                  team2Name: apiDataYesterday['Stages'][i]['Events'][0]['T2'][0]
                      ['Nm'],
                  team1Overs1: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr1CO1'] !=
                          null
                      ? '(${apiDataYesterday['Stages'][i]['Events'][0]['Tr1CO1']})'
                      : '',
                  team1Overs2: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr1CO2'] !=
                          null
                      ? '(${apiDataYesterday['Stages'][i]['Events'][0]['Tr1CO2']})'
                      : '',
                  team1Score1: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr1C1'] !=
                          null
                      ? '${apiDataYesterday['Stages'][i]['Events'][0]['Tr1C1'].toString()}/${apiDataYesterday['Stages'][i]['Events'][0]['Tr1CW1'].toString()}'
                      : 'yet to bat',
                  team1Score2: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr1C2'] !=
                          null
                      ? '${apiDataYesterday['Stages'][i]['Events'][0]['Tr1C2'].toString()}/${apiDataYesterday['Stages'][i]['Events'][0]['Tr1CW2'].toString()}'
                      : '',
                  team2Score1: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr2C1'] !=
                          null
                      ? '${apiDataYesterday['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataYesterday['Stages'][i]['Events'][0]['Tr2CW1'].toString()}'
                      : 'yet to bat',
                  team2Score2: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '${apiDataYesterday['Stages'][i]['Events'][0]['Tr2C2'].toString()}/${apiDataYesterday['Stages'][i]['Events'][0]['Tr2CW2'].toString()}'
                      : '',
                  team2Overs1: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr2CO1'] !=
                          null
                      ? '(${apiDataYesterday['Stages'][i]['Events'][0]['Tr2CO1']})'
                      : '(0.0)',
                  team2Overs2: apiDataYesterday['Stages'][i]['Events'][0]
                              ['Tr2C2'] !=
                          null
                      ? '(${apiDataYesterday['Stages'][i]['Events'][0]['Tr2C1'].toString()}/${apiDataYesterday['Stages'][i]['Events'][0]['Tr2CW1'].toString()})'
                      : '',
                  status:
                      '${apiDataYesterday['Stages'][i]['Events'][0]['EtTx']} (${apiDataYesterday['Stages'][i]['Events'][0]['ErnInf']})\n${apiDataYesterday['Stages'][i]['Events'][0]['EpsL']}',
                  commentary: apiDataYesterday['Stages'][i]['Events'][0]['ECo'],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
