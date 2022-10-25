using CitizenFX.Core;

public struct Transport
{
    public string ModelName { get; set; }
    public int ModelHash { get; set; }

    public Vector3 Min { get; set; }
    public Vector3 Max { get; set; }

    public int RampModelHash { get; set; }
    public Vector3 RampPosition { get; set; }
    public Vector3 RampRotation { get; set; }
}
