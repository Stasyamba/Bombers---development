package com.vensella.bombers.delayedEvents;

import java.util.*;

import com.smartfoxserver.v2.entities.User;
import com.vensella.bombers.BombersGameProcess;
import com.vensella.bombers.gameEvents.GameEvent;

public class BombFactory extends AbstactDelayedEventFactory {
	
	public BombFactory(BombersGameProcess game, Timer timer) {
		super(game, timer);
		// TODO Auto-generated constructor stub
	}

	public Boolean createBomb(User owner, int bombType, int powerBonus, int x, int y)
	{
		if (bombType == 0)
		{
			Bomb bomb = new StandardBomb(owner, powerBonus, x, y) {
				
				@Override
				public void run() {
					BombersGameProcess game = getGame();
					GameEvent explosionEvent = this.getEvent();
					game.addGameEvent(explosionEvent);
					
				}
				
			};
			getTimer().schedule(bomb, bomb.getExplosionDelay());
			return true;
		}
		return false;
	}
	
}
