import 'package:flutter/material.dart';

class UserContainer extends StatelessWidget {
  final String name;
  final String contact;
  final String role;
  final String username;
  final String status;

  const UserContainer({
    super.key,
    required this.name,
    required this.contact,
    required this.role,
    required this.username,
    required this.status,
  });

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'closed':
        return Colors.green[700]!;
      case 'active':
        return Colors.blue[700]!;
      case 'inactive':
        return Colors.grey[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[900]!,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              // Role
              Icon(Icons.supervised_user_circle, color: Colors.grey[600], size: 16),
              const SizedBox(width: 4),
              Text(
                role,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(width: 16),
              // Contact
              Icon(Icons.call, color: Colors.grey[600], size: 16),
              const SizedBox(width: 4),
              Text(
                contact,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Spacer(),
              // Status Button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}