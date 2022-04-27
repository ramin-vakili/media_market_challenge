import 'package:flutter/material.dart';

class SingleChooseOption<T extends Enum> extends StatefulWidget {
  const SingleChooseOption({
    required this.options,
    Key? key,
    this.onOptionSelected,
    this.selectedOption,
  }) : super(key: key);

  final List<T> options;

  final T? selectedOption;

  final Function(T)? onOptionSelected;

  @override
  _SingleChooseOptionState<T> createState() => _SingleChooseOptionState<T>();
}

class _SingleChooseOptionState<T extends Enum>
    extends State<SingleChooseOption<T>> {
  late T _selectedOption;

  @override
  void initState() {
    super.initState();

    _selectedOption = widget.selectedOption ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(widget.options.length, (int index) {
        final T t = widget.options[index];
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: InkWell(
            onTap: () => setState(() {
              _selectedOption = t;
              widget.onOptionSelected?.call(t);
            }),
            child: Chip(
              backgroundColor: t == _selectedOption
                  ? Colors.green
                  : Colors.grey.withOpacity(0.5),
              label: Text(
                t.name,
                style: TextStyle(
                  color: t == _selectedOption ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
