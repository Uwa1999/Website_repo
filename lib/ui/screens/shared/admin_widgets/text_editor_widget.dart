// text_editor_widget.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedTextEditor extends StatefulWidget {
  const AdvancedTextEditor({super.key});

  @override
  State<AdvancedTextEditor> createState() => AdvancedTextEditorState();
}

class AdvancedTextEditorState extends State<AdvancedTextEditor> {
  final TextEditingController _controller = TextEditingController();
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
    _controller.addListener(_updateSelection);
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

  void clearContent() {
    setState(() {
      _controller.clear();
      _resetFormatting();
    });
  }

  String getHtmlContent() {
    String html = _controller.text;
    if (_currentIsBold) html = '<strong>$html</strong>';
    if (_currentIsItalic) html = '<em>$html</em>';
    if (_currentIsUnderline) html = '<u>$html</u>';
    return html;
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

    // If text is selected, apply formatting to the selection
    if (_currentSelection.isValid && !_currentSelection.isCollapsed) {
      final selectedText = _controller.text.substring(
        _currentSelection.start,
        _currentSelection.end,
      );

      // For simplicity, we're just replacing the text with itself
      // In a real app, you'd want to track spans of text with different formatting
      _controller.text = _controller.text.replaceRange(
        _currentSelection.start,
        _currentSelection.end,
        selectedText,
      );

      _controller.selection = _currentSelection;
    }
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