import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/module/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Sheikh Nasser Al-Qatami",
        artistName: "Nasser Al-Qatami",
        albumArtImagePath: "assets/images/Nasser Al-Qatami.jpg",
        audioPath: "Sheikh Nasser Al-Qatami.mp3",
    ),
    Song(
        songName: "Sheikh Yasser Al-Dosari",
        artistName: "Yasser Al-Dosari",
        albumArtImagePath: "assets/images/Yasser Al-Dosari.jpg",

        audioPath: "audio/Sheikh Yasser Al-Dosari.mp3",
    ),
    Song(
      songName: "Sheikh Maher Al-Muaiqly",
      artistName: "Maher Al-Muaiqly",
      albumArtImagePath: "assets/images/Maher Al-Muaiqly.jpg",
      audioPath: "assets/audio/Sheikh Maher Al-Muaiqly.mp3",
    ),
  ];
  // current song playing index
int? _currentSongIndex;

/*
    AUDIO PLAYER
 */
  // audio palyer
  final AudioPlayer _audioPlayer = AudioPlayer();
  // durations
  final Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  // constructor
  PlaylistProvider(){
    listenToDuration();
  }
  // initialliy not playing
  bool _isPlaying = false;
  // play the song
  void play() async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }
  // pause current song
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }
  // resume playing
  void resum() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }
  // pause or resume
   void pauseOrResume() async{
    if (_isPlaying){
      pause();
    }else{
      resum();
    }
    notifyListeners();
   }
  // seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }
  // play next song
  void playNextSong(){
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playlist.length -1){
        //go to the next song if it's not last song
        currentSongIndex = _currentSongIndex! +1;
      }else{
        //if it's the last song , loop back to first song
        currentSongIndex = 0;
      }
    }
  }
  // play previous song
  void playPreviousSong() async{
    if(_currentDuration.inSeconds > 2){
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, go to previous song
    else{
      if (_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      }else{
        //if it's the first song, loop back to last song
        currentSongIndex = _playlist.length -1;
      }
    }
  }
  // list to duration
  void listenToDuration(){
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for curent duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _totalDuration = newPosition;
      notifyListeners();
    });
    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  // dispose audio player


/*
    G E T T E R S
 */
List<Song> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;

set currentSongIndex(int? newIndex){
  // update current song index
  _currentSongIndex = newIndex;
  if (newIndex != null){
    play();// play the song at new index
  }
  // update UI
  notifyListeners();
}
}
