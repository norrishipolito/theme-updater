// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:archive/archive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final String title;
  final String link;
  final List<String> path;

  Item({required this.title, required this.link, required this.path});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      link: json['link'],
      path: json['path'] != null ? List<String>.from(json['path']) : <String>[],
    );
  }

  static Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/norrisasd/theme-updater/main/links.json'));

    if (response.statusCode == 200) {
      List<dynamic> jsonItems = jsonDecode(response.body);
      return jsonItems.map((jsonItem) => Item.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}

class UpdateButton extends StatefulWidget {
  final TextEditingController controller;

  UpdateButton({required this.controller});

  @override
  _UpdateButtonState createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  final _isLoading = ValueNotifier<bool>(false);
  final _progress = ValueNotifier<double>(0);
  final _log = ValueNotifier<String>('');
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    _isLoading.dispose();
    _progress.dispose();
    _log.dispose();
    super.dispose();
  }

  Future<void> _loadItems() async {
    items = await Item.fetchItems();
    setState(() {}); // Call setState to trigger a rebuild of the widget.
  }

  Future<void> _downloadAndExtractMaps() async {
    _isLoading.value = true;
    var dir = Directory(widget.controller.text);
    var zipPath = '${dir.path}/file.zip';
    var dio = Dio();
    Item? item = items.firstWhere((item) => item.title == 'Maps');
    var link = item.link;

    try {
      _log.value += 'Starting download... --- TITAS MAPS ZIP ---\n';
      await dio.download(
        link,
        zipPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress.value = received / total;
          }
        },
      );
      _log.value +=
          'Download completed.\nStarting extraction... TITAS MAPS ZIP\n';

      final bytes = File(zipPath).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = '${dir.path}/textures/map/${file.name}';
        if (file.isFile) {
          final data = file.content as List<int>;
          File(filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory(filename).createSync(recursive: true);
        }
      }
      _log.value += 'Extraction completed.\n';

      await File(zipPath).delete();
    } catch (e) {
      _log.value += 'Error: $e\n';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _downloadAndExtractDataEffects() async {
    _isLoading.value = true;
    var dir = Directory(widget.controller.text);
    var zipPath = '${dir.path}/file.zip';
    var dio = Dio();
    Item? item = items.firstWhere((item) => item.title == 'Data-Effects');
    var link = item.link;
    try {
      _log.value +=
          'Starting download... --- TITAS SKILLS DATA EFFECTS ZIP ---\n';
      await dio.download(
        link,
        zipPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress.value = received / total;
          }
        },
      );
      _log.value +=
          'Download completed.\nStarting extraction... TITAS SKILLS DATA EFFECTS ZIP\n';

      final bytes = File(zipPath).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = '${dir.path}/data/effect/${file.name}';
        if (file.isFile) {
          final data = file.content as List<int>;
          File(filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory(filename).createSync(recursive: true);
        }
      }
      _log.value += 'Extraction completed.\n';

      await File(zipPath).delete();
    } catch (e) {
      _log.value += 'Error: $e\n';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _downloadAndExtractTexturesEffect() async {
    _isLoading.value = true;
    var dir = Directory(widget.controller.text);
    var zipPath = '${dir.path}/file.zip';
    var dio = Dio();
    try {
      for (var effect in items) {
        _log.value +=
            'Starting download... --- TITAS ${effect.title} ZIP ---\n';

        await dio.download(
          effect.link,
          zipPath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              _progress.value = received / total;
            }
          },
        );

        _log.value +=
            'Download completed.\nStarting extraction... TITAS ${effect.title} ZIP\n';
        final bytes = File(zipPath).readAsBytesSync();
        final archive = ZipDecoder().decodeBytes(bytes);

        var paths = effect.path;

        for (var path in paths) {
          for (final file in archive) {
            final filename = '${dir.path}$path${file.name}';
            if (file.isFile) {
              final data = file.content as List<int>;
              File(filename)
                ..createSync(recursive: true)
                ..writeAsBytesSync(data);
            } else {
              Directory(filename).createSync(recursive: true);
            }
          }
        }
      }
      _log.value += 'Extraction completed.\n';

      await File(zipPath).delete();
    } catch (e) {
      _log.value += 'Error: $e\n';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _downloadAndExtractPet() async {
    _isLoading.value = true;
    var dir = Directory(widget.controller.text);
    var zipPath = '${dir.path}/file.zip';
    var dio = Dio();
    Item? item = items.firstWhere((item) => item.title == 'Pet');
    var link = item.link;
    try {
      _log.value += 'Starting download... --- TITAS PET ZIP ---\n';
      await dio.download(
        link,
        zipPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _progress.value = received / total;
          }
        },
      );
      _log.value +=
          'Download completed.\nStarting extraction... TITAS PET ZIP\n';

      final bytes = File(zipPath).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = '${dir.path}/textures/pet/${file.name}';
        if (file.isFile) {
          final data = file.content as List<int>;
          File(filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory(filename).createSync(recursive: true);
        }
      }

      // Delete the zip file

      _log.value += 'Extraction completed.\n';

      await File(zipPath).delete();
    } catch (e) {
      _log.value += 'Error: $e\n';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteGuardAndTransform() async {
    final dir = Directory("${widget.controller.text}/data/effect");
    if (await dir.exists()) {
      // List all files in the directory
      final files = dir.listSync(recursive: true, followLinks: false);
      _log.value += 'Starting to Delete Guard and Transform...\n';

      for (FileSystemEntity file in files) {
        // Check if the file name contains 'guard' or 'transform'
        if (file is File &&
            (file.path.contains('guard') || file.path.contains('transform'))) {
          // Delete the file
          _log.value += 'Deleting ${file.path}\n';
          await file.delete();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
            // Your existing TextFormField code...
            ),
        const SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: _isLoading,
          builder: (context, isLoading, child) {
            return isLoading
                ? ValueListenableBuilder<double>(
                    valueListenable: _progress,
                    builder: (context, progress, child) {
                      return LinearProgressIndicator(value: progress);
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<String>(
          valueListenable: _log,
          builder: (context, log, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: SizedBox(
                  height: 200, // Set the height of the container
                  child: SingleChildScrollView(
                    child: Text(
                      log,
                      style: GoogleFonts.inter(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, isLoading, child) {
              return SizedBox(
                height: 45,
                width: 170,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors
                              .grey; // Use the color you want for a disabled button
                        }
                        return Theme.of(context)
                            .colorScheme
                            .primary; // Use the default color for an enabled button
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          var controllerText = widget.controller.text;
                          var message = "";
                          if (controllerText == "") {
                            final snackBar = SnackBar(
                              content: const Text(
                                  'Path is empty, please select a path'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          try {
                            _isLoading.value = true;
                            // await _downloadAndExtractDataEffects();
                            await _downloadAndExtractTexturesEffect();
                            // await _downloadAndExtractMaps();
                            // await _downloadAndExtractPet();
                            // await deleteGuardAndTransform();
                            message = "Download and Extraction Completed";
                          } catch (e) {
                            message = e.toString();
                          } finally {
                            _isLoading.value = false;
                            final snackBar = SnackBar(
                              content: Text(message),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                  child: _isLoading.value
                      ? const SizedBox(
                          height: 20, // Set the height
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Update',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              );
            }),
      ],
    );
  }
}
