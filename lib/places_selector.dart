import 'package:flutter/material.dart';
import 'nga_places_query.dart';

class PlacesSelector extends StatefulWidget {
  final String? state;
  final String? lga;
  final String? ward;
  final Function(String?, String?, String?)? onSelected;
  final InputDecoration? inputDecoration;
  final double spacing;

  const PlacesSelector({super.key, this.state, this.onSelected, this.lga, this.ward, this.inputDecoration, this.spacing=10});

  @override
  State<PlacesSelector> createState() => _PlacesSelectorState();
}

class _PlacesSelectorState extends State<PlacesSelector> {
  final NigeriaPlacesQuery _query = NigeriaPlacesQuery();

  List<String> _states = [];
  List<String> _lgas = [];
  List<String> _wards = [];

  String? _selectedState;
  String? _selectedLga;
  String? _selectedWard;

  bool _isLoadingStates = true;
  bool _isLoadingLgas = false;
  bool _isLoadingWards = false;

  @override
  void initState() {
    super.initState();
    _loadStates();
  }

  Future<void> _loadStates() async {
    setState(() => _isLoadingStates = true);
    final states = await _query.getStates();
    setState(() {
      _states = states;
      _isLoadingStates = false;
    });
  }

  Future<void> _loadLgas(String state) async {
    setState(() {
      _isLoadingLgas = true;
      _lgas = [];
      _wards = [];
      _selectedLga = null;
      _selectedWard = null;
    });

    final lgas = await _query.getLGAs(state);
    setState(() {
      _lgas = lgas;
      _isLoadingLgas = false;
    });
  }

  Future<void> _loadWards(String lga) async {
    if (_selectedState == null) return;
    setState(() {
      _isLoadingWards = true;
      _wards = [];
      _selectedWard = null;
    });

    final wards = await _query.getWards(lga, state: _selectedState!);
    setState(() {
      _wards = wards;
      _isLoadingWards = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: widget.spacing,
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: _selectedState,
            decoration: widget.inputDecoration,
            hint: _isLoadingStates
                ? const Text('Loading states...')
                : const Text('Select State'),
            items: _states
                .map((state) => DropdownMenuItem(
              value: state,
              child: Text(state),
            ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedState = value;
              });
              _loadLgas(value);
            },
          ),
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: _selectedLga,
            decoration: widget.inputDecoration,

            hint: _isLoadingLgas
                ? const Text('Loading LGAs...')
                : const Text('Select LGA'),
            items: _lgas
                .map((lga) => DropdownMenuItem(
              value: lga,
              child: Text(lga),
            ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedLga = value;
              });
              _loadWards(value);
            },
          ),
          /// WARD DROPDOWN
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: _selectedWard,
            decoration: widget.inputDecoration,
            hint: _isLoadingWards
                ? const Text('Loading wards...')
                : const Text('Select Ward'),
            items: _wards
                .map((ward) => DropdownMenuItem(
              value: ward,
              child: Text(ward),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedWard = value;
              });
              widget.onSelected?.call(_selectedState, _selectedLga, _selectedWard);
            },
          ),
        ],
    );
  }
}
