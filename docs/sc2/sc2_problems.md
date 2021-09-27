# SC2 Live Preview Problems

The Dart program I'm using can't read SC2 frames properly at 30fps.  It's like that some of the SC2 frames have broken images.

![sc2 frame problem](images/sc2_frame_problem.png)

When displayed on the Flutter screen, some of the frames are not
displaying properly.  It seems like `gaplessPlayback` can't compensate
enough.  

With the Z1, the stream is smooth.

At 5fps, 1 out of the 300 frames I tested was not readable, which is
likely a usable ratio and likely something the software can compensate for.

![sc2 broken frame](images/corrupted_frame_sc2_5fps_1_broken_out_of_300.png)

![sc2 5fps](images/sc2_5fps_working.gif)

[Link to 1 minute test video](https://youtu.be/3P-YKr1dzQU).