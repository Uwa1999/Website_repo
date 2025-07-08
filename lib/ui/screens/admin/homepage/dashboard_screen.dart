import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/models/article_model.dart';
import '../../../../services/api/article_api.dart';
import '../../shared/admin_widgets/buttons/insight_filter_button.dart';
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
  late Future<List<Article>> _futureArticles;
  List<bool> _selectedRows = [];
  bool _isLoading = true;
  String _currentFilter = 'All';

  // Pagination variables
  int _currentPage = 1;
  final int _rowsPerPage = 10;
  int _totalPages = 1;
  List<Article> _currentPageArticles = [];
  int _totalItems = 0;

  @override
  void initState() {
    super.initState();
    _futureArticles = _loadArticles(page: _currentPage);
  }

  List<Article> get _filteredArticles {
    List<Article> articlesToFilter = _currentPageArticles;

    // First apply the category filter
    if (_currentFilter != 'All') {
      articlesToFilter = _applyFilter(articlesToFilter, _currentFilter);
    }

    // Then apply search query if exists
    if (widget.searchQuery.isNotEmpty) {
      final query = widget.searchQuery.toLowerCase();
      articlesToFilter = articlesToFilter.where((article) {
        return article.title.toLowerCase().contains(query) ||
            article.content.toLowerCase().contains(query) ||
            article.category.toLowerCase().contains(query) ||
            article.remarks.toLowerCase().contains(query);
      }).toList();
    }

    return articlesToFilter;
  }

  @override
  void didUpdateWidget(covariant DashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() {});
    }
  }

  Future<List<Article>> _loadArticles({int page = 1}) async {
    try {
      setState(() => _isLoading = true);
      final response = await _apiService.fetchPaginatedArticles(page: page);

      setState(() {
        _currentPageArticles = response.items;
        _totalItems = response.totalCount;
        _totalPages = response.totalPages;
        _currentPage = response.currentPage;
        _selectedRows = List.filled(_currentPageArticles.length, false);
        _isLoading = false;
      });

      return _currentPageArticles;
    } catch (e) {
      setState(() => _isLoading = false);
      throw Exception('Failed to load articles: $e');
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
        _refreshArticles();
      }
    } catch (e) {
      _showTopSnackBar('Error deleting items: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmDeleteSingle(Article article) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${article.title}"?'),
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
      await _deleteInsights([article.id]);
    }
  }

  List<Article> _applyFilter(List<Article> articles, String filter) {
    if (filter == 'All') return articles;

    return articles.where((article) {
      if (filter == 'Main' || filter == 'Sub') {
        return article.remarks == filter;
      } else {
        return article.category.toLowerCase() == filter.toLowerCase();
      }
    }).toList();
  }

  void _handleFilterChanged(String filter) {
    setState(() {
      _currentFilter = filter;
      _currentPage = 1;
    });
  }

  Future<void> _refreshArticles() async {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });
    await _loadArticles(page: 1);
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
        _isLoading = true;
      });
      _loadArticles(page: page).then((_) {
        setState(() {
          _selectedRows = List.filled(_currentPageArticles.length, false);
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
      _selectedRows = List.filled(_currentPageArticles.length, newValue);
    });
  }

  void _toggleRow(int index, bool? value) {
    setState(() {
      _selectedRows[index] = value ?? false;
    });
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
                const Text(
                  "Insights",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            flex: 3,
          ),
          _buildCell(const Text("Date of Event", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
          _buildCell(const Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
          _buildCell(const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)), flex: 2),
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
                  final selectedIds = _currentPageArticles
                      .asMap()
                      .entries
                      .where((entry) => _selectedRows[entry.key])
                      .map((entry) => entry.value.id)
                      .toList();
                  await _deleteInsights(selectedIds);
                  setState(() => _selectedRows = List.filled(_currentPageArticles.length, false));
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

  Widget _buildArticleRow({
    required int index,
    required Article article,
  }) {
    final formattedDate = DateTime.parse(article.eventDate).toLocal();
    final dateString = '${formattedDate.day}/${formattedDate.month}/${formattedDate.year}';
    final selectedCount = _selectedRows.where((selected) => selected).length;
    final isMultipleSelected = selectedCount > 1;
    final isThisRowSelected = _selectedRows[index];

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
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Html(
                        data: article.content.length > 50
                            ? '${article.content.substring(0, 50)}...'
                            : article.content,
                        style: {
                          "body": Style(
                            fontSize: FontSize(12.0),
                            color: Colors.grey,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
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
          _buildCell(Text(dateString), flex: 2),
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
                              _refreshArticles();
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
                  const Text(
                    "Insights",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  InsightsFilterButton(onFilterChanged: _handleFilterChanged),
                ],
              ),
            ),
            const Divider(height: 7),

            _buildHeaderRow(),

            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshArticles,
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
                        FutureBuilder<List<Article>>(
                          future: _futureArticles,
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
                                      onPressed: _refreshArticles,
                                    ),
                                  ],
                                ),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('No articles found'));
                            }

                            return Column(
                              children: [
                                for (var i = 0; i < _filteredArticles.length; i++)
                                  _buildArticleRow(
                                    index: i,
                                    article: _filteredArticles[i],
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