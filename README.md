# game-engines-midterm

# Controls
Player 1
WASD - Move
Z - Jump
X - Shoot

Player 2
Arrow Keys - Move
, - Jump
. - Shoot

# Explanation
## Singleton
Global script keeps track of the player's score and level, it is also a singleton, accessed anytime something would contribute to your score through the add_score() method.

BubbleFactory is also a singleton, explained below.

I've explained singletons so many times now and how Godot has it's autoload scripts and whatever. My 'Implementation' is clicking a few buttons and adding global.gd as an autoload. However just to be thorough, here is some sample code for a singleton in Unity

```C#
private class ClassName : MonoBehaviour
{
  ClassName instance;

  void Awake()
  {
    if (instance == null)
    {
      instance = this;
    }
    else Destroy(this)
  }
}
```



## Factory
BubbleFactory class handles spawning bubbles with a few parameters you have to pass in. It's a autoload singleton so it can be accessed from anywhere.

I planned on creating a EnemyFactory that handles spawning enemies, however I didn't get more than 1 enemy complete, and Bubble Bobble wouldn't even use one anyways. Each level has predefined enemies and spawn points so if you were going for a perfect recreation I don't think a Factory would be the play since you could just have prefabs in the scenes already.

If I had more time I would have created pickups that give you score, and use a factory for that. Bubble bobble has a lot of different pickups, all of which have a different sprite and a total score they award. In hindsight I would have worked on this first to have a good factory demonstration instead of making the Enemy Bubbling mechanic, popping, etc. 
