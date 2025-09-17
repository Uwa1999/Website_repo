import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String tittle;
  final IconData icon;
  final bool isLoading;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onChanged;
  final String buttonText;

  const CustomAlertDialog({
    Key? key,
    required this.tittle,
    required this.icon,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.isLoading,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff15951a),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                height: 50,
                child: Row(
                  children: [
                    Icon(icon, size: 18, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      tittle,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'RobotoThin',
                      ),
                    ),
                  ],
                ),
              ),
              content: isLoading
                  ? const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              )
                  : SizedBox(
                height: 200,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((item) {
                      final isSelected = selectedItems.contains(item);
                      return CheckboxListTile(
                        title: Text(item),
                        value: isSelected,
                        onChanged: (bool? checked) {
                          if (checked == null) return;
                          setStateDialog(() {
                            if (checked) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                            onChanged(List.from(selectedItems));
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Color(0xff15951a),
                        fontSize: 13,
                        fontFamily: 'RobothoThin',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
