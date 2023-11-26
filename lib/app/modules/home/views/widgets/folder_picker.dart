import 'package:files_updater/app/modules/home/views/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class FolderPicker extends StatelessWidget {
  const FolderPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 30), // Add margin to left and right
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
          children: <Widget>[
            Text('Folder Path',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 10), // Add some spacing
            Theme(
              data: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.white,
              ),
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 600), // Set maximum width
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  children: [
                    TextFormField(
                      controller: _controller,
                      readOnly: true,
                      onTap: () async {
                        String? path =
                            await FilePicker.platform.getDirectoryPath();
                        if (path != null) {
                          _controller.text =
                              path; // Set the text of the TextFormField
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Select a Folder',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Add some spacing
                    UpdateButton(
                      controller: _controller,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
