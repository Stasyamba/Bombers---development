package com.vensella.bombers.delayedEvents;

import java.util.ArrayList;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.vensella.bombers.BombersGameProcess;
import com.vensella.bombers.DynamicGameMap;
import com.vensella.bombers.UserGameParams;
import com.vensella.bombers.gameEvents.GameEvent;

public abstract class StandardBomb extends Bomb {

	private static final int BASE_POWER = 2;
	
	public StandardBomb(User owner, int powerBonus, int x, int y) {
		super(owner, powerBonus, x, y);
		// TODO Auto-generated constructor stub
	}

	@Override
	public long getExplosionDelay() {
		return 2000;
	}

	@Override
	public long getExplosionTime() {
		return 500;
	}
	
	public GameEvent getEvent()
	{
		final User owner = getOnwer();
		
		return new GameEvent() {

			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				int x = getX();
				int y = getY();
				game.trace("Bomb exploded at: " + x + ", " + y + "; Power = " + (BASE_POWER + getPowerBonus()));
				
				//Release bomb
				getUserGameParams(owner, playerStates).releaseBomb();
				
				//Destroy walls
				//gf.setObjectTypeAt(x, y, DynamicGameMap.ObjectType.EMPTY);
				game.removeDynamicObject(x, y);
				int power = BASE_POWER + getPowerBonus();
			
				//Up
				for (int i = 1; i <= power; ++i)
				{
					if (gf.getObjectTypeAt(x, y - i) == DynamicGameMap.ObjectType.WALL)
					{
						game.destroyWallAt(x, y - i);
						break;
					}
					if (gf.getObjectTypeAt(x, y - i) == DynamicGameMap.ObjectType.STRONG_WALL)
					{
						break;
					}
				}
				//Right
				for (int i = 1; i <= power; ++i)
				{
					if (gf.getObjectTypeAt(x + i, y) == DynamicGameMap.ObjectType.WALL)
					{
						game.destroyWallAt(x + i, y);
						break;
					}
					if (gf.getObjectTypeAt(x + i, y) == DynamicGameMap.ObjectType.STRONG_WALL)
					{
						break;
					}
				}
				//Down
				for (int i = 1; i <= power; ++i)
				{
					if (gf.getObjectTypeAt(x, y + i) == DynamicGameMap.ObjectType.WALL)
					{
						game.destroyWallAt(x, y + i);
						break;
					}
					if (gf.getObjectTypeAt(x, y + i) == DynamicGameMap.ObjectType.STRONG_WALL)
					{
						break;
					}
				}
				//Left
				for (int i = 1; i <= power; ++i)
				{
					if (gf.getObjectTypeAt(x - i, y) == DynamicGameMap.ObjectType.WALL)
					{
						game.destroyWallAt(x - i, y);
						break;
					}
					if (gf.getObjectTypeAt(x - i, y) == DynamicGameMap.ObjectType.STRONG_WALL)
					{
						break;
					}
				}
				
				
				//Send message
				SFSObject params = new SFSObject();
				
				params.putInt("bomb_power_bonus", 0);
				params.putInt("bomb_x", x);
				params.putInt("bomb_y", y);
				
				game.send("bomb_exploded", params, game.getParentRoom().getPlayersList());
			}
		};
		
	}

}
