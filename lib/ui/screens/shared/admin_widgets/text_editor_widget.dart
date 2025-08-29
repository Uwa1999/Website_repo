import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedTextEditor extends StatefulWidget {
  final String? initialContent;
  const AdvancedTextEditor({super.key, this.initialContent});

  @override
  State<AdvancedTextEditor> createState() => AdvancedTextEditorState();
}

class AdvancedTextEditorState extends State<AdvancedTextEditor> {
  late final TextEditingController _controller;
  TextSelection _currentSelection = const TextSelection.collapsed(offset: 0);

  // Default formatting values
  String _currentFontFamily = 'Roboto';
  double _currentFontSize = 14;
  Color _currentTextColor = Colors.black;
  bool _currentIsBold = false;
  bool _currentIsItalic = false;
  bool _currentIsUnderline = false;
  TextAlign _currentAlignment = TextAlign.left;

  // These track the formatting for new text (after cursor position)
  String _nextFontFamily = 'Roboto';
  double _nextFontSize = 14;
  Color _nextTextColor = Colors.black;
  bool _nextIsBold = false;
  bool _nextIsItalic = false;
  bool _nextIsUnderline = false;

  final List<String> _availableFonts = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
    'Raleway',
    'Nunito',
    'Dancing Script',
    'Pacifico',
  ];

  final List<double> _fontSizes = [8, 10, 12, 14, 16, 18, 20, 24, 28, 32, 36];

  final List<Color> _colorPalette = [
    Colors.black,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent ?? '');
    _controller.addListener(_updateSelection);

    // Parse initial HTML content if provided
    if (widget.initialContent != null && widget.initialContent!.isNotEmpty) {
      _parseHtmlContent(widget.initialContent!);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSelection);
    _controller.dispose();
    super.dispose();
  }

  void _updateSelection() {
    setState(() {
      _currentSelection = _controller.selection;

      // When selection changes, update the "next" formatting to match
      // the style at the cursor position (for new text)
      if (_currentSelection.isCollapsed) {
        _nextFontFamily = _currentFontFamily;
        _nextFontSize = _currentFontSize;
        _nextTextColor = _currentTextColor;
        _nextIsBold = _currentIsBold;
        _nextIsItalic = _currentIsItalic;
        _nextIsUnderline = _currentIsUnderline;
      }
    });
  }

  /// Clears the editor content and resets all formatting
  void clearContent() {
    setState(() {
      _controller.clear();
      _resetFormatting();
    });
  }

  /// Gets the current content as HTML with all formatting
  String getHtmlContent() {
    String content = _controller.text;

    // Wrap content in appropriate HTML tags based on formatting
    if (_currentIsBold) content = '<strong>$content</strong>';
    if (_currentIsItalic) content = '<em>$content</em>';
    if (_currentIsUnderline) content = '<u>$content</u>';

    // Add font family and size
    content = '<span style="font-family: $_currentFontFamily; font-size: ${_currentFontSize}px;">$content</span>';

    // Add text color
    content = '<span style="color: ${_colorToHex(_currentTextColor)};">$content</span>';

    // Add alignment
    String align = 'left';
    if (_currentAlignment == TextAlign.center) align = 'center';
    if (_currentAlignment == TextAlign.right) align = 'right';

    return '<div style="text-align: $align;">$content</div>';
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}';
  }

  /// Parses HTML content and applies formatting to the editor
  void _parseHtmlContent(String html) {
    // This is a simplified parser - you might need to enhance it for more complex HTML

    // Extract alignment
    final alignRegex = RegExp(r'text-align:\s*([^;"]+)');
    final alignMatch = alignRegex.firstMatch(html);
    if (alignMatch != null) {
      final align = alignMatch.group(1)?.trim();
      if (align == 'center') {
        _currentAlignment = TextAlign.center;
      } else if (align == 'right') {
        _currentAlignment = TextAlign.right;
      } else {
        _currentAlignment = TextAlign.left;
      }
    }

    // Extract font family
    final fontFamilyRegex = RegExp(r'font-family:\s*([^;"]+)');
    final fontFamilyMatch = fontFamilyRegex.firstMatch(html);
    if (fontFamilyMatch != null) {
      _currentFontFamily = fontFamilyMatch.group(1)?.trim() ?? 'Roboto';
      _nextFontFamily = _currentFontFamily;
    }

    // Extract font size
    final fontSizeRegex = RegExp(r'font-size:\s*([^;"]+)px');
    final fontSizeMatch = fontSizeRegex.firstMatch(html);
    if (fontSizeMatch != null) {
      _currentFontSize = double.tryParse(fontSizeMatch.group(1)?.trim() ?? '14') ?? 14;
      _nextFontSize = _currentFontSize;
    }

    // Extract color
    final colorRegex = RegExp(r'color:\s*([^;"]+)');
    final colorMatch = colorRegex.firstMatch(html);
    if (colorMatch != null) {
      final colorStr = colorMatch.group(1)?.trim();
      if (colorStr != null) {
        _currentTextColor = _hexToColor(colorStr);
        _nextTextColor = _currentTextColor;
      }
    }

    // Extract basic formatting
    _currentIsBold = html.contains('<strong>') || html.contains('<b>');
    _currentIsItalic = html.contains('<em>') || html.contains('<i>');
    _currentIsUnderline = html.contains('<u>');

    // Extract plain text (remove HTML tags)
    final text = html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();

    _controller.text = text;
  }

  Color _hexToColor(String hexString) {
    try {
      if (hexString.startsWith('#')) {
        return Color(int.parse(hexString.substring(1), radix: 16) + 0xFF000000);
      } else if (hexString.startsWith('0x')) {
        return Color(int.parse(hexString));
      } else if (hexString.startsWith('rgb')) {
        // Handle rgb() format if needed
        return Colors.black;
      } else {
        // Try to match named colors
        switch (hexString.toLowerCase()) {
          case 'red': return Colors.red;
          case 'pink': return Colors.pink;
          case 'purple': return Colors.purple;
          case 'deepPurple': return Colors.deepPurple;
          case 'indigo': return Colors.indigo;
          case 'blue': return Colors.blue;
          case 'lightBlue': return Colors.lightBlue;
          case 'cyan': return Colors.cyan;
          case 'teal': return Colors.teal;
          case 'green': return Colors.green;
          case 'lightGreen': return Colors.lightGreen;
          case 'lime': return Colors.lime;
          case 'yellow': return Colors.yellow;
          case 'amber': return Colors.amber;
          case 'orange': return Colors.orange;
          case 'deepOrange': return Colors.deepOrange;
          case 'brown': return Colors.brown;
          case 'grey': return Colors.grey;
          case 'blueGrey': return Colors.blueGrey;
          default: return Colors.black;
        }
      }
    } catch (e) {
      return Colors.black;
    }
  }

  /// Sets the editor content programmatically
  void setHtmlContent(String html) {
    _parseHtmlContent(html);
  }

  void _applyFormatting({
    String? fontFamily,
    double? fontSize,
    Color? textColor,
    bool? isBold,
    bool? isItalic,
    bool? isUnderline,
    TextAlign? alignment,
  }) {
    setState(() {
      if (fontFamily != null) {
        _nextFontFamily = fontFamily;
        if (_currentSelection.isCollapsed) {
          _currentFontFamily = fontFamily;
        }
      }
      if (fontSize != null) {
        _nextFontSize = fontSize;
        if (_currentSelection.isCollapsed) {
          _currentFontSize = fontSize;
        }
      }
      if (textColor != null) {
        _nextTextColor = textColor;
        if (_currentSelection.isCollapsed) {
          _currentTextColor = textColor;
        }
      }
      if (isBold != null) {
        _nextIsBold = isBold;
        if (_currentSelection.isCollapsed) {
          _currentIsBold = isBold;
        }
      }
      if (isItalic != null) {
        _nextIsItalic = isItalic;
        if (_currentSelection.isCollapsed) {
          _currentIsItalic = isItalic;
        }
      }
      if (isUnderline != null) {
        _nextIsUnderline = isUnderline;
        if (_currentSelection.isCollapsed) {
          _currentIsUnderline = isUnderline;
        }
      }
      if (alignment != null) {
        _currentAlignment = alignment;
      }
    });
  }

  void _resetFormatting() {
    setState(() {
      _currentFontFamily = 'Roboto';
      _currentFontSize = 14;
      _currentTextColor = Colors.black;
      _currentIsBold = false;
      _currentIsItalic = false;
      _currentIsUnderline = false;
      _currentAlignment = TextAlign.left;

      _nextFontFamily = 'Roboto';
      _nextFontSize = 14;
      _nextTextColor = Colors.black;
      _nextIsBold = false;
      _nextIsItalic = false;
      _nextIsUnderline = false;
    });
  }

  String _colorName(Color color) {
    if (color == Colors.black) return 'Black';
    if (color == Colors.red) return 'Red';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.deepPurple) return 'Deep Purple';
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.lightBlue) return 'Light Blue';
    if (color == Colors.cyan) return 'Cyan';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.green) return 'Green';
    if (color == Colors.lightGreen) return 'Light Green';
    if (color == Colors.lime) return 'Lime';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.amber) return 'Amber';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.deepOrange) return 'Deep Orange';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.grey) return 'Grey';
    if (color == Colors.blueGrey) return 'Blue Grey';
    return 'Custom';
  }

  TextStyle _getTextStyleForInput() {
    return GoogleFonts.getFont(
      _nextFontFamily,
      fontWeight: _nextIsBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: _nextIsItalic ? FontStyle.italic : FontStyle.normal,
      decoration: _nextIsUnderline ? TextDecoration.underline : TextDecoration.none,
      fontSize: _nextFontSize,
      color: _nextTextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("BODY", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Font Family Dropdown
                      Tooltip(
                        message: 'Change font family',
                        child: DropdownButton<String>(
                          value: _currentSelection.isCollapsed ? _nextFontFamily : _currentFontFamily,
                          items: _availableFonts.map((String font) {
                            return DropdownMenuItem<String>(
                              value: font,
                              child: Text(
                                font,
                                style: GoogleFonts.getFont(font, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _applyFormatting(fontFamily: newValue);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Font Size Dropdown
                      Tooltip(
                        message: 'Change font size',
                        child: DropdownButton<double>(
                          value: _currentSelection.isCollapsed ? _nextFontSize : _currentFontSize,
                          items: _fontSizes.map((double size) {
                            return DropdownMenuItem<double>(
                              value: size,
                              child: Text(size.toString()),
                            );
                          }).toList(),
                          onChanged: (double? newValue) {
                            if (newValue != null) {
                              _applyFormatting(fontSize: newValue);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Text Color Picker
                      Tooltip(
                        message: 'Text color',
                        child: PopupMenuButton<Color>(
                          itemBuilder: (BuildContext context) => _colorPalette
                              .map((color) => PopupMenuItem<Color>(
                            value: color,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: color,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Text(_colorName(color)),
                                if (color == (_currentSelection.isCollapsed ? _nextTextColor : _currentTextColor))
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(Icons.check, size: 16),
                                  ),
                              ],
                            ),
                          ))
                              .toList(),
                          onSelected: (Color color) {
                            _applyFormatting(textColor: color);
                          },
                          child: Icon(
                            Icons.format_color_text,
                            color: _currentSelection.isCollapsed ? _nextTextColor : _currentTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Text style buttons
                      ToggleButton(
                        icon: Icons.format_bold,
                        tooltip: 'Bold',
                        isActive: _currentSelection.isCollapsed ? _nextIsBold : _currentIsBold,
                        onPressed: () => _applyFormatting(isBold: !(_currentSelection.isCollapsed ? _nextIsBold : _currentIsBold)),
                      ),
                      ToggleButton(
                        icon: Icons.format_italic,
                        tooltip: 'Italic',
                        isActive: _currentSelection.isCollapsed ? _nextIsItalic : _currentIsItalic,
                        onPressed: () => _applyFormatting(isItalic: !(_currentSelection.isCollapsed ? _nextIsItalic : _currentIsItalic)),
                      ),
                      ToggleButton(
                        icon: Icons.format_underline,
                        tooltip: 'Underline',
                        isActive: _currentSelection.isCollapsed ? _nextIsUnderline : _currentIsUnderline,
                        onPressed: () => _applyFormatting(isUnderline: !(_currentSelection.isCollapsed ? _nextIsUnderline : _currentIsUnderline)),
                      ),
                      const VerticalDivider(width: 16, color: Colors.grey),

                      // Alignment buttons
                      ToggleButton(
                        icon: Icons.format_align_left,
                        tooltip: 'Align left',
                        isActive: _currentAlignment == TextAlign.left,
                        onPressed: () => _applyFormatting(alignment: TextAlign.left),
                      ),
                      ToggleButton(
                        icon: Icons.format_align_center,
                        tooltip: 'Align center',
                        isActive: _currentAlignment == TextAlign.center,
                        onPressed: () => _applyFormatting(alignment: TextAlign.center),
                      ),
                      ToggleButton(
                        icon: Icons.format_align_right,
                        tooltip: 'Align right',
                        isActive: _currentAlignment == TextAlign.right,
                        onPressed: () => _applyFormatting(alignment: TextAlign.right),
                      ),
                      const VerticalDivider(width: 16, color: Colors.grey),

                      // Clear formatting
                      Tooltip(
                        message: 'Clear formatting',
                        child: IconButton(
                          icon: const Icon(Icons.format_clear),
                          onPressed: _resetFormatting,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Text field
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlign: _currentAlignment,
                  style: _getTextStyleForInput(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write your content here...",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool isActive;
  final VoidCallback onPressed;

  const ToggleButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        color: isActive ? Colors.blue : Colors.grey[700],
        onPressed: onPressed,
      ),
    );
  }
}