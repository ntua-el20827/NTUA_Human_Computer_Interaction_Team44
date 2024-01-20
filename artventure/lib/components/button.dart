import 'package:flutter/material.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  Button({Key? key, required this.label, required this.press})
      : super(key: key);

  // Create an instance of AudioPlayer
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound() {
    // Every time the button is pressed we want to play the sound of the "note"
    _audioPlayer.play(AssetSource('sound/note.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.8,
      height: 55,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          // Play the "note" and call the given function
          _playSound();
          press();
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
