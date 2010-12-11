package com.vensella.bombers.dynamicObjects;

import com.smartfoxserver.v2.entities.User;
import com.vensella.bombers.gameEvents.GameEvent;

public class DynamicObject {
	
	protected boolean f_canGo;
	protected int f_type;
	
	public DynamicObject()
	{
		
	}
	
	public boolean getCanGo()
	{
		return f_canGo;
	}
	
	public int getTypeId()
	{
		return f_type;
	}
	
	public GameEvent activateEvent(final User user, final int x, final int y)
	{
		return null;
	}
	
}
