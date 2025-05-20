import 'package:flutter/material.dart';

class Plantcycle extends StatefulWidget {
  const Plantcycle({super.key});

  @override
  State<Plantcycle> createState() => _PlantcycleState();
}

class _PlantcycleState extends State<Plantcycle> {
   String _selectedPlant = 'Tomato'; // Default plant type
  String _growthCycle = '';
  String _plantingSeason = '';

  // Method to update cycle and season based on selected plant
  void _updateGrowthCycle(String plant) {
    setState(() {
      _selectedPlant = plant;

      if (plant == 'Tomato') {
        _growthCycle = '70-90 days';
        _plantingSeason = 'Spring/Summer';
      } else if (plant == 'Orange') {
        _growthCycle = '8-12 months';
        _plantingSeason = 'Spring';
      } else if (plant == 'Wheat') {
        _growthCycle = '120-150 days';
        _plantingSeason = 'Fall';
      } else if (plant == 'Corn') {
        _growthCycle = '60-100 days';
        _plantingSeason = 'Spring';
      } else if (plant == 'Cotton') {
        _growthCycle = '150-180 days';
        _plantingSeason = 'Spring';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Growth Cycle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select plant type
            DropdownButton<String>(
              value: _selectedPlant,
              onChanged: (String? newValue) {
                _updateGrowthCycle(newValue!);
              },
              items: <String>['Tomato', 'Orange', 'Wheat', 'Corn', 'Cotton']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Display the growth cycle and planting season
            Text(
              'Growth Cycle: $_growthCycle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Best Planting Season: $_plantingSeason',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
          ]
            
           
       ), 
       ),
      
    );
  }
}