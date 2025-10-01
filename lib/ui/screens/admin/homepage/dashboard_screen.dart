import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/models/article_model.dart';
import '../../../../core/models/paginated_model.dart';
import '../../../../core/models/products_and_services_model.dart';
import '../../../../services/api/article_api.dart';
import '../../shared/admin_widgets/buttons/insight_filter_button.dart';
import '../catalogs/update_products.dart';
import '../catalogs/update_services.dart';
import '../insights/update_insight.dart';

class DashboardScreen extends StatefulWidget {
  static const String route = '/Admin/Dashboard';
  final String searchQuery;

  const DashboardScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ArticleApiService _apiService = ArticleApiService();
  late Future<List<dynamic>> _futureData;
  List<bool> _selectedRows = [];
  bool _isLoading = true;
  String _currentFilter = 'All';
  String _currentView = 'Insights'; // Can be 'Insights', 'Products', 'Services'

  // Pagination variables
  int _currentPage = 1;
  final int _rowsPerPage = 10;
  int _totalPages = 1;
  List<dynamic> _currentPageData = [];
  int _totalItems = 0;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData(page: _currentPage);
  }

  String _stripHtmlTags(String htmlString) {
    // A simple regex to remove all HTML tags: <...>
    final RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: false,
    );
    return htmlString.replaceAll(exp, '');
  }


  List<dynamic> get _filteredData {
    List<dynamic> dataToFilter = _currentPageData;

    // First apply the category filter (for insights only)
    if (_currentView == 'Insights' && _currentFilter != 'All') {
      dataToFilter = dataToFilter.where((item) => item is Article).toList();
      dataToFilter = _applyFilter(dataToFilter, _currentFilter);
    }

    // Then apply search query if exists
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      dataToFilter = dataToFilter.where((item) {
        if (_currentView == 'Insights' && item is Article) {
          final plainContent = _stripHtmlTags(item.content).toLowerCase(); // <--- CHANGE 1
          final plainTitle = _stripHtmlTags(item.title).toLowerCase();      // <--- CHANGE 2

          return plainTitle.contains(query) ||
              plainContent.contains(query) ||
              item.category.toLowerCase().contains(query) ||
              item.remarks.toLowerCase().contains(query);
        } else if (_currentView == 'Products' && item is Catalog) {
          final plainDescription = _stripHtmlTags(item.description).toLowerCase(); // <--- CHANGE 3
          final plainName = _stripHtmlTags(item.name).toLowerCase(); // <--- CHANGE 4

          return plainName.contains(query) ||
              plainDescription.contains(query);
        } else if (_currentView == 'Services' && item is Service) {
          final plainDescription = _stripHtmlTags(item.description).toLowerCase(); // <--- CHANGE 5
          final plainName = _stripHtmlTags(item.name).toLowerCase(); // <--- CHANGE 6

          return plainName.contains(query) ||
              plainDescription.contains(query);
        }
        return false;
      }).toList();
    }
    return dataToFilter;
  }

  String _highlightHtmlContent(String htmlContent, String query) {
    if (query.isEmpty) {
      return htmlContent;
    }

    // Create a regex pattern for the search query
    final pattern = RegExp(query, caseSensitive: false);

    // Replace matches with highlighted spans
    return htmlContent.replaceAllMapped(pattern, (match) {
      return '<span style="background-color: yellow; color: red; font-weight: bold;">${match.group(0)}</span>';
    });
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() {});
    }
  }

  Future<List<dynamic>> _loadData({int page = 1}) async {
    try {
      setState(() => _isLoading = true);

      if (_currentView == 'Insights') {
        final response = await _apiService.fetchPaginatedArticles(page: page);
        setState(() {
          _currentPageData = response.items;
          _totalItems = response.totalCount;
          _totalPages = response.totalPages;
          _currentPage = response.currentPage;
        });
      } else if (_currentView == 'Products') {
        final response = await _apiService.fetchPaginatedCatalogs(page: page);
        setState(() {
          _currentPageData = response.items;
          _totalItems = response.totalCount;
          _totalPages = response.totalPages;
          _currentPage = response.currentPage;
        });
      } else if (_currentView == 'Services') {
        final response = await _apiService.fetchPaginatedServices(page: page);
        setState(() {
          _currentPageData = response.items;
          _totalItems = response.totalCount;
          _totalPages = response.totalPages;
          _currentPage = response.currentPage;
        });
      }

      setState(() {
        _selectedRows = List.filled(_currentPageData.length, false);
        _isLoading = false;
      });

      return _currentPageData;
    } catch (e) {
      setState(() => _isLoading = false);
      throw Exception('Failed to load $_currentView: $e');
    }
  }

  void _showTopSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF630606),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 550,
          right: 550,
        ),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _deleteInsights(List<int> ids) async {
    try {
      setState(() => _isLoading = true);
      final success = await _apiService.deleteInsights(ids);

      if (success) {
        _showTopSnackBar('Successfully deleted ${ids.length} item(s)');
        _refreshData();
      }
    } catch (e) {
      _showTopSnackBar('Error deleting items: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteCatalogs(List<int> ids) async {
    try {
      setState(() => _isLoading = true);
      final success = await _apiService.deleteCatalogs(ids);

      if (success) {
        _showTopSnackBar('Successfully deleted ${ids.length} catalog(s)');
        _refreshData();
      } else {
        _showTopSnackBar('Failed to delete catalogs', isError: true);
      }
    } catch (e) {
      _showTopSnackBar('Error deleting catalogs: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteServices(List<int> ids) async {
    try {
      setState(() => _isLoading = true);
      final success = await _apiService.deleteServices(ids);

      if (success) {
        _showTopSnackBar('Successfully deleted ${ids.length} service(s)');
        _refreshData();
      } else {
        _showTopSnackBar('Failed to delete services', isError: true);
      }
    } catch (e) {
      _showTopSnackBar('Error deleting services: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

// Update the _confirmDeleteSingle method to handle service deletion
  Future<void> _confirmDeleteSingle(dynamic item) async {
    String title;
    if (_currentView == 'Insights' && item is Article) {
      title = item.title;
    } else if (_currentView == 'Products' && item is Catalog) {
      title = item.name;
    } else if (_currentView == 'Services' && item is Service) {
      title = item.name;
    } else {
      _showTopSnackBar('Cannot delete item of unexpected type', isError: true);
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (_currentView == 'Insights' && item is Article) {
        await _deleteInsights([item.id]);
      } else if (_currentView == 'Products' && item is Catalog) {
        await _deleteCatalogs([item.id]);
      } else if (_currentView == 'Services' && item is Service) {
        await _deleteServices([item.id]);
      }
    }
  }

  List<dynamic> _applyFilter(List<dynamic> data, String filter) {
    if (filter == 'All' || _currentView != 'Insights') return data;

    return data.where((item) {
      if (item is Article) {
        final article = item;
        if (filter == 'Main' || filter == 'Sub') {
          return article.remarks == filter;
        } else {
          return article.category.toLowerCase() == filter.toLowerCase();
        }
      }
      return false;
    }).toList();
  }

  void _handleFilterChanged(String filter) {
    setState(() {
      _currentFilter = filter;
      _currentPage = 1;
    });
  }

  void _handleViewChanged(String view) {
    setState(() {
      _currentView = view;
      _currentPage = 1;
      _currentFilter = 'All';
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });
    await _loadData(page: 1);
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
        _isLoading = true;
      });
      _loadData(page: page).then((_) {
        setState(() {
          _selectedRows = List.filled(_currentPageData.length, false);
        });
      });
    }
  }

  void _nextPage() => _goToPage(_currentPage + 1);
  void _previousPage() => _goToPage(_currentPage - 1);

  bool get _isAllSelected => _selectedRows.isNotEmpty && _selectedRows.every((e) => e);
  bool get _isIndeterminate => _selectedRows.any((e) => e) && !_isAllSelected;

  void _toggleSelectAll(bool? value) {
    final newValue = value ?? false;
    setState(() {
      _selectedRows = List.filled(_currentPageData.length, newValue);
    });
  }

  void _toggleRow(int index, bool? value) {
    setState(() {
      _selectedRows[index] = value ?? false;
    });
  }

  Widget _buildViewOption(String viewName) {
    return GestureDetector(
      onTap: () => _handleViewChanged(viewName),
      child: Text(
        viewName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: _currentView == viewName
              ? const Color(0xFF630606)
              : Colors.grey,
          decoration: _currentView == viewName
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildCell(Widget child, {int flex = 1, bool center = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Align(
          alignment: center ? Alignment.center : Alignment.centerLeft,
          child: child,
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    final selectedCount = _selectedRows.where((selected) => selected).length;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          _buildCell(
            Row(
              children: [
                Checkbox(
                  value: _isAllSelected ? true : (_isIndeterminate ? null : false),
                  tristate: true,
                  onChanged: _selectedRows.isEmpty ? null : _toggleSelectAll,
                  activeColor: const Color(0xFF630606),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF630606);
                    } else if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    return Colors.grey.shade400;
                  }),
                ),
                Text(
                  _currentView,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            flex: 3,
          ),
          if (_currentView == 'Insights')
            _buildCell(const Text("Date of Event", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
          if (_currentView == 'Insights')
            _buildCell(const Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
          if (_currentView == 'Services')
            _buildCell(const Text("Catalog", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2,),
          if (_currentView == 'Insights')
            _buildCell(const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
          if (_currentView != 'Insights')
            _buildCell(const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)), flex: 3),
          if (_currentView == 'Insights')
          _buildCell(const Text("Visits", style: TextStyle(fontWeight: FontWeight.bold)), flex: 1),
          _buildCell(const Text("Edit", style: TextStyle(fontWeight: FontWeight.bold)), flex: 1, center: true),
          _buildCell(
            selectedCount > 0
                ? IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              tooltip: 'Delete selected',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: Text('Are you sure you want to delete $selectedCount items?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  final selectedIds = _currentPageData
                      .asMap()
                      .entries
                      .where((entry) => _selectedRows[entry.key])
                      .map((entry) {
                    if (_currentView == 'Insights' && entry.value is Article) {
                      return (entry.value as Article).id;
                    } else if (_currentView == 'Products' && entry.value is Catalog) {
                      return (entry.value as Catalog).id;
                    } else if (_currentView == 'Services' && entry.value is Service) {
                      return (entry.value as Service).id;
                    }
                    return -1; // Invalid ID for unexpected types
                  }).where((id) => id != -1) // Filter out invalid IDs
                      .toList();

                  if (_currentView == 'Insights') {
                    await _deleteInsights(selectedIds.cast<int>());
                  } else if (_currentView == 'Products') {
                    await _deleteCatalogs(selectedIds.cast<int>());
                  } else if (_currentView == 'Services') {
                    await _deleteServices(selectedIds.cast<int>());
                  }

                  setState(() => _selectedRows = List.filled(_currentPageData.length, false));
                }
              },
            )
                : const Text("Delete", style: TextStyle(fontWeight: FontWeight.bold)),
            flex: 1,
            center: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow({
    required int index,
    required dynamic item,
  }) {
    if (_currentView == 'Insights' && item is Article) {
      return _buildArticleRow(index: index, article: item);
    } else if (_currentView == 'Products' && item is Catalog) {
      return _buildCatalogRow(index: index, catalog: item);
    } else if (_currentView == 'Services' && item is Service) {
      return _buildServiceRow(index: index, service: item);
    } else {
      // Fallback for unexpected types
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text('Unexpected item type: ${item.runtimeType}'),
      );
    }
  }

  Widget _buildArticleRow({
    required int index,
    required Article article,
  }) {
    final formattedDate = DateTime.parse(article.eventDate).toLocal();
    final dateString = '${formattedDate.day}/${formattedDate.month}/${formattedDate.year}';
    final selectedCount = _selectedRows.where((selected) => selected).length;
    final isMultipleSelected = selectedCount > 1;

    Color categoryColor;
    String categoryText;

    switch (article.category.toLowerCase()) {
      case 'announcements':
        categoryColor = Colors.blue.shade100;
        categoryText = 'Announcements';
        break;
      case 'events':
        categoryColor = Colors.green.shade100;
        categoryText = 'Events';
        break;
      case 'news':
        categoryColor = Colors.purple.shade100;
        categoryText = 'News';
        break;
      default:
        categoryColor = Colors.grey.shade200;
        categoryText = article.category;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _buildCell(
            Row(
              children: [
                Checkbox(
                  value: _selectedRows[index],
                  onChanged: (value) => _toggleRow(index, value),
                  activeColor: const Color(0xFF630606),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF630606);
                    }
                    return Colors.grey.shade300;
                  }),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.article),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Html(
                      //   data: _highlightHtmlContent(
                      //     _stripHtmlTags(article.content).length > 50
                      //         ? '${_stripHtmlTags(article.content).substring(0, 50)}...'
                      //         : _stripHtmlTags(article.content),
                      //     widget.searchQuery,
                      //   ),
                      //   style: {
                      //     "body": Style(
                      //       fontSize: FontSize(12.0),
                      //       color: Colors.grey,
                      //       margin: Margins.zero,
                      //       padding: HtmlPaddings.zero,
                      //       maxLines: 2,
                      //       textOverflow: TextOverflow.ellipsis,
                      //     ),
                      //     "span": Style(
                      //       backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                      //     ),
                      //   },
                      // ),
                      const SizedBox(height: 4),
                      // Content with HTML support and highlighting
                      Html(
                        data: _highlightHtmlContent(
                            _stripHtmlTags(article.title), // <--- Apply _stripHtmlTags here too
                            widget.searchQuery
                        ),
                        style: {
                          "body": Style(
                            fontSize: FontSize(12.0),
                            color: Colors.grey,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          "span": Style(
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            flex: 3,
          ),
          _buildCell(
              Text(dateString),
              flex: 2
          ),
          _buildCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: article.remarks == 'Main'
                    ? const Color(0xFF630606)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                article.remarks,
                style: TextStyle(
                    color: article.remarks == 'Main'
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 12
                ),
              ),
            ),
            flex: 2,
          ),
          _buildCell(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                categoryText,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            flex: 2,
          ),
          _buildCell(
              Text(
                  article.clickCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              flex: 1
          ),
          _buildCell(
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  final eventDate = article.eventDate.split(' ')[0];

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Edit Insight'),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: SingleChildScrollView(
                          child: UpdateInsightForm(
                            insightId: article.id,
                            initialData: {
                              'title': article.title,
                              'content': article.content ?? '',
                              'remarks': article.remarks,
                              'category': article.category,
                              'event_date': eventDate,
                              'image_path': article.imagePath,
                            },
                            onUpdateSuccess: () {
                              Navigator.pop(context);
                              _refreshData();
                              _showTopSnackBar('Insight updated successfully');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              flex: 1,
              center: true
          ),
          _buildCell(
              IconButton(
                icon: Icon(Icons.delete,
                    color: isMultipleSelected
                        ? Colors.grey
                        : Colors.red
                ),
                onPressed: isMultipleSelected
                    ? null
                    : () => _confirmDeleteSingle(article),
              ),
              flex: 1,
              center: true
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogRow({
    required int index,
    required Catalog catalog,
  }) {
    final selectedCount = _selectedRows.where((selected) => selected).length;
    final isMultipleSelected = selectedCount > 1;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _buildCell(
            Row(
              children: [
                Checkbox(
                  value: _selectedRows[index],
                  onChanged: (value) => _toggleRow(index, value),
                  activeColor: const Color(0xFF630606),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF630606);
                    }
                    return Colors.grey.shade300;
                  }),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      catalog.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.inventory_2),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Catalog name with HTML support and highlighting
                      Html(
                        data: _highlightHtmlContent(catalog.name, widget.searchQuery),
                        style: {
                          "body": Style(
                            fontWeight: FontWeight.bold,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(16.0),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          "span": Style(
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                        },
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            flex: 3,
          ),
          _buildCell(
            // Catalog description with HTML support and highlighting
            Html(
              data: _highlightHtmlContent(
                catalog.description.length > 100
                    ? '${catalog.description.substring(0, 100)}...'
                    : catalog.description,
                widget.searchQuery,
              ),
              style: {
                "body": Style(
                  fontSize: FontSize(12.0),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                "span": Style(
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                ),
              },
            ),
            flex: 3,
          ),
          _buildCell(
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Edit Catalog'),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: SingleChildScrollView(
                          child: UpdateCatalogForm(
                            catalogId: catalog.id,
                            initialData: {
                              'name': catalog.name,
                              'description': catalog.description ?? '',
                              'image_path': catalog.imagePath,
                              'is_enabled': catalog.isEnabled,
                            },
                            onUpdateSuccess: () {
                              Navigator.pop(context);
                              _refreshData();
                              _showTopSnackBar('Catalog updated successfully');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              flex: 1,
              center: true
          ),
          _buildCell(
              IconButton(
                icon: Icon(Icons.delete,
                    color: isMultipleSelected
                        ? Colors.grey
                        : Colors.red
                ),
                onPressed: isMultipleSelected
                    ? null
                    : () => _confirmDeleteSingle(catalog),
              ),
              flex: 1,
              center: true
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRow({
    required int index,
    required Service service,
  }) {
    final selectedCount = _selectedRows.where((selected) => selected).length;
    final isMultipleSelected = selectedCount > 1;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _buildCell(
            Row(
              children: [
                Checkbox(
                  value: _selectedRows[index],
                  onChanged: (value) => _toggleRow(index, value),
                  activeColor: const Color(0xFF630606),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF630606);
                    }
                    return Colors.grey.shade300;
                  }),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      service.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.design_services),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service name with HTML support and highlighting
                      Html(
                        data: _highlightHtmlContent(service.name, widget.searchQuery),
                        style: {
                          "body": Style(
                            fontWeight: FontWeight.bold,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(16.0),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          "span": Style(
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                        },
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            flex: 3,
          ),
          if (_currentView == 'Services')
            _buildCell(
              // Catalog name with highlighting
              Html(
                data: _highlightHtmlContent(service.catalogName ?? "-", widget.searchQuery),
                style: {
                  "body": Style(
                    fontSize: FontSize(12.0),
                    fontWeight: FontWeight.w500,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "span": Style(
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                  ),
                },
              ),
              flex: 2,
            ),
          _buildCell(
            // Service description with HTML support and highlighting
            Html(
              data: _highlightHtmlContent(
                service.description.length > 100
                    ? '${service.description.substring(0, 100)}...'
                    : service.description,
                widget.searchQuery,
              ),
              style: {
                "body": Style(
                  fontSize: FontSize(12.0),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                "span": Style(
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                ),
              },
            ),
            flex: 3,
          ),
          _buildCell(
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Edit Service'),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: SingleChildScrollView(
                          child: UpdateServiceForm(
                            serviceId: service.id,
                            initialData: {
                              'name': service.name,
                              'description': service.description ?? '',
                              'image_path': service.imagePath,
                            },
                            onUpdateSuccess: () {
                              Navigator.pop(context);
                              _refreshData();
                              _showTopSnackBar('Service updated successfully');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              flex: 1,
              center: true
          ),
          _buildCell(
              IconButton(
                icon: Icon(Icons.delete,
                    color: isMultipleSelected
                        ? Colors.grey
                        : Colors.red
                ),
                onPressed: isMultipleSelected
                    ? null
                    : () => _confirmDeleteSingle(service),
              ),
              flex: 1,
              center: true
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage > 1
                  ? const Color(0xFF630606)
                  : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: _currentPage > 1 ? _previousPage : null,
            child: const Text(
              'Previous',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Text(
            'Page $_currentPage of $_totalPages',
            style: const TextStyle(fontSize: 15),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentPage < _totalPages
                  ? const Color(0xFF630606)
                  : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: _currentPage < _totalPages ? _nextPage : null,
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildViewOption('Insights'),
                        const SizedBox(width: 16),
                        Container(
                          width: 1,
                          height: 20, // Fixed height
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        _buildViewOption('Products'),
                        const SizedBox(width: 16),
                        Container(
                          width: 1,
                          height: 20, // Fixed height
                          color: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        _buildViewOption('Services'),
                      ],
                    ),
                  ),
                  if (_currentView == 'Insights')
                    InsightsFilterButton(onFilterChanged: _handleFilterChanged),
                ],
              ),
            ),
            const Divider(height: 7),

            _buildHeaderRow(),

            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_isLoading)
                        const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                CircularProgressIndicator(),
                              ],
                            )
                        )
                      else
                        FutureBuilder<List<dynamic>>(
                          future: _futureData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Icon(
                                      Icons.wifi_off,
                                      size: 48,
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      snapshot.error.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.refresh, color: Colors.white),
                                      label: const Text(
                                        'Try Again',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF630606),
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: _refreshData,
                                    ),
                                  ],
                                ),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No $_currentView found'));
                            }

                            return Column(
                              children: [
                                for (var i = 0; i < _filteredData.length; i++)
                                  _buildDataRow(
                                    index: i,
                                    item: _filteredData[i],
                                  ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),

            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }
}