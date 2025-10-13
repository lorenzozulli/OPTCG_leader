import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:optcgcounter_flutter/entities/leader.dart';
import 'package:optcgcounter_flutter/pages/leaderdetails.dart';
import 'package:path_provider/path_provider.dart';

class LeaderSelection extends StatefulWidget {
  const LeaderSelection ({super.key});

  @override
  State<LeaderSelection> createState() => _LeaderSelectionState();
}

class _LeaderSelectionState extends State<LeaderSelection> {
  final List<Leader> _allLeaders = <Leader>[];
  final SearchController _searchController = SearchController();
  List<Leader> _filteredLeaders = <Leader>[];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/optcgcounter_flutter/optcgcounter_flutter/assets/url.txt');
  }

  Future<List<Leader>> fetchLeaders() async {
    final file = await _localFile;
    String url = await file.readAsString();
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> decodedJson = json.decode(response.body);
      final List<dynamic> cardDataList = decodedJson['data'];
      return cardDataList.map((json) => Leader.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }

  @override
  void initState(){
    super.initState();
    fetchLeaders().then((value){
      setState((){
        _allLeaders.addAll(value);
        _filteredLeaders.addAll(value);
      });
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredLeaders = List.from(_allLeaders);
      } else {
        _filteredLeaders = _allLeaders.where((leader) {
          return leader.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index){
              if (_filteredLeaders.isEmpty) return const Center(child: Text("No Leader found."));

              return Card(
                elevation: 10,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap:() {
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => Leaderdetails(leader: _filteredLeaders[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.network(
                          _filteredLeaders[index].images.imageEn,
                          width: 50,
                          height: 100
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _filteredLeaders[index].name,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              _filteredLeaders[index].id,
                              style: TextStyle(
                                color: Colors.grey.shade700
                              ),
                            ),
                            Text(
                              _filteredLeaders[index].power,
                              style: TextStyle(
                                color: Colors.grey.shade700
                              ), 
                            ),
                            Text(
                              "(${_filteredLeaders[index].life}) LIFE",
                              style: TextStyle(
                                  color: Colors.grey.shade700
                              ),
                            ),
                          ],              
                        ),
                      ],
                    )
                  ),
                )
              );
            },
            itemCount: _filteredLeaders.length,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
              searchController: _searchController,
              viewHintText: 'Search leaders...',

              builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                hintText: 'Search leaders...',
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
              );
            },
              
            suggestionsBuilder: (context, controller) async {
              final String query = controller.text.toLowerCase();
              if (query.isEmpty) {
                return List.empty();
              } else {
                final filteredSuggestions = _allLeaders.where((leader) {
                  return leader.name.toLowerCase().contains(query) || leader.id.toLowerCase().contains(query);
                }).toList();

                return filteredSuggestions.map((leader) {
                  return ListTile(
                    title: Text('${leader.name}, ${leader.id}'),
                    onTap: () {
                      controller.closeView(leader.name);
                      _searchController.text = leader.name;
                      _onSearchChanged();
                    },
                  );
                }).toList();
              }
            },
          ),
        )
      ],
    );
  }
}