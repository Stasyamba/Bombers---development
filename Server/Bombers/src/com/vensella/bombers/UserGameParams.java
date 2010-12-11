package com.vensella.bombers;

import com.smartfoxserver.v2.entities.User;

public class UserGameParams {
	
	//Basic parameters
	private int f_maxHealth = 3;
	private int f_bombPowerBonus = 0;
	private int f_bombsLeft = 3;
	private double f_speed = 100.0 / 1000.0;
	
	
	//Game process parameters
	
	private double f_x;
	private double f_y;
	private int f_direction;
	
	private int f_health = 3;
	
	private User f_user;
	
	//Initialize
	
	public UserGameParams(User user)
	{
		f_user = user;
	}
	
	//Getters and setters
	
	public User getUser()
	{
		return f_user;
	}
	
	
	public double getX()
	{
		return f_x;
	}
	
	public void setX(double x)
	{
		f_x = x;
	}
	
	public double getY()
	{
		return f_y;
	}
	
	public void setY(double y)
	{
		f_y = y;
	}
	
	public int getBombPowerBonus()
	{
		return f_bombPowerBonus;
	}
	
	public void setBombPowerBonus(int bombPowerBonus)
	{
		f_bombPowerBonus = bombPowerBonus;
	}
	
	public double getSpeed()
	{
		return f_speed;
	}
	
	public void setSpeed(double speed)
	{
		f_speed = speed;
	}
	
	public int getDirection()
	{
		return f_direction;
	}
	
	public void setDirection(int direction)
	{
		f_direction = direction;
	}
	
	public Boolean setBomb()
	{
		if (f_bombsLeft == 0)
			return false;
		else
		{
			f_bombsLeft--;
			return true;
		}
	}
	
	public void releaseBomb()
	{
		f_bombsLeft++;
	}
	
	public void addHealth(int health)
	{
		f_health += health;
		if (f_health > f_maxHealth)
			f_health = f_maxHealth;
	}
	
	public int getHealth()
	{
		return f_health;
	}
	
}
