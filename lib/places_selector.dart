import 'package:flutter/material.dart';
import 'nga_places_query.dart';

class PlacesSelector extends StatefulWidget {
  final String? state;
  final String? lga;
  final String? ward;
  final Function(String?, String?, String?)? onSelected;
  final InputDecoration? inputDecoration;
  final double spacing;
  final bool hideState;
  final bool hideLGA;
  final bool hideWard;

  const PlacesSelector({super.key, this.state, this.onSelected, this.lga, this.ward, this.inputDecoration, this.spacing=10, this.hideState=false, this.hideLGA=false, this.hideWard=false});

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
    _selectedState = widget.state;
    _selectedLga = widget.lga;
    _selectedWard = widget.ward;
    _loadStates();
    if(_selectedState != null){
      _loadLgas(_selectedState!);
    }
    if(_selectedLga != null){
      _loadWards(_selectedLga!);
    }

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
          if(!widget.hideState)DropdownButtonFormField<String>(
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
            validator: (value) {
              if (value == null) {
                return 'Please select a state';
              }
              return null;
            },
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedState = value;
              });
              _loadLgas(value);
            },
          ),
          if(!widget.hideLGA)DropdownButtonFormField<String>(
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
            validator: (value) {
              if (value == null) {
                return 'Please select an LGA';
              }
              return null;
            },
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedLga = value;
              });
              _loadWards(value);
            },
          ),
          /// WARD DROPDOWN
          if(!widget.hideWard)DropdownButtonFormField<String>(
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
            validator: (value) {
              if (value == null) {
                return 'Please select a ward';
              }
              return null;
            }
          ),
        ],
    );
  }
}
