import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/user_management/showUserRegistration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../../../core/provider/user_provider.dart';
import '../../shared/widgets/customTable.dart';
import '../../shared/widgets/paginatedButton.dart';

class UserManagement extends StatefulWidget {
  static const String route = '/Admin/UserManagement';
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final ScrollController controllerOne = ScrollController();
  final ScrollController controllerTwo = ScrollController();
  List<Map<String, dynamic>> filteredUser = [];
  List<Map<String, dynamic>> users = [];
  int currentPage = 1;
  int perPage = 10;
  int totalRecords = 0;
  int totalPages = 0;
  bool isLoading = true;
  bool isSearchMode = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.token;

    if (token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
        'https://dev-api-janus.fortress-asya.com:18043/api/private/v1/user-management/index?page=$currentPage&limit=$perPage');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        setState(() {
          filteredUser = List<Map<String, dynamic>>.from(data['data']);
          totalRecords = data['totalCount'];
          totalPages = data['totalPages'];
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
        filteredUser = [];
      }
    } catch (e) {
      print('An error occurred: $e');
      filteredUser = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshList() async{
    await fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B0C0C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                userRegistration(context, refreshList);
              },
              icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
              label: const Text(
                'Add User',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(color: const Color(0xFF4B0C0C), width: 0.1),
                ),
                child: isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B0C0C)),
                    strokeWidth: 4.0,
                  ),
                )
                    : filteredUser.isEmpty
                    ? Center(
                  child: Text(
                    'NO DATA AVAILABLE',
                    style: TextStyle(
                      fontFamily: 'RobotoThin',
                      color: Colors.black54.withOpacity(0.5),
                    ),
                  ),
                )
                    : CustomStyledDataTable(
                  columnHeaders: const [
                    'FULL NAME',
                    'USERNAME',
                    'ROLE',
                    'MOBILE',
                    'STATUS',
                    'ACTION'
                  ],
                  rowKeys: const [
                    'fullname',
                    'username',
                    'role',
                    'mobile',
                    'status',
                    'edit'
                  ],
                  data: filteredUser,
                  tableWidth: MediaQuery.of(context).size.width * 0.82,
                  columnSpacing: MediaQuery.of(context).size.width * 0.07,
                  horizontalController: controllerOne,
                  verticalController: controllerTwo,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black54, width: 0.1),
                  left: BorderSide(color: Colors.black54, width: 0.1),
                  right: BorderSide(color: Colors.black54, width: 0.1),
                ),
              ),
              padding: const EdgeInsets.all(5),
              child: PaginatedButtons(
                name: 'User',
                currentPage: currentPage,
                totalRecords: totalRecords,
                totalPages: totalPages,
                onPageChanged: (int newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                  fetchUsers(); // Fetch new data when the page changes
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}