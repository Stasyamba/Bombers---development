
package com.vensella.bombers;

import java.util.*;
import java.util.concurrent.LinkedBlockingQueue;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.SFSExtension;

import com.vensella.bombers.delayedEvents.BombFactory;
import com.vensella.bombers.dynamicObjects.*;
import com.vensella.bombers.gameEvents.GameEvent;


public class BombersGameProcess extends SFSExtension {
	
	/*
	 * Time waiting when 2 or more users ready to start the game. If someone disconnect or join in this period - countdown stops.
	 */
	private static final long C_WaitingTime = 6000;
	private Timer f_waitingTimer = null;
	/*
	 * Time waiting before game starts.
	 */
	private static final long C_TimeBeforeStart = 3000;
	private Timer f_beforeStartTimer = null;
	/*
	 * Timer for delayed events
	 */
	private Timer f_delayedEventsTimer = null;
	
	private Boolean f_isGameRunning = false;
	private Boolean f_isGameStarted = false;
	private Boolean f_isPendingGameStart = false;
	
	private Boolean f_canLaunchGame = true;
	
	private ArrayList<User> f_readyUsers;
	private ArrayList<UserGameParams> f_playerStates;
	
	private DynamicGameMap f_gameField;
	private DynamicObject[] f_dynamicObjects;
	
	private BombFactory f_bombFactory;
	private DynamicObjectFactory f_dynamicObjectFactory;
	
	private LinkedBlockingQueue<GameEvent> f_eventQueue;
	private Thread f_thread;
	
	//Constructors and destructors
	
	@Override
	public void init()
	{	
		f_readyUsers = new ArrayList<User>();
		f_eventQueue = new LinkedBlockingQueue<GameEvent>();
		//trace_debug("GameProcessExtension init()");
		trace("Bombers init()");
		
		
		//addRequestHandler("reset", ResetEventHandler.class);
		//addRequestHandler("ready", ReadyEventHandler.class);
		//addRequestHandler("move_event", MoveEventHandler.class);
		
		addRequestHandler("ping", PingEventHandler.class);
		
		addRequestHandler("ready_changed", ReadyChangedEventHandler.class);
		
		addRequestHandler("input_direction_changed", InputDirectionChangedEventHandler.class);
		addRequestHandler("view_direction_changed", ViewDirectionChangedEventHandler.class);
		
		addRequestHandler("try_set_bomb", TrySetBombEventHandler.class);
		
		addRequestHandler("player_damaged", PlayerDamagedEventHandler.class);
		
		addRequestHandler("activate_dynamic_object", DynamicObjectActivatedEventHandler.class);
		
		
		
		//addRequestHandler("set_bomb", null);
		//addRequestHandler("get_bonus", null);
		//3_seconds_to_start
		
		//addEventHandler(SFSEventType., theClass)
		addEventHandler(SFSEventType.USER_LEAVE_ROOM, OnUserGoneHandler.class);
		addEventHandler(SFSEventType.USER_DISCONNECT, OnUserGoneHandler.class);
		//addEventHandler(SFSEventType.SPECTATOR_TO_PLAYER, null);
		
		
	}

	@Override
	public void destroy()
	{
		super.destroy();
		stopDispatching();
		trace("Bombers destroy()");
	}
	
	public void stopDispatching()
	{
		f_isGameRunning = false;
		addGameEvent(new GameEvent() {
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				// Dummy event to wake up thread
			}
		});
		try
		{
			//Stop events dispatching
			if (f_thread != null  && f_thread.isAlive())
				f_thread.join();
			//Destroy factories
			//Destroy timers
			if (f_delayedEventsTimer != null)
				f_delayedEventsTimer.cancel();
		}
		catch(Exception e)
		{
			trace(e.getMessage());
			trace((Object[])e.getStackTrace());
		}		
	}
	
	//System properties
	
//	public Timer getDelayedEventTimer()
//	{
//		return f_delayedEventsTimer;
//	}
	
	//DB access
	
	protected UserGameParams loadUserParams(User user)
	{
		return new UserGameParams(user);
	}
	
	//State checkers
	
	public Boolean isGameRunning()
	{
		return f_isGameRunning;
	}
	
	public Boolean isGameStarted()
	{
		return f_isGameStarted;
	}
	
	public Boolean isGameStartPending()
	{
		return f_isPendingGameStart;
	}
	
	public Boolean isUserReady(User user)
	{
		return f_readyUsers.contains(user);
	}
	
	//Dynamic object dispatching
	
	public void addDynamicObject(int x, int y, DynamicObject o)
	{
		if (getDynamicObject(x, y) == null)
		{
			f_dynamicObjects[f_gameField.getWidth() * y + x] = o;
		}
	}
	
	public DynamicObject getDynamicObject(int x, int y, Class<? extends DynamicObject> type)
	{
		DynamicObject o = getDynamicObject(x, y);
		if (o != null && o.getClass() == type)
			return o;
		else
			return null;
	}
	
	public DynamicObject getDynamicObject(int x, int y)
	{
		return f_dynamicObjects[f_gameField.getWidth() * y + x];
	}
	
	public void removeDynamicObject(int x, int y, DynamicObject o)
	{
		if (f_dynamicObjects[f_gameField.getWidth() * y + x] == o)
			f_dynamicObjects[f_gameField.getWidth() * y + x] = null;
	}
	
	public void removeDynamicObject(int x, int y)
	{
		f_dynamicObjects[f_gameField.getWidth() * y + x] = null;
	}
	
	public void removeDynamicObject(DynamicObject o)
	{
		for (int i = 0; i < f_dynamicObjects.length; ++i)
		{
			if (f_dynamicObjects[i] == o)
			{
				f_dynamicObjects[i] = null;
				break;
			}
		}
	}
	
	public void activateDynamicObject(User user, int x, int y)
	{
		DynamicObject o = getDynamicObject(x, y);
		if (o != null)
		{
			addGameEvent(o.activateEvent(user, x, y));
		}
	}
	
	//Boundary methods
	
	public void userReady(User user, Boolean isReady)
	{
		if (isGameStartPending() || isGameStarted())
		{
			trace("WARN: Ready changed in incorrect state");
			return;
		}

		trace("User " + user.getId() + " ready = " + isReady);
		if (isReady && !f_readyUsers.contains(user))
		{
			synchronized (this) {
				if (isGameStartPending() || isGameStarted())
				{
					trace("WARN: Ready changed in incorrect state");
					return;
				}
				f_readyUsers.add(user);
//				if (f_waitingTimer != null)
//				{
//					f_canLaunchGame = false;
//					f_waitingTimer.cancel();
//					f_waitingTimer = null;
//					trace("Canceling 6 seconds timer");
//				}
			}
		}
		if (!isReady && f_readyUsers.contains(user))
		{
			synchronized (this) {
				if (isGameStartPending() || isGameStarted())
				{
					trace("WARN: Ready changed in incorrect state");
					return;
				}			
				f_readyUsers.remove(user);
//				if (f_waitingTimer != null)
//				{
//					f_canLaunchGame = false;
//					f_waitingTimer.cancel();
//					f_waitingTimer = null;
//					trace("Canceling 6 seconds timer");
//				}
			}
		}
		trace("Total ready = " + f_readyUsers.size());
		//final Object sync = this;
		
		synchronized(this)
		{
			if (f_readyUsers.size() >= 2 && f_waitingTimer == null)
			{
				trace("Before start game (6 sec)");
				f_waitingTimer = new Timer("f_waitingTimer");
				f_waitingTimer.schedule(new TimerTask() {
					
					@Override
					public void run() {
//						synchronized (sync) {
//							if (f_canLaunchGame)
//							{
								beforeStartGame();
								f_waitingTimer.cancel();
//							}
//							else
//							{
//								trace("Can't launch 3 seconds timer - someone's ready state was changed");
//								f_canLaunchGame = true;
//							}
//						}
					}
					
				}, C_WaitingTime);
			}
			if (f_readyUsers.size() == 4)
			{
				beforeStartGame();	
			}
		}
	}
	
	protected void beforeStartGame()
	{
		trace("Before start game (3 sec)");
		if (f_isPendingGameStart)
			return;
		f_isPendingGameStart = true;
		
		Random rnd = new Random();
		int mapId = rnd.nextInt(2) + 1;
		
		
		f_gameField = DynamicGameMap.LoadById(mapId);
		if (!f_gameField.isLoadOk())
		{
			trace("Map load error, id = " + mapId);
			trace(f_gameField.getLastError());
			trace(f_gameField.getLastErrorStackTrace());
		}
		else
		{
			if (!isGameRunning())
				runGame();
			
			f_playerStates = new ArrayList<UserGameParams>();
			for (User user : getParentRoom().getPlayersList()) {
				UserGameParams gp = loadUserParams(user);
				f_playerStates.add(gp);
			}
			f_bombFactory = new BombFactory(this, f_delayedEventsTimer);
			f_dynamicObjectFactory = new DynamicObjectFactory(f_gameField.getWallBlocksCount());
			f_dynamicObjects = new DynamicObject[f_gameField.getWidth() * f_gameField.getHeight()];
			
			SFSObject params = new SFSObject();
			
			int players = f_readyUsers.size();
			int maxPlayers = f_gameField.getStartPositionCount();
			Random rand = new Random();
			boolean[] busy = new boolean[maxPlayers];
			for (int i = 0; i < players; ++i)
			{
				params.putInt("user" + (i+1), f_readyUsers.get(i).getId());
				int j = 0;
				do
				{
					j = rand.nextInt(maxPlayers);
				} while (busy[j] == true);
				busy[j] = true;
				params.putInt("start_x" + (i+1), f_gameField.getStartXAt(j));
				params.putInt("start_y" + (i+1), f_gameField.getStartYAt(j));
			}
			params.putInt("map_id", mapId);
			
			send("3_seconds_to_start", params, getParentRoom().getPlayersList());
		}
		
		f_beforeStartTimer = new Timer("f_beforeStartTimer");
		f_beforeStartTimer.schedule(new TimerTask() {
			
			@Override
			public void run() {
				startGame();
				f_beforeStartTimer.cancel();
			}
			
		}, C_TimeBeforeStart);
	}
	
	/*
	 * Run working thread
	 */
	protected void runGame()
	{
		if (isGameRunning())
			return;
		
		f_isGameRunning = true;
		
		final BombersGameProcess game = this;
		
		f_thread = new Thread(new Runnable() {
			@Override
			public void run() {
				trace("Event dispatching start");
				while (isGameRunning())
				{
					try
					{
						GameEvent e = getGameEvent();
						if (e == null)
						{
							trace("Null event dropped by kernel");
						}
						else
						{
							e.applyOnGame(game, f_gameField, f_playerStates);
						}
					}
					catch (Exception e)
					{
						trace("Working thread exception!");
						trace(e.getMessage());
						trace((Object[])e.getStackTrace());
					}
				}
				trace("Event dispatching stop");
			}
		}, "Room " + getParentRoom().getId() + " event dispatching thread");
		f_delayedEventsTimer = new Timer("Room " + getParentRoom().getId() + " delayed events timer");
		f_thread.start();
	}
	
	protected void startGame()
	{
		if (isGameStarted())
			return;
		trace("Game started");
		
		f_isGameStarted = true;
		initalizeDeathBlocks();
		
		SFSObject params = new SFSObject();
		send("game_started", params, getParentRoom().getPlayersList());
	}
	
	public void endGame()
	{
		if (!f_isGameStarted)
			return;
		trace("Game ended");
		
		f_isGameStarted = false;
		f_isPendingGameStart = false;
		f_canLaunchGame = true;
		f_waitingTimer = null;
		
		//Calculate statistics and send messages
		
		f_readyUsers.clear();
		
		SFSObject params = new SFSObject();
		send("game_ended", params, getParentRoom().getPlayersList());
	}
	
	//Event dispatching
	
	public void addDelayedGameEvent(final GameEvent gameEvent, long delay)
	{
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				f_eventQueue.add(gameEvent);
			}
		};
		f_delayedEventsTimer.schedule(task, delay);
	}
	
	public void addGameEvent(GameEvent gameEvent)
	{
		f_eventQueue.add(gameEvent);
	}
	
	protected GameEvent getGameEvent() throws InterruptedException {
		GameEvent e = f_eventQueue.take();
		return e;
	}
	
	//Specific game events
	
	protected void userDead(User user)
	{
		f_readyUsers.remove(user);
		SFSObject params = new SFSObject();
		params.putInt("user_id", user.getId());	
		send("player_died", params, getParentRoom().getPlayersList());
		trace("User died =(");
		if (f_readyUsers.size() <= 1)
		{
			endGame();
		}
	}
	
	public void damageUser(final User user, final int damage, final int effect, final boolean isDead)
	{
		addGameEvent(new GameEvent() {
			
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				
				UserGameParams ownerParams = getUserGameParams(user, playerStates);
				ownerParams.addHealth(-damage);
				if (isDead)
				{
					trace("Player " + user.getId() + " died");
					userDead(user);
				}
				else
				{
					trace("Player " + user.getId() + " now " + ownerParams.getHealth() + " health left");
					SFSObject params = new SFSObject();
					params.putInt("user_id", user.getId());
					params.putInt("health_left", ownerParams.getHealth());
					send("player_damaged", params, getParentRoom().getPlayersList());
				}
			}
		});
	}
	
	public void trySetBomb(final User user, final int bombType, final int x, final int y)
	{	
		addGameEvent(new GameEvent() {
			
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				
				UserGameParams ownerParams = getUserGameParams(user, playerStates);
				if (gf.getObjectTypeAt(x, y) == DynamicGameMap.ObjectType.EMPTY && ownerParams.setBomb())
				{
					if (f_bombFactory.createBomb(user, bombType, ownerParams.getBombPowerBonus(), x, y))
					{
						//gf.setObjectTypeAt(x, y, DynamicGameMap.ObjectType.BOMB);
						addDynamicObject(x, y, new BombDynamicObject());

						SFSObject params = new SFSObject();

						params.putInt("bomb_owner", user.getId());
						params.putInt("bomb_type", bombType);
						params.putInt("bomb_x", x);
						params.putInt("bomb_y", y);

						send("set_bomb", params, game.getParentRoom().getPlayersList());
						
						trace("Set bomb at: " + x + ", " + y);
					}
				}
			}
			
		});
	}
		
	public void destroyWallAt(final int x, final int y)
	{
		trace("Explosion touched wall at " + x + ", " + y);
		if (getDynamicObject(x, y) == null)
		{
			addDynamicObject(x, y, new DynamicObject());
		}
		else
		{
			return;
		}
		
		GameEvent wallDestoryEvent = new GameEvent() {
			
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				removeDynamicObject(x, y);
				gf.setObjectTypeAt(x, y, DynamicGameMap.ObjectType.EMPTY);
				
//				SFSObject params = new SFSObject();
//				
//				params.putInt("wall_x", x);
//				params.putInt("wall_y", y);
//
//				send("wall_destroyed", params, getParentRoom().getPlayersList());
				
				DynamicObject bonus = f_dynamicObjectFactory.GenerateBonusWhenWallDestroyed();
				if (bonus != null)
				{
					trace("Added bonus of type " + bonus.getTypeId() + " at " + x + ", " + y);
					game.addDynamicObject(x, y, bonus);
					
					SFSObject params = new SFSObject();
					params.putInt("bonus_x", x);
					params.putInt("bonus_y", y);
					params.putInt("bonus_type", bonus.getTypeId());
					send("bonus_appeared", params, game.getParentRoom().getPlayersList());
				}
				trace("wall destroyed at " + x + ", " + y);
			}
			
		};
		
		addDelayedGameEvent(wallDestoryEvent, 50);
		
	}
	
	protected void initalizeDeathBlocks()
	{
		addDelayedGameEvent(new GameEvent() {
			
			private int x;
			private int y;
			
			private int direction = 0;
			
			@Override
			public void applyOnGame(BombersGameProcess game, DynamicGameMap gf,
					ArrayList<UserGameParams> playerStates) {
				if (isGameStarted())
				{
					if (gf.getObjectTypeAt(x, y) == DynamicGameMap.ObjectType.DEATH_WALL)
						return;
					
					game.trace("Death block added at " + x + ", " + y);
					
					gf.setObjectTypeAt(x, y, DynamicGameMap.ObjectType.DEATH_WALL);
					
					SFSObject params = new SFSObject();
					params.putInt("x", x);
					params.putInt("y", y);
					game.send("death_wall_appeared", params, game.getParentRoom().getPlayersList());					
				
					//RIGHT
					if (direction == 0)
					{
						if (x == gf.getWidth() - 1 || gf.getObjectTypeAt(x + 1, y) == DynamicGameMap.ObjectType.DEATH_WALL)
							direction = 1;
						else
							x += 1;
					}
					//DOWN
					if (direction == 1)
					{
						if (y == gf.getHeight() - 1 || gf.getObjectTypeAt(x, y + 1) == DynamicGameMap.ObjectType.DEATH_WALL)
							direction = 2;
						else
							y += 1;						
					}
					//LEFT
					if (direction == 2)
					{
						if (x == 0 || gf.getObjectTypeAt(x - 1, y) == DynamicGameMap.ObjectType.DEATH_WALL)
							direction = 3;
						else
							x -= 1;						
					}
					//UP
					if (direction == 3)
					{
						if (y == 0 || gf.getObjectTypeAt(x, y - 1) == DynamicGameMap.ObjectType.DEATH_WALL)
						{	
							direction = 0;
							x += 1;
						}
						else
							y -= 1;						
					}
					
					
					game.addDelayedGameEvent(this, 1250);
				}
			}
		}, 45*1000);
	}
	
	
	
}
