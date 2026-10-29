# Final Project Check In

In order to connect a controller to a character, you have to press the button labelled Start below.

# Controls
### Keyboard
Left - A
Right - D
Bubble - S
Jump - W
Start - LShift
### Controller
Movement - Left Stick
Bubble - West Button
Jump - South Button
Start - Start Button

# Explanation
## Singleton
The GameManager is responsible for keeping track of the current stage, loading, and unloading stages.
It’s the GameManager it manages the game’s flow
<img width="839" height="435" alt="image" src="https://github.com/user-attachments/assets/847513d6-d8d5-41bc-b9b4-a0c065bed687" />



InputHandler is also a singleton, explained below.

I've explained singletons so many times now and how Godot has it's autoload scripts and whatever. My 'Implementation' is clicking a few buttons and adding global.gd as an autoload. However just to be thorough, here is some sample code for a singleton in Unity

```C#
private class ClassName : MonoBehaviour
{
  public static ClassName instance;

  void Awake()
  {
    if (instance == null)
    {
      instance = this;
    }
    else Destroy(this)
  }<img width="550" height="262" alt="2026_10_27-08:58:12" src="https://github.com/user-attachments/assets/0499ff83-e2a2-47bc-87d2-f035e1665304" />

}
```


## Factory
The pickups that spawn all the time are the perfect use for a factory. Every pickup is basically the same, it has a sprite and a point value. In my implementation calling PickupFactory.spawn_random_pickup() will spawn a random pickup from a predefined list.

<img width="1138" height="645" alt="2026_10_26-23:49:42" src="https://github.com/user-attachments/assets/a753b9c1-9110-4094-869c-fdcf4256101b" />


## Command Pattern
Instead of calling a function directly, a function is stored in an object that can be called with execute(). They provide a layer of abstraction between the sender and receiver. The sender just has to worry about sending the message at the right time, and the receiver only has to worry about what happens when it’s executed. 

While not the full “Command pattern design” I used important elements of it when adding proper multiplayer support. Decoupled Input Handling and controlling the player. Achieved by having separate input events on the PlayerID. InputHandler handles inputs and calls input_signals on the PlayerID

<img width="550" height="262" alt="2026_10_27-08:58:12" src="https://github.com/user-attachments/assets/b76ef6ac-56fa-44e7-a4c5-435bf8523f76" />
<img width="724" height="565" alt="2026_10_27-08:57:34" src="https://github.com/user-attachments/assets/6e87247f-3f2b-4b84-b170-693cd6454fa0" />
<img width="1239" height="219" alt="2026_10_27-09:02:02" src="https://github.com/user-attachments/assets/fe007dbf-732d-4f1c-9fcd-78148c4cf391" />
<img width="845" height="178" alt="2026_10_27-08:57:50" src="https://github.com/user-attachments/assets/f91eb03e-a071-4e0a-b30d-d209067e1650" />

<img width="1342" height="551" alt="2026_10_29-17:13:07" src="https://github.com/user-attachments/assets/8d5a8d20-7733-4258-8adc-710a15322d11" />


## Plugin
I made a scene builder plugin
(this was for lab assignment 1)

Press Alt+Shift+2 to create a 2D scene
Press Alt+Shift+3 to create a 3D scene

It’s not a DLL (idk if this counts) (plus I probably should make a dll just so I know how and can do it cause i totally forgot to do the in class assignment from last week’s lecture.)

<img width="222" height="47" alt="2026_10_26-23:54:56" src="https://github.com/user-attachments/assets/efacb3f6-a84f-4f5f-826d-dcab38a3f4bc" />
<img width="513" height="494" alt="2026_10_26-235648-ezgif com-video-to-gif-converter" src="https://github.com/user-attachments/assets/234dece3-86b8-49d9-83de-5db10ec4f49a" />
