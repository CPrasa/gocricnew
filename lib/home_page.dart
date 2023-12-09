import 'package:flutter/material.dart';
import 'package:gocric/card.dart';
import 'package:gocric/src/features/authentication/controllers/authentication_repository.dart';
import 'favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoCric',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  String selectedFilter = 'Live';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final List<String> filters = ['Live', 'Yesterday', 'Today', 'Tomorrow'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        titleSpacing: 0.0,
        title: Row(
          children: [
            _buildDatePickerIcon(context),
            const SizedBox(width: 8),
            const Text(
              'GoCric',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 30,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.yellow,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            },
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Add your logout logic here
              // For example, you can show a dialog or navigate to the login page
              // ****
              // *
              // *
              // *
              // *
              // *
              // *
              // *
              // **
              // *
              // *
              // *
              // ***
              // *
              AuthenticationRepository.instance.logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 4,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildBody(filters),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            'assets/images/ground.jpg',
            width: 378,
            height: 178,
          ),
        ),
        Expanded(
          child: _buildDatePickerTextField(context),
        ),
      ],
    );
  }

  Widget _buildDatePickerTextField(BuildContext context) {
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
        child: const Row(),
      ),
    );
  }

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
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.calendar_month_outlined,
          size: 30,
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
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                  if (filter == 'Live') {
                    selectedDate = DateTime.now();
                  } else if (filter == 'Yesterday') {
                    selectedDate = DateTime.now().subtract(const Duration(days: 1));
                  } else if (filter == 'Today') {
                    selectedDate = DateTime.now();
                  } else if (filter == 'Tomorrow') {
                    selectedDate = DateTime.now().add(const Duration(days: 1));
                  }
                });
              },
              child: Chip(
                backgroundColor:
                    selectedFilter.toLowerCase() == filter.toLowerCase()
                        ? Colors.yellow
                        : const Color.fromARGB(255, 240, 89, 13),
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
        },
      ),
    );
  }

  Widget _buildSelectedDateText() {
    String dateText = '';

    if (selectedFilter == 'Live') {
      dateText = 'Today, ${selectedDate.toLocal()}';
    } else if (selectedFilter == 'Yesterday') {
      dateText = '${selectedDate.toLocal().subtract(const Duration(days: 1))}';
    } else if (selectedFilter == 'Today') {
      dateText = '${selectedDate.toLocal()}';
    } else if (selectedFilter == 'Tomorrow') {
      dateText = '${selectedDate.toLocal().add(const Duration(days: 1))}';
    } else {
      dateText = '${selectedDate.toLocal()}';
    }

    return const Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ProductCard(
              team1Name: 'Sri Lanka',
              team2Name: 'Australia',
              team1Overs: '20',
              team1Score: '223/5',
              team2Overs: '11.5',
              team2Score: '110/6',
            ),
            ProductCard(
              team1Name: 'India',
              team2Name: 'Bandgladesh',
              team1Overs: '20',
              team1Score: '223/5',
              team2Overs: '11.5',
              team2Score: '110/6',
            ),
            ProductCard(
              team1Name: 'Pakisthan',
              team2Name: 'Australia',
              team1Overs: '20',
              team1Score: '223/5',
              team2Overs: '11.5',
              team2Score: '110/6',
            ),
            ProductCard(
              team1Name: 'New Zeland',
              team2Name: 'England',
              team1Overs: '20',
              team1Score: '223/5',
              team2Overs: '11.5',
              team2Score: '110/6',
            ),
            ProductCard(
              team1Name: 'South africa',
              team2Name: 'West Indis',
              team1Overs: '20',
              team1Score: '223/5',
              team2Overs: '11.5',
              team2Score: '110/6',
            ),
          ],
        ),
      ),
    );
  }
}
