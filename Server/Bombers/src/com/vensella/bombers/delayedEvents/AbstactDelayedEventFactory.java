package com.vensella.bombers.delayedEvents;

import java.util.Timer;

import com.vensella.bombers.BombersGameProcess;

public abstract class AbstactDelayedEventFactory {
	
	private BombersGameProcess f_game;
	private Timer f_timer;
	
	public AbstactDelayedEventFactory(BombersGameProcess game, Timer timer)
	{
		f_game = game;
		f_timer = timer;
	}
	
	protected BombersGameProcess getGame()
	{
		return f_game;
	}
	
	protected Timer getTimer()
	{
		return f_timer;
	}
	
	
}
