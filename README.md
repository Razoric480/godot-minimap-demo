# Godot Minimap Demo #

By [Francois Belair](https://twitter.com/Razoric480)

This project was inspired by a question asked on the GDQuest discord on how to recreate the effect as in [this tutorial]((https://unitycodemonkey.com/video.php?v=kWhOMJMihC0)) for Unity by [CodeMonkey](https://unitycodemonkey.com), where a simpler and more limited world representation is recreated in a circular minimap. The art in this project has been taken from those project files, though the game was not coded - just some basic movement to show the minimap.

It is not a tutorial persay, but an explanation with a demo.

Whereas in Unity you can simply tag game objects to be rendered as part of a set of render layers or another as in the tutorial, the rendering architecture in Godot is different. CanvasLayers simulate something similar, but a CanvasLayer child does not move with the parent like in Unity. As a result, the workaround is *cloning*.

Our minimap is its own little world, the same size as the main world, and contain approximations of what objects are in the main world. Those proxies keep track of their main-world masters' positions, and move in this sub-world accordingly. In this example, position is the only thing that matters, but rotation could also be mirrored.

## Viewport ##

A [Viewport](https://docs.godotengine.org/en/latest/classes/class_viewport.html) in Godot is used to create the subworld. Its size is the same as the window size, and this viewport is added to its own "Map" group for easy referral. Then, any object that should add itself - in our case, the player, the enemies, and the tent spawners - can call the minimap viewport's `add_sprite_clone`. Those clones are of type `Proxy`, which updates its global_position to its master's global_position every frame. The player also calls `add_camera_clone` since that is where the camera lives, and we add a camera to our viewport.

While they are siblings instead of children, we can still assign a custom sprite, different scaling, or - in the camera's case - a different zoom level. The end result is a minimap that shows more of the world than the screen, and is made up of simpler sprites.

## Display a circular minimap ##

The final step is to then display our minimap. On a separate GUI layer, this was accomplished using a combination of TextureRect and Light2D. The TextureRect that represents our minimap is assigned a Viewport Texture, which points to the Minimap viewport. Its `expand` property is on, it is flipped vertically (y-down) and its stretch mode is set to `Keep Aspect Covered`, which keeps its aspect ratio to display properly, but allows the image to be smaller than its full size. It's `size` is set to 200,200, and the anchors arranged to put it in the bottom right of the screen.

To mask it as a circle, a Light2D object is added, with its mode set to `mix`, with a texture of a white circle with a transparent background. Its sized and positioned to overlap exactly over our viewport texture.

The viewport texture is finally assigned a `CanvasItemShader`, with the Light Mode set to `Light Only`. This completes the circular masked effect. A ring texture is added on top to give it a cleaner look and mask any aliasing issues.