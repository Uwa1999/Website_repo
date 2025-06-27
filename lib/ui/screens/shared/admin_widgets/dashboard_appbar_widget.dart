import 'package:flutter/material.dart';

class DashboardAppBar extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final bool isEnabled;
  final String? userInitial;
  final String? username;
  final VoidCallback onChangePasswordPressed;
  final VoidCallback onLogout; // Add this new callback

  const DashboardAppBar({
    super.key,
    this.onSearchChanged,
    this.isEnabled = true,
    this.userInitial,
    this.username,
    required this.onChangePasswordPressed,
    required this.onLogout, // Make it required
  });

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasSearchInput = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _hasSearchInput = _searchController.text.isNotEmpty;
    });
    if (widget.onSearchChanged != null && widget.isEnabled) {
      widget.onSearchChanged!(_searchController.text);
    }
  }

  void _showUserMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    // Calculate position to show menu below the button
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(0, button.size.height), // Position below the button
          ancestor: overlay,
        ),
        button.localToGlobal(
          button.size.bottomRight(Offset(0, button.size.height)), // Extend to right
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        const PopupMenuItem(
          value: 'change_password',
          child: Row(
            children: [
              Icon(Icons.lock_outline, size: 20),
              SizedBox(width: 8),
              Text('Change Password'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout_rounded, size: 20),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'change_password') {
        widget.onChangePasswordPressed();
      } else if (value == 'logout') {
        widget.onLogout();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search field (unchanged)
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: AbsorbPointer(
                absorbing: !widget.isEnabled,
                child: Opacity(
                  opacity: widget.isEnabled ? 1.0 : 0.6,
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _searchController,
                      enabled: widget.isEnabled,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: widget.isEnabled ? null : Colors.grey[600],
                        ),
                        prefixIcon: Icon(Icons.search, size: 20,
                            color: widget.isEnabled ? null : Colors.grey[600]),
                        suffixIcon: _hasSearchInput && widget.isEnabled
                            ? IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: widget.isEnabled
                            ? Colors.grey[200]
                            : Colors.grey[100],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // User profile section
          GestureDetector(
            onTap: () => _showUserMenu(context),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/fdsap.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    if (widget.userInitial != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color(0xFF630606),
                          child: Text(
                            widget.userInitial!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Text(
                      widget.username ?? 'User',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}