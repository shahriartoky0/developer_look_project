import 'package:developper_look/model/airport_details.dart';
import 'package:flutter/material.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String labelText;
  final ValueChanged<T> onItemSelected;
  final Widget Function(T) itemBuilder;
  final String Function(T) displayString; // Non-nullable, for display
  final double height;
  final bool showSearch;
  final ScrollController? scrollController;
  final bool shouldScroll;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.labelText,
    required this.onItemSelected,
    required this.itemBuilder,
    required this.displayString,
    this.height = 200.0,
    this.showSearch = true,
    this.scrollController,
    this.shouldScroll = false,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();

}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<List<T>> _getSuggestions(String pattern) async {
    if (pattern.isEmpty) {
      return widget.items;
    }

    final filteredItems = widget.items.where((item) {
      if (item == null) return false;

      // Check if T is AirportData for multi-field filtering
      if (T == AirportDetails) {
        final airport = item as AirportDetails;
        return airport.name.toString().toLowerCase().contains(pattern.toLowerCase()) ||
            airport.city.toString().toLowerCase().contains(pattern.toLowerCase()) ||
            airport.code.toString().toLowerCase().contains(pattern.toLowerCase());
      }

      // Fallback to displayString for other types
      final itemString = widget.displayString(item);
      return itemString.toLowerCase().contains(pattern.toLowerCase());
    }).toList();

    print('Suggestions for pattern "$pattern": $filteredItems');
    return filteredItems;
  }

  void _scrollToMakeOverlayVisible(BuildContext context) {
    if (widget.scrollController == null || !widget.shouldScroll) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final overlayHeight = widget.height;
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final overlayBottom = position.dy + renderBox.size.height + overlayHeight;
    if (overlayBottom > screenHeight - keyboardHeight) {
      final scrollOffset = widget.scrollController!.offset +
          (overlayBottom - (screenHeight - keyboardHeight)) +
          16.0;
      widget.scrollController!.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropDownSearchField<T>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.7)),
          ),
          hintText: widget.labelText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        ),
      ),
      suggestionsCallback: (pattern) async => await _getSuggestions(pattern),
      itemBuilder: (context, suggestion) {
        if (suggestion == null) {
          return const SizedBox.shrink();
        }
        return widget.itemBuilder(suggestion);
      },
      onSuggestionSelected: (suggestion) {
        if (suggestion != null) {
          widget.onItemSelected(suggestion);
          _controller.text = widget.displayString(suggestion);
          _focusNode.unfocus();
          _scrollToMakeOverlayVisible(context);
        }
      },
      displayAllSuggestionWhenTap: widget.showSearch,
      noItemsFoundBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No items found', style: TextStyle(color: Colors.grey)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        final matchingItem = widget.items.firstWhere(
              (item) {
            if (item == null) return false;
            return widget.displayString(item).toLowerCase() == value.toString().toLowerCase();
          },
          orElse: () => null as T,
        );
        if (matchingItem == null) {
          return 'Please select a valid item from the list';
        }
        return null;
      },
      isMultiSelectDropdown: false,
    );
  }
}