package khaEngine2D.entities;

class Entity
{
    private var index:Int;

    public function new(index:Int)
	{			
        this.index = index;
	}

    public function getIndex():Int
    {
        return index;
    }
}