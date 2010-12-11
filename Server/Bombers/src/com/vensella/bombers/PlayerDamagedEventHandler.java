package com.vensella.bombers;

import com.smartfoxserver.v2.annotations.Instantiation;
import com.smartfoxserver.v2.annotations.Instantiation.InstantiationMode;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


@Instantiation(InstantiationMode.SINGLE_INSTANCE)
public class PlayerDamagedEventHandler extends BaseClientRequestHandler {
	
	@Override
	public void handleClientRequest(User user, ISFSObject params)
	{
		BombersGameProcess game = (BombersGameProcess)getParentExtension();
		int damage = params.getInt("damage");
		boolean isDead = params.getBool("is_dead");
		//int effect = params.getInt("effect");
		int effect = 0;
		game.damageUser(user, damage, effect, isDead);
	}
	
}
