package com.vensella.bombers.gameEvents;

import java.util.ArrayList;

import com.smartfoxserver.v2.entities.User;
import com.vensella.bombers.BombersGameProcess;
import com.vensella.bombers.DynamicGameMap;
import com.vensella.bombers.UserGameParams;

public abstract class GameEvent {
	
	protected UserGameParams getUserGameParams(User user, ArrayList<UserGameParams> playerStates)
	{
		for (int i = 0; i < playerStates.size(); ++i)
			if (playerStates.get(i).getUser() == user)
				return playerStates.get(i);
		return null;
	}
	
	public abstract void applyOnGame(BombersGameProcess game, DynamicGameMap gf, ArrayList<UserGameParams> playerStates);
	
}
