package com.vensella.bombers.dynamicObjects.bonuses;

import java.util.ArrayList;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.vensella.bombers.BombersGameProcess;
import com.vensella.bombers.DynamicGameMap;
import com.vensella.bombers.UserGameParams;
import com.vensella.bombers.dynamicObjects.*;
import com.vensella.bombers.gameEvents.GameEvent;

public class BombCountBonus extends DynamicObject {
	
	public BombCountBonus()
	{
		super.f_canGo = true;
		super.f_type = DynamicObjectFactory.BONUS_ADD_BOMB;
	}
	
	@Override
	public GameEvent activateEvent(final User user, final int x, final int y)
	{
		final int bonusType = super.f_type;
		final DynamicObject self = this;
		return new GameEvent() {
			
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				if (game.getDynamicObject(x, y) != self)
					return;
				game.removeDynamicObject(self);
				
				UserGameParams ownerParams = getUserGameParams(user, playerStates);
				ownerParams.releaseBomb();
				
				SFSObject params = new SFSObject();
				params.putInt("user_id", user.getId());
				params.putInt("bonus_type", bonusType);
				params.putInt("bonus_x", x);
				params.putInt("bonus_y", y);
				game.send("bonus_taken", params, game.getParentRoom().getPlayersList());
			}
		};
	}
	
}
