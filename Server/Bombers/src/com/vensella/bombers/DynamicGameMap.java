package com.vensella.bombers;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class DynamicGameMap {
	
	/*
	 * Map block size in pixels
	 */
	private static final double C_BlockSize = 40.0;
	
	public enum ObjectType {
		EMPTY,
		WALL,
		STRONG_WALL,
		DEATH_WALL,
		BOMB,
		OUT
	}
	
	//Static part
	
	private static final String MapUriPreffix = "/usr/local/sfs2/SFS2X-RC1/SFS2X/www/root/bombers_maps/map";
	
	public static DynamicGameMap LoadById(int id)
	{
		String path = MapUriPreffix + id + ".xml";
		DynamicGameMap map = new DynamicGameMap(path);
		return map;
	}
	
	//Fields
	
	private Boolean f_isLoadedOk = true;
	private String f_lastError;
	private Object[] f_lastErrorStackTrace;
	
	private int f_maxX;
	private int f_maxY;
	
	private int[] f_spawnX;
	private int[] f_spawnY;
	
	private ObjectType[][] f_map;
	
	//Constructors
	
	protected DynamicGameMap(String path)
	{
		try
		{
			//File file = new File(path);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(path);
			//doc.getDocumentElement().normalize(); 
			Element rootElement = doc.getDocumentElement();
			
			NodeList nl = null;
			
			//Size
			nl = rootElement.getElementsByTagName("size");
			Element sizeElement = (Element)nl.item(0);
			f_maxX = Integer.parseInt(sizeElement.getAttribute("width"));
			f_maxY = Integer.parseInt(sizeElement.getAttribute("height"));
			
			//SpawnsInit
			nl = rootElement.getElementsByTagName("spawns");
			NodeList spawnsNodeList = ((Element)nl.item(0)).getElementsByTagName("Spawn");
			f_spawnX = new int[spawnsNodeList.getLength()];
			f_spawnY = new int[spawnsNodeList.getLength()];
			for (int i = 0; i < spawnsNodeList.getLength(); ++i)
			{
				Element spawnElement = (Element)spawnsNodeList.item(i);
				f_spawnX[i] = Integer.parseInt(spawnElement.getAttribute("x"));
				f_spawnY[i] = Integer.parseInt(spawnElement.getAttribute("y"));
			}
			
			//MapInit
			nl = rootElement.getElementsByTagName("rows");
			NodeList rowsNodeList = ((Element)nl.item(0)).getElementsByTagName("Row");
			f_map = new ObjectType[f_maxX][];
			for (int i = 0; i < f_maxX; ++i)
				f_map[i] = new ObjectType[f_maxY];
			for (int y = 0; y < rowsNodeList.getLength(); ++y)
			{
				Element rowElement = (Element)rowsNodeList.item(y);
				String rowString = rowElement.getAttribute("val"); 
				for (int x = 0; x < f_maxX; ++x)
				{
					if (rowString.charAt(x) == 'f')
					{
						f_map[x][y] = ObjectType.EMPTY;
					}
					else if (rowString.charAt(x) == 'w')
					{
						f_map[x][y] = ObjectType.STRONG_WALL;
					}
					else if (rowString.charAt(x) == 'b')
					{
						f_map[x][y] = ObjectType.WALL;
					}
				}
			}
			
		}
		catch (Exception e)
		{
			f_isLoadedOk = false;
			f_lastError = e.getMessage();
			f_lastErrorStackTrace = (Object[])e.getStackTrace();
		}
	}
	
	public Boolean isLoadOk()
	{
		return f_isLoadedOk;
	}
	
	public Object[] getLastErrorStackTrace()
	{
		return f_lastErrorStackTrace;
	}
	
	public String getLastError()
	{
		return f_lastError;
	}
	
	//GameMap methods
	
	public int getWidth()
	{
		return f_maxX;
	}
	
	public int getHeight()
	{
		return f_maxY;
	}
	
	public ObjectType getObjectTypeAt(int x, int y)
	{
		if (x < 0 || y < 0 || y >= f_maxY || x >= f_maxX)
			return ObjectType.OUT;
		return f_map[x][y];
	}
	
	public ObjectType getObjectTypeAt(double x, double y)
	{
		return f_map[getXCell(x)][getYCell(y)];
	}
	
	public void setObjectTypeAt(int x, int y, ObjectType value)
	{
		f_map[x][y] = value;
	}
	
	public void setObjectTypeAt(double x, double y, ObjectType value)
	{
		f_map[getXCell(x)][getYCell(y)] = value;
	}
	
	public int getStartPositionCount()
	{
		return f_spawnX.length;
	}
	
	public int getStartXAt(int index)
	{
		return f_spawnX[index];
	}
	
	public int getStartYAt(int index)
	{
		return f_spawnY[index];
	}
	
	public int getXCell(double x)
	{
		int cellX = (int)Math.round(x / C_BlockSize);
		return cellX;
	}
	
	public int getYCell(double y)
	{
		int cellY = (int)Math.round(y / C_BlockSize);
		return cellY;		
	}
	
	//Statistics
	
	public int getWallBlocksCount()
	{
		int count = 0;
		for (int x = 0; x < f_maxX; ++x)
			for (int y = 0; y < f_maxY; ++y)
			{
				if (f_map[x][y] == ObjectType.WALL)
					count++;
			}
		return count;
	}
	
	
	
}