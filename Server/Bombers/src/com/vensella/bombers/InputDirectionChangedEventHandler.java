package com.vensella.bombers;

import com.smartfoxserver.v2.annotations.Instantiation;
import com.smartfoxserver.v2.annotations.Instantiation.InstantiationMode;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

@Instantiation(InstantiationMode.SINGLE_INSTANCE)
public class InputDirectionChangedEventHandler extends BaseClientRequestHandler {
	
	@Override
	public void handleClientRequest(User user, ISFSObject params)
	{
		BombersGameProcess game = (BombersGameProcess)getParentExtension();
		params.putInt("user_id", user.getId());
		send("input_direction_changed", params, game.getParentRoom().getPlayersList());
	}
	
}
