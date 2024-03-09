import 'package:flutter/material.dart';

class QuantityDropdown extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onChanged;

  const QuantityDropdown({
    Key? key,
    required this.initialQuantity,
    required this.onChanged,
  }) : super(key: key);

  @override
  _QuantityDropdownState createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  late int _selectedQuantity;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey)
      ),
      child: DropdownButton<int>(
        elevation: 0,
        value: _selectedQuantity,
        onChanged: (value) {
          setState(() {
            _selectedQuantity = value!;
            widget.onChanged(_selectedQuantity);
          });
        },
        items: List.generate(
          10,
          (index) => DropdownMenuItem(
            value: index + 1,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text((index + 1).toString()),
            ),
          ),
        ),
      ),
    );
  }
}
