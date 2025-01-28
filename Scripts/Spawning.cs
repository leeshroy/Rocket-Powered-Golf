using Godot;
using System;
using System.Collections.Generic;

public partial class Spawning : Node3D
{
	[Export] public PackedScene NodeToSpawn;
	[Export]public float spawnRate = 0.5f; //Spawnrate per Second
	[Export]public Vector3 SpawningArea;
	
	private double _timeSinceLastSpawn = 0;
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		_timeSinceLastSpawn += delta;
		if (spawnRate < _timeSinceLastSpawn)
		{
			_timeSinceLastSpawn = 0;
			
			InstantiatePrefab(NodeToSpawn,GetRandomPosition());
		}
	}
	
	public void InstantiatePrefab(PackedScene scene ,Vector3 position)
	{
		var instance = scene.Instantiate<Node3D>();
		instance.GlobalPosition = position;
		AddChild(instance);
	}

	private Vector3 GetRandomPosition()
	{
		return new Vector3(GD.Randf() * SpawningArea.X * 2 - SpawningArea.X,
			GD.Randf() * SpawningArea.Y * 2 - SpawningArea.Y,
			GD.Randf() * SpawningArea.Z * 2 - SpawningArea.Z) + Transform.Origin;
	}
}
