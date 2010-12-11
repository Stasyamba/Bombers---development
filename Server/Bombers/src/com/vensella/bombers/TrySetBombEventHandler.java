
package com.vensella.bombers;

import com.smartfoxserver.v2.annotations.Instantiation;
import com.smartfoxserver.v2.annotations.Instantiation.InstantiationMode;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

@Instantiation(InstantiationMode.SINGLE_INSTANCE)

public class TrySetBombEventHandler extends BaseClientRequestHandler {
	
	@Override
	public void handleClientRequest(User user, ISFSObject params)
	{
		BombersGameProcess game = (BombersGameProcess)getParentExtension();
		int bombType = params.getInt("bomb_type");
		int bombX = params.getInt("bomb_x");
		int bombY = params.getInt("bomb_y");
		
		game.trySetBomb(user, bombType, bombX, bombY);
	}
	
}
