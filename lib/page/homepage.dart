import 'package:flutter/material.dart';
import 'package:musicapp/components/my_drawer.dart';
import 'package:musicapp/module/playlist_provider.dart';
import 'package:musicapp/module/song.dart';
import 'package:musicapp/page/song_page.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}
class _homepageState extends State<homepage>{
 late final dynamic playlistProvider;
 @override
 void initState(){
   super.initState();
   playlistProvider= Provider.of<PlaylistProvider>(context, listen: false);
 }

 void goToSong(int songIndex){
   playlistProvider.currentSongIndex= songIndex;
   Navigator.push(context, MaterialPageRoute(builder: (context) =>const SongPage(),),
   );
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text(" P L A Y    L I S T "),),
        drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context,value,child){
          final List<Song> playlist =  value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context,index){
              final Song song = playlist[index];

              return ListTile(
                title:Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),

    );
  }
}

