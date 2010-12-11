package com.vensella.bombers.delayedEvents;

import java.util.TimerTask;

import com.smartfoxserver.v2.entities.User;
import com.vensella.bombers.gameEvents.GameEvent;

public abstract class Bomb extends TimerTask {
	
	private User f_owner;
	private int f_powerBonus;
	private int f_x;
	private int f_y;
	
	public Bomb(User owner, int powerBonus, int x, int y)
	{
		f_owner = owner;
		f_powerBonus = powerBonus;
		f_x = x;
		f_y = y;
	}
	
	public abstract long getExplosionDelay();
	public abstract long getExplosionTime();
	public abstract GameEvent getEvent();
	
	protected User getOnwer() 
	{
		return f_owner;
	}
	
	protected int getPowerBonus()
	{
		return f_powerBonus;
	}
	
	protected int getX()
	{
		return f_x;
	}
	
	protected int getY() 
	{
		return f_y;
	}
	
}
