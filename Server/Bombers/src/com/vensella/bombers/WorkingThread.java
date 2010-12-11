package com.vensella.bombers;


public class WorkingThread implements Runnable {

	private BombersGameProcess game;

	
	public WorkingThread(BombersGameProcess game)
	{
		this.game = game;
	}
	
	@Override
	public void run() {
		try
		{
			while (game.isGameStarted())
			{

			}
		}
		catch (Exception e)
		{
			game.trace(">>>>>>>>>>>>>>>> Something bad in working thread! <<<<<<<<<<<<<<<<<<<");
			game.trace((Object[])e.getStackTrace());
		}
	}

}
