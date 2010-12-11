package com.vensella.bombers;

import com.smartfoxserver.v2.annotations.Instantiation;
import com.smartfoxserver.v2.annotations.Instantiation.InstantiationMode;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

@Instantiation(InstantiationMode.SINGLE_INSTANCE)
public class ReadyChangedEventHandler extends BaseClientRequestHandler {
	
	@Override
	public void handleClientRequest(User user, ISFSObject params)
	{
		BombersGameProcess game = (BombersGameProcess)getParentExtension();
		if (game == null)
		{
			trace ("WTF????");
			return;
		}
		if (!game.isGameStartPending())
		{
			Boolean isReady = params.getBool("is_ready");
			game.userReady(user, isReady);
		}
	}
	
}
