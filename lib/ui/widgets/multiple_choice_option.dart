import 'package:flutter/material.dart';

class MultipleChoiceOption<T extends Enum> extends StatefulWidget {
  const MultipleChoiceOption({
    required this.options,
    required this.selectedOptions,
    Key? key,
    this.onOptionSelected,
  })  : assert(options.length >= 2),
        super(key: key);

  final List<T> options;

  final List<T> selectedOptions;

  final Function(List<T>)? onOptionSelected;

  @override
  _MultipleChoiceOptionState<T> createState() =>
      _MultipleChoiceOptionState<T>();
}

class _MultipleChoiceOptionState<T extends Enum>
    extends State<MultipleChoiceOption<T>> {
  final List<T> _selectedOptions = <T>[];

  @override
  void initState() {
    super.initState();

    _selectedOptions.addAll(widget.selectedOptions);
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
              if (!_selectedOptions.contains(t)) {
                _selectedOptions.add(t);
              } else {
                if (_selectedOptions.length < 2) {
                  return;
                }
                _selectedOptions.remove(t);
              }
              widget.onOptionSelected?.call(_selectedOptions);
            }),
            child: Chip(
              backgroundColor: _selectedOptions.contains(t)
                  ? Colors.green
                  : Colors.grey.withOpacity(0.5),
              label: Text(
                t.name,
                style: TextStyle(
                  color: _selectedOptions.contains(t)
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
