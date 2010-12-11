package com.vensella.bombers.dynamicObjects;

import com.vensella.bombers.dynamicObjects.bonuses.*;

public class DynamicObjectFactory {
	
	public static final int BONUS_ADD_BOMB = 1;
	public static final int BONUS_ADD_POWER = 2;
	public static final int BONUS_ADD_SPEED = 3;
	public static final int BONUS_ADD_HEALTH = 4;
	
	private int f_wallBlocks;
	
	private int f_countAddBomb = 8;
	private int f_countAddPower = 8;
	private int f_countAddSpeed = 8;
	private int f_countAddHealth = 4;
	
	public DynamicObjectFactory(int wallBlocks)
	{
		f_wallBlocks = wallBlocks;
	}
	
	public static DynamicObject CreateDynamicObject(int id)
	{
		DynamicObject o = null;
		switch (id) {
		case BONUS_ADD_BOMB:
			o = new BombCountBonus();
			break;
		case BONUS_ADD_POWER:
			o = new BombPowerBonus();
			break;
		case BONUS_ADD_SPEED:
			o = new PlayerSpeedBonus();
			break;
		case BONUS_ADD_HEALTH:
			o = new PlayerHealthBonus();
			break;

		default:
			break;
		}
		return o;
	}
	
	protected DynamicObject CreateRandomBonus()
	{
		DynamicObject bonus = null;
		double r1 = Math.random() * f_countAddBomb;
		double r2 = Math.random() * f_countAddPower;
		double r3 = Math.random() * f_countAddSpeed;
		double r4 = Math.random() * f_countAddHealth;
		if (r1 > r2 && r1 > r3 && r1 > r4)
		{
			bonus = CreateDynamicObject(BONUS_ADD_BOMB);
			f_countAddBomb--;
		}
		else if (r2 > r1 && r2 > r3 && r2 > r4)
		{
			bonus = CreateDynamicObject(BONUS_ADD_POWER);
			f_countAddPower--;
		}
		else if (r3 > r1 && r3 > r2 && r3 > r4)
		{
			bonus = CreateDynamicObject(BONUS_ADD_SPEED);
			f_countAddSpeed--;
		}
		else
		{
			bonus = CreateDynamicObject(BONUS_ADD_HEALTH);
			f_countAddHealth--;
		}
		
		return bonus;
	}
	
	public DynamicObject GenerateBonusWhenWallDestroyed()
	{
		int bonusesLeft = f_countAddBomb + f_countAddPower + f_countAddSpeed + f_countAddHealth;
		
		double C = 1.0 * bonusesLeft / f_wallBlocks;
		double p = Math.random();
		f_wallBlocks--;
		
		if (p < C)
			return CreateRandomBonus();
		else
			return null;
	}
	
}
