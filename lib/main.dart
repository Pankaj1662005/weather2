import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WeatherPredictionApp());
}

class WeatherPredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Prediction',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {
    'maxtempC': '',
    'mintempC': '',
    'cloudcover': '',
    'humidity': '',
    'sunHour': '',
    'HeatIndexC': '',
    'precipMM': '',
    'pressure': '',
    'windspeedKmph': ''
  };

  String _prediction = '';
  bool _isLoading = false;

  Future<void> _getPrediction() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://204e-34-106-62-28.ngrok-free.app/predict');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(_formData),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          _prediction = result['prediction'].toString();
        });
      } else {
        setState(() {
          _prediction = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _prediction = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildTextField(String label, String key) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: (value) {
        _formData[key] = double.tryParse(value!) ?? 0.0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Prediction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Max Temperature (°C)', 'maxtempC'),
              _buildTextField('Min Temperature (°C)', 'mintempC'),
              _buildTextField('Cloud Cover (%)', 'cloudcover'),
              _buildTextField('Humidity (%)', 'humidity'),
              _buildTextField('Sun Hours', 'sunHour'),
              _buildTextField('Heat Index (°C)', 'HeatIndexC'),
              _buildTextField('Precipitation (mm)', 'precipMM'),
              _buildTextField('Pressure (hPa)', 'pressure'),
              _buildTextField('Wind Speed (km/h)', 'windspeedKmph'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _getPrediction();
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Get Prediction'),
              ),
              SizedBox(height: 20),
              Text(
                _prediction.isEmpty ? 'Prediction will appear here' : _prediction,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
