// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../component/tcolor.dart';

// class ControlPage extends StatefulWidget {
//   const ControlPage({Key? key}) : super(key: key);

//   @override
//   State<ControlPage> createState() => _ControlPageState();
// }

// class _ControlPageState extends State<ControlPage> {
//   final String raspberryPiUrl = 'http://192.168.9.39:5900';

//   bool isRunning = false; // حالة الراسبيري باي: تشغيل أو إيقاف

//   Future<void> sendCommand(BuildContext context, String command) async {
//     final url = Uri.parse('$raspberryPiUrl/control?cmd=$command');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('✅ Command sent successfully: $command');
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Sent: $command')));
//       } else {
//         print('❌ Failed to send command');
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Failed to send command')));
//       }
//     } catch (e) {
//       print('⚠️ Error: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   Widget buildControlButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//     Color? backgroundColor,
//   }) {
//     return FloatingActionButton(
//       onPressed: onPressed,
//       backgroundColor: backgroundColor ?? Tcolor.buttonColor,
//       shape: const BeveledRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(50)),
//       ),
//       child: Icon(icon, color: Tcolor.background),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Robot Control')),
//       backgroundColor: Tcolor.background,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Forward
//             buildControlButton(
//               icon: Icons.arrow_upward,
//               onPressed: () => sendCommand(context, 'forward'),
//             ),
//             const SizedBox(height: 30),

//             // Left - Stop - Right
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildControlButton(
//                   icon: Icons.arrow_back,
//                   onPressed: () => sendCommand(context, 'left'),
//                 ),
//                 const SizedBox(width: 30),
//                 FloatingActionButton(
//                   onPressed: () => sendCommand(context, 'stop'),
//                   backgroundColor: Colors.red,
//                   shape: const CircleBorder(),
//                   child: const Text(
//                     "Stop",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(width: 30),
//                 buildControlButton(
//                   icon: Icons.arrow_forward,
//                   onPressed: () => sendCommand(context, 'right'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),

//             // Backward
//             buildControlButton(
//               icon: Icons.arrow_downward_rounded,
//               onPressed: () => sendCommand(context, 'backward'),
//             ),
//             const SizedBox(height: 40),

//             // Run/Stop Toggle Button
//             ElevatedButton.icon(
//               onPressed: () {
//                 setState(() {
//                   isRunning = !isRunning;
//                 });
//                 sendCommand(context, isRunning ? 'run' : 'shutdown');
//               },
//               icon: Icon(
//                 isRunning ? Icons.power_off : Icons.power,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 isRunning ? 'Stop Raspberry Pi' : 'Run Raspberry Pi',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isRunning ? Colors.red : Colors.green,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//firebase deploy --only functions
//firebase deploy --only functions --debug

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:plant_disease_application/component/tcolor.dart';

// class RobotControlScreen extends StatelessWidget {
//   const RobotControlScreen({super.key});

//   final String baseUrl =
//       'http://192.168.202.39:5002'; // استبدل بـ IP الراسبيري باي

//   Future<void> sendMoveCommand(String direction) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/move'),
//       headers: {'Content-Type': 'application/json'},
//       body: '{"direction":"$direction"}',
//     );
//     print('Move $direction: ${response.statusCode}');
//   }

//   Future<void> captureImage() async {
//     final response = await http.post(Uri.parse('$baseUrl/capture'));
//     print('Capture: ${response.statusCode}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Robot Controller"),
//         backgroundColor: Tcolor.buttonColor2, // لون مخصص مثل الواجهة السابقة
//       ),
//       backgroundColor: Tcolor.background, // خلفية موحدة
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Move Forward
//             FloatingActionButton(
//               onPressed: () => sendMoveCommand('forward'),
//               backgroundColor: Tcolor.buttonColor,
//               shape: const BeveledRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(50)),
//               ),
//               child: const Icon(Icons.arrow_upward, color: Colors.white),
//             ),
//             const SizedBox(height: 30),

//             // Left - Stop - Right
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 FloatingActionButton(
//                   onPressed: () => sendMoveCommand('left'),
//                   backgroundColor: Tcolor.buttonColor,
//                   shape: const BeveledRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: const Icon(Icons.arrow_back, color: Colors.white),
//                 ),
//                 const SizedBox(width: 30),
//                 FloatingActionButton(
//                   onPressed: () => sendMoveCommand('stop'),
//                   backgroundColor: Colors.red,
//                   shape: const CircleBorder(),
//                   child: const Text(
//                     "Stop",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(width: 30),
//                 FloatingActionButton(
//                   onPressed: () => sendMoveCommand('right'),
//                   backgroundColor: Tcolor.buttonColor,
//                   shape: const BeveledRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: const Icon(Icons.arrow_forward, color: Colors.white),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),

//             // Move Backward
//             FloatingActionButton(
//               onPressed: () => sendMoveCommand('backward'),
//               backgroundColor: Tcolor.buttonColor,
//               shape: const BeveledRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(50)),
//               ),
//               child: const Icon(Icons.arrow_downward, color: Colors.white),
//             ),

//             const SizedBox(height: 40),

//             // Capture Image Button
//             ElevatedButton.icon(
//               onPressed: captureImage,
//               icon: const Icon(Icons.camera_alt, color: Colors.white),
//               label: const Text(
//                 "Capture Image",
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Tcolor.buttonColor,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 15,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_disease_application/component/tcolor.dart';

class RobotControlScreen extends StatefulWidget {
  @override
  _RobotControlScreenState createState() => _RobotControlScreenState();
}

class _RobotControlScreenState extends State<RobotControlScreen> {
  final String raspberryPiIp = 'http://192.168.202.39:5002';
  bool showCamera = false;

  void sendCommand(String endpoint) async {
    final url = Uri.parse('$raspberryPiIp/$endpoint');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        print('Command sent: $endpoint');
      } else {
        print('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending command: $e');
    }
  }

  Widget buildControlButton(Widget child, String endpoint, {Color? color}) {
    return ElevatedButton(
      onPressed: () => sendCommand(endpoint),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Tcolor.buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        minimumSize: Size(140, 60),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.background,
      appBar: AppBar(
        title: Text(
          "Robot Controller",
          style: TextStyle(color: Tcolor.background),
        ),
        backgroundColor: Tcolor.buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (showCamera)
                Container(
                  height: 350,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "📷 Camera Stream",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ),
                ),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(
                    showCamera ? Icons.videocam_off : Icons.videocam,
                    color: Tcolor.background,
                  ),
                  label: Text(
                    showCamera ? "Hide Camera" : "Show Camera",
                    style: TextStyle(color: Tcolor.background),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Tcolor.buttonColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (!showCamera) sendCommand('start_camera');
                    setState(() {
                      showCamera = !showCamera;
                    });
                    if (showCamera == false) sendCommand('stop_camera');
                  },
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  buildControlButton(
                    Icon(Icons.arrow_upward, color: Colors.white),
                    'move?dir=forward',
                  ),
                  buildControlButton(
                    Icon(Icons.arrow_back, color: Colors.white),
                    'move?dir=left',
                  ),
                  buildControlButton(
                    Icon(Icons.arrow_downward, color: Colors.white),
                    'move?dir=backward',
                  ),

                  buildControlButton(
                    Icon(Icons.arrow_forward, color: Colors.white),
                    'move?dir=right',
                  ),

                  buildControlButton(
                    Text(
                      "🛑 Stop",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    'move?dir=stop',
                    color: Colors.red,
                  ),

                  buildControlButton(
                    Icon(Icons.camera_alt, color: Colors.white),
                    'capture',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
