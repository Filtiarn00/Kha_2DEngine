package khaEngine2D.graphics;
import kha.math.FastVector2;
import kha.Image;

class TileManager
{
    private static var tilesets:Map<String,Tileset> = new Map<String,Tileset>();
    private static var tileLayers:Map<String,TileLayer> = new Map<String,TileLayer>();

    public static function createTileset(key:String, image:Image, tileWidth:Int, tileHeight:Int):Void
    {
        var tileset = new Tileset();
        tileset.image = image;
        tileset.tileWidth = tileWidth;
        tileset.tileHeight = tileHeight;

        tilesets.set(key,tileset);
    }

    public static function createTileLayer(tilesetKey:String, tileLayerKey:String) 
    {
        var t = new TileLayer();
        t.xWorldPosition = 0;
        t.yWorldPosition = 0;
        t.tilelsetKey = tilesetKey;
        tileLayers.set(tileLayerKey,t);
    }

    public static function addTile(tileLayerKey:String, positionX:Float, positionY:Float, imageX:Float, imageY:Float) 
    {
        var tileLayer = tileLayers.get(tileLayerKey);

        if (tileLayer != null)
        {
            var tileset = tilesets.get(tileLayer.tilelsetKey);

            if (tileset != null)
            {
                var tile = new Tile();
                tile.positionX = positionX - positionX % tileset.tileWidth;
                tile.positionY = positionY - positionY % tileset.tileHeight;
                tile.imageX = imageX;
                tile.imageY = imageY;

                tileLayer.tiles.set(new FastVector2(positionX,positionY),tile);
            }
        }
    }
    
    public static function renderPreviewTile(tilesetKey:String,positionX:Float, positionY:Float,imageX:Float, imageY:Float,imageWidth:Float, imageHeight:Float) 
    {
        var tileset = tilesets[tilesetKey];

        if (tileset != null && tileset.image != null)
        {
            positionX = positionX - positionX % tileset.tileWidth;
            positionY = positionY - positionY % tileset.tileHeight;
            SpriteBatch.drawSpriteSheet(tileset.image,positionX,positionY,0,0,imageX,imageY,imageX + imageWidth, imageY + imageHeight);
        }
    }

    public static function render() 
    {
        for (i in tileLayers)
        {
            var tileset = tilesets[i.tilelsetKey];

            if (tileset != null && tileset.image != null)
                for (j in i.tiles)
                    SpriteBatch.drawSpriteSheet(tileset.image,i.xWorldPosition + j.positionX,i.yWorldPosition + j.positionY,0,0,j.imageX,j.imageY,j.imageX + tileset.tileWidth,j.imageY + tileset.tileHeight);
        }
    }
}

class TileLayer
{   
    public function new() 
    {
        
    }

    public var tiles:Map<FastVector2,Tile> = new Map<FastVector2,Tile>();
    public var xWorldPosition:Float;
    public var yWorldPosition:Float;
    public var tilelsetKey:String;
}

class Tile
{
    public var positionX:Float;
    public var positionY:Float;
    public var imageX:Float;
    public var imageY:Float;

    public function new() 
    {
        
    }
}

class Tileset
{
    public var image:Image;
    public var tileWidth:Int;
    public var tileHeight:Int;

    public function new() 
    {
        
    }
}