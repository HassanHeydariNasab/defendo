How to win
==========

Introduction
-------------

There are 3 kinds of shooting weapons:
* a `laser` - large ranged, its range scales with upgrades
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Defendiloj/Pistoloj/Lasero/lasero.svg);
* a `cannon` - has rapid shooting rate, deals big damage
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Defendiloj/Pistoloj/Kanono/kanono.svg);
* a `shockwave` emitter (in the game's resources it is called an ```ondilo```) - slows down the mobs and damages them
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Defendiloj/Pistoloj/Ondilo/ondilo.svg);

... and one kind of non-shooting:
* a `mine` (in the game's resources it is called a ```bomb```) - damages nearby mobs when touched
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Defendiloj/Kugloj/Bombo/bombo.svg).

Every weapon damage scales with upgrades. Weapons instances must touch some slot in order to receive power. Shooting weapons must receive power in order to operate. ```mine```s work even without power, but when they are powered, they are upgraded for free. When more than one instance touches the same slot all of them don't receive power.

Every shot from any shooting weapon costs a fixed amount of credits.

We call that big circle in the bottom a `base`.
![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Defendiloj/Bazo/bazo.svg)

Every weapon instance costs a fixed amount of credits. Weapons instances can be merged into an upgraded version by putting them into a base. You must put instances exactly of the same kind into the base, otherwise it won't work, even if you remove all the instances of another kind. If this have happened, move everything out of the base and start merging from scratch. When an instance is inside the base you can tap a button to buy that kind of weapon to upgrade the one placed over base by 1.

There are 4 kinds of mobs:
* the small and fast ones
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Malamikoj/malamiko_0.svg)
* the big and slow ones
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Malamikoj/malamiko_1.svg)
* the slow and invincible to ```cannon``` and ```mines```, but vulnerable to ```shockwave``` and ```laser```
  ![](https://cdn.rawgit.com/HassanHeydariNasab/defendo/master/Malamikoj/malamiko_2.svg)

The current game design is somehow disbalanced. I have found a winning strategy.

What makes this strategy work is:
* every shot costs a fixed amount of credits, disrespect to the damage. So larger the upgrade level of a weapon, cheaper its damage to mobs, cheaper the damage to mobs - cheaper the kill, cheaper the kill - more profit, more profit - more upgrades can be bought. It is a positive feedback loop.
* one high-level weapon is preferred over multiple equivalent and even more powerful. It is because ```n``` weapons will shoot simultaneously consuming ```n*shot_cost``` credits, but will deal presumably the same damage. So more weapons you have - more the costs. You need to keep count of weapons at minimum to reduce the costs. If you have multiple weapons their ranges mustn't overlap to reduce costs.
So ...

The strategy
------------

1. Start the game
2. Buy a `cannon` and place it over the top slot.
3. Buy one more `cannon` and place it over the base.
4. Look at money and start buying more `cannon`s, keeping enough money to pay for count of shots enough to kill the nearest mob.
5. When the enemies are out of range, move the weapon over the base to merge the upgrades into it. Do it as frequently as you can. Remember, more upgrades the weapon have - more money you will get to spend on upgrades.

6. Buy some `mine`s and put them over all the empty slots. They will be upgraded for free with time.
7. Periodically merge all the `mine`s into powerfull ones and place them into a place where they cannot be reached by low-level mobs. It's your "insurance" for the case your system is unable to destroy a powerful mob. In fact it is useful only in beginning of the game when you have not accumulated high-level weapons.

8. Then buy 2 `shockwave`s and a `laser`. Empty top slots occupied with `mine`s and put the purchases there.
9. Upgrade the weapons.
10. When your system can easily defeat any enemy you can buy a network upgrade if you want to the enemies to get into the range faster. In fact it is more profitable to buy weapons upgrade, if you are wiling to spend your time.
11. To get more profit you can disable cannons when mobs are invincible to them.
![](https://user-images.githubusercontent.com/240344/32455192-68da2f54-c319-11e7-851a-de655a3bc62f.png)
