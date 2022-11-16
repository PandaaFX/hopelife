using System;
using System.Collections.Generic;
using System.Threading.Tasks;

using Newtonsoft.Json;

using CitizenFX.Core;
using CitizenFX.Core.UI;
using CitizenFX.Core.Native;

using FiveM_FileHandler;

namespace VehicleTransport
{
    public class VehicleTransport_Client : BaseScript
    {
        private readonly IniFile config;

        private readonly bool isDebug;
        public static bool IsOnesync { get; private set; }

        private readonly float deployedRampSpeed;

        private bool enabled;

        private readonly List<Transport> transports;

        private Vehicle[] clientVehicles = new Vehicle[0];

        private Vehicle currentTransportVehicle = null;
        private Transport currentTransport;
        private bool isCloseToTransportArea = false;
        private bool isInTransportArea = false;
        private bool isInRampArea = false;

        private bool isInVehicle = false;
        private bool isDriver = false;

        private bool isEntering = false;

        private bool isTryingToEnter = false;

        private int trailerVehicleHandle;
        private bool isTrailerLastUpdate = false;

        private bool isDrivingWithRamp = false;

        private Notification attachNotif = null;

        private readonly Control attachDetachControl;
        private readonly Control deployRampControl;

        private TransportCreator transportCreator = null;

        public VehicleTransport_Client() {
            // load config
            config = FileLoader.LoadIniFile("config.ini");

            // set config values
            isDebug = bool.Parse(config["DEBUG", "debugMode"]);
            IsOnesync = bool.Parse(config["VALUES", "onesync"]);
            enabled = bool.Parse(config["VALUES", "defaultEnabled"]);
            deployedRampSpeed = float.Parse(config["VALUES", "deployedRampSpeed"]) / 3.6f;

            attachDetachControl = (Control)int.Parse(config["CONTROLS", "attachDetach"]);
            deployRampControl = (Control)int.Parse(config["CONTROLS", "deployRamp"]);

            // load transport data from json file
            string tmp = API.LoadResourceFile(API.GetCurrentResourceName(), "transportData.json");
            transports = JsonConvert.DeserializeObject<List<Transport>>(tmp);

            if (isDebug)
                // create a new instance of the TransportCreator
                transportCreator = new TransportCreator();

            if (!IsOnesync)
                EventHandlers["VehicleTransport:DeleteRamp"] += new Action<int>(Event_DeleteRamp);

            EventHandlers["VehicleTransport:Enable"] += new Action<bool>(Event_Enable);

            // enable Tick functions if the script is enabled by default
            if (enabled) {
                Tick += EveryFrame;
                Tick += Every250ms;
                Tick += Every2000ms;
            }
        }

        private async Task EveryFrame() {
            await Task.FromResult(0);

            if (currentTransportVehicle != null) {
                if (isInTransportArea) {
                    if (isTryingToEnter) {
                        isTryingToEnter = false;

                        Vehicle vehicle = GetClosestVehicleNoTransport(Game.PlayerPed.Position, 10f);
                        if (!Game.PlayerPed.IsGettingIntoAVehicle && vehicle != null && vehicle.IsSeatFree(VehicleSeat.Driver)) {
                            Game.PlayerPed.SetIntoVehicle(vehicle, VehicleSeat.Driver);
                        }
                    }

                    if (Game.IsControlJustReleased(0, Control.Enter) && !Game.PlayerPed.IsInVehicle() && !Game.PlayerPed.IsGettingIntoAVehicle) {
                        isTryingToEnter = true;
                    }

                    if (isInVehicle) {
                        if (isEntering) {
                            isEntering = false;

                            Game.PlayerPed.CurrentVehicle.Detach();
                        }

                        if (Game.PlayerPed.CurrentVehicle != null && Game.PlayerPed.CurrentVehicle != currentTransportVehicle && isDriver) {
                            if (Game.PlayerPed.CurrentVehicle.IsAttached()) {
                                Screen.DisplayHelpTextThisFrame(config["TRANSLATION", "detachHelpText"]);
                            } else {
                                Screen.DisplayHelpTextThisFrame(config["TRANSLATION", "attachHelpText"]);
                            }

                            if (Game.IsControlJustReleased(0, attachDetachControl)) {
                                AttachVehicle();
                            }
                        }
                    } else if (Game.PlayerPed.VehicleTryingToEnter != null && !isEntering) {
                        Vehicle veh = Game.PlayerPed.VehicleTryingToEnter;

                        if (!veh.IsAttached() && Game.PlayerPed.VehicleTryingToEnter != currentTransportVehicle) {
                            isEntering = true;

                            Vector3 offset = currentTransportVehicle.GetPositionOffset(veh.Position);
                            Vector3 rotationOffset = veh.Rotation - currentTransportVehicle.Rotation;

                            API.AttachEntityToEntity(veh.Handle, currentTransportVehicle.Handle, -1, offset.X, offset.Y, offset.Z, rotationOffset.X, rotationOffset.Y, rotationOffset.Z, false, false, true, false, 2, true);
                        }
                    }
                } else if (isCloseToTransportArea && isDriver && Game.PlayerPed.CurrentVehicle != currentTransportVehicle) {
                    Screen.DisplayHelpTextThisFrame(config["TRANSLATION", "moveCloserHelpText"]);
                } else if (isInRampArea && !isInVehicle) {
                    Screen.DisplayHelpTextThisFrame(config["TRANSLATION", "deployRampHelpText"]);

                    if (Game.IsControlJustReleased(0, deployRampControl)) {
                        DeployRamp();
                    }
                }
            }

            if (isDebug && transportCreator != null && transportCreator.CreatingTransport) {
                transportCreator.Process();
            }
        }

        private async Task Every250ms() {
            await Delay(250);

            isInVehicle = Game.PlayerPed.IsInVehicle();
            isDriver = Game.PlayerPed.SeatIndex == VehicleSeat.Driver;

            isInTransportArea = false;
            isCloseToTransportArea = false;
            isInRampArea = false;

            isDrivingWithRamp = false;

            if (currentTransportVehicle != null) {
                Vector3 offset = currentTransportVehicle.GetPositionOffset(Game.PlayerPed.Position);

                if (InBounds(offset, currentTransport.Min, currentTransport.Max)) {
                    isInTransportArea = true;
                } else if (InBounds(offset, currentTransport.Min - new Vector3(1f, 1f, 0f), currentTransport.Max + 1f)) {
                    isCloseToTransportArea = true;
                } else if (currentTransport.RampModelHash != -1 && InBounds(offset, currentTransport.RampPosition - 4f, currentTransport.RampPosition + 4f)) {
                    isInRampArea = true;
                }

                bool isTrailer = isInVehicle && API.GetVehicleTrailerVehicle(Game.PlayerPed.CurrentVehicle.Handle, ref trailerVehicleHandle);
                // detached trailer
                if (isTrailerLastUpdate && !isTrailer) {
                    if (isInVehicle)
                        Game.PlayerPed.CurrentVehicle.MaxSpeed = 200f;
                }
                isTrailerLastUpdate = isTrailer;

                if (isInVehicle && isDriver) {
                    if (!isTrailer) {
                        if (Game.PlayerPed.IsInVehicle(currentTransportVehicle) && Game.PlayerPed.SeatIndex == VehicleSeat.Driver) {
                            Transport currTrans = GetTransportFromVehicle(currentTransportVehicle);
                            Vector3 position = currentTransportVehicle.GetOffsetPosition(currTrans.RampPosition);
                            Prop foundRamp = World.GetClosest(position, World.GetAllProps());

                            isDrivingWithRamp = foundRamp != null && World.GetDistance(position, foundRamp.Position) < 0.1f;

                            if (isDrivingWithRamp)
                                Game.PlayerPed.CurrentVehicle.MaxSpeed = deployedRampSpeed;
                            else
                                Game.PlayerPed.CurrentVehicle.MaxSpeed = 200f;
                        }
                    } else {
                        Transport currTrans = GetTransportFromVehicle(API.GetEntityModel(trailerVehicleHandle));
                        Vector3 position = API.GetOffsetFromEntityInWorldCoords(trailerVehicleHandle, currTrans.RampPosition.X, currTrans.RampPosition.Y, currTrans.RampPosition.Z);
                        Prop foundRamp = World.GetClosest(position, World.GetAllProps());

                        isDrivingWithRamp = foundRamp != null && World.GetDistance(position, foundRamp.Position) < 0.5f;

                        if (isDrivingWithRamp)
                            Game.PlayerPed.CurrentVehicle.MaxSpeed = deployedRampSpeed;
                        else
                            Game.PlayerPed.CurrentVehicle.MaxSpeed = 200f;
                    }
                }
            }
        }

        private async Task Every2000ms() {
            await Delay(2000);

            clientVehicles = World.GetAllVehicles();

            currentTransportVehicle = GetClosestTransportVehicle(Game.PlayerPed.Position, 30f, ref clientVehicles, ref currentTransport);
        }

        #region TestingArea
        //private Vector3 QuatToEuler(Quaternion q) {
        //    float w = q.W;
        //    float x = q.X;
        //    float y = q.Y;
        //    float z = q.Z;

        //    float t0 = 2f * (w * x + y * z);
        //    float t1 = 1f - 2f * (x * x + y * y);
        //    float roll = (float)Math.Atan2(t0, t1);
        //    float t2 = 2f * (w * y - z * x);
        //    if (t2 > 1f)
        //        t2 = 1f;
        //    if (t2 < -1f)
        //        t2 = -1f;
        //    float pitch = (float)Math.Asin(t2);
        //    float t3 = 2f * (w * z + x * y);
        //    float t4 = 1f - 2f * (y * y + z * z);
        //    float yaw = (float)Math.Atan2(t3, t4);

        //    return new Vector3(yaw, pitch, roll);
        //}
        #endregion

        /// <summary>
        /// Attach a Vehicle to the Transport.
        /// </summary>
        private void AttachVehicle() {
            Vehicle[] closeVehicles = World.GetAllVehicles();

            Vehicle vehicle = Game.PlayerPed.CurrentVehicle;
            if (vehicle == null)
                return;

            if (!vehicle.IsAttached()) {
                Transport transport = new Transport();
                Vehicle closestTransport = GetClosestTransportVehicle(Game.PlayerPed.Position, 30f, ref closeVehicles, ref transport);
                if (closestTransport == null)
                    return;

                Vector3 vehiclePos = vehicle.Position;
                Vector3 offset = closestTransport.GetPositionOffset(vehiclePos);
                Vector3 rotationOffset = vehicle.Rotation - closestTransport.Rotation;

                #region TestingArea
                //Vector3 rotationOffset;
                //rotationOffset.X = Math.Abs(vehicle.Rotation.X - closestTransport.Rotation.X);
                //rotationOffset.Y = Math.Abs(vehicle.Rotation.Y - closestTransport.Rotation.Y);
                //rotationOffset.Z = Math.Abs(vehicle.Rotation.Z - closestTransport.Rotation.Z);
                //if (rotationOffset.Z > 90f || rotationOffset.Z < -90f)
                //    rotationOffset.Z *= -1;

                //Matrix m = closestTransport.Matrix;
                //m.
                //Debug.WriteLine(" Trans: " + closestTransport.Rotation);
                //Debug.WriteLine("   Veh: " + vehicle.Rotation);
                ////Debug.WriteLine("TransT: " + tempRotTransport);
                ////Debug.WriteLine("  VehT: " + tempRotVehicle);
                //Debug.WriteLine("   off: " + rotationOffset);

                //Quaternion quatTrans = closestTransport.Quaternion;
                //Quaternion quat = quatTrans * Quaternion.Invert(vehicle.Quaternion);
                //Vector3 rot = QuatToEuler(quat);
                #endregion

                if (offset.X >= transport.Min.X && offset.X <= transport.Max.X && offset.Y >= transport.Min.Y && offset.Y <= transport.Max.Y && offset.Z >= transport.Min.Z && offset.Z <= transport.Max.Z) {
                    float relativeSpeed = (vehicle.Velocity - closestTransport.Velocity).Length();
                    if (relativeSpeed > 3f) {
                        if (attachNotif != null)
                            attachNotif.Hide();
                        attachNotif = Screen.ShowNotification(config["TRANSLATION", "vehicleTooFastNotification"]);
                        return;
                    }

                    API.AttachEntityToEntity(vehicle.Handle, closestTransport.Handle, -1, offset.X, offset.Y, offset.Z, rotationOffset.X, rotationOffset.Y, rotationOffset.Z, false, false, true, false, 2, true);
                    if (attachNotif != null)
                        attachNotif.Hide();
                    attachNotif = Screen.ShowNotification(config["TRANSLATION", "vehicleAttachedNotification"]);
                } else {
                    if (attachNotif != null)
                        attachNotif.Hide();
                    attachNotif = Screen.ShowNotification(config["TRANSLATION", "positionVehicleNotification"]);
                }
            } else {
                vehicle.Detach();

                if (attachNotif != null)
                    attachNotif.Hide();
                attachNotif = Screen.ShowNotification(config["TRANSLATION", "vehicleDetachedNotification"]);
            }
        }

        /// <summary>
        /// Deploy the ramp from a transport.
        /// </summary>
        private async void DeployRamp() {
            if (!isInRampArea)
                return;

            Vehicle[] closeVehicles = World.GetAllVehicles();

            Transport transport = new Transport();
            Vehicle closestTransport = GetClosestTransportVehicle(Game.PlayerPed.Position, 30f, ref closeVehicles, ref transport);
            if (closestTransport == null)
                return;

            if (transport.RampModelHash == -1)
                return;

            Vector3 position = closestTransport.GetOffsetPosition(transport.RampPosition);

            Prop foundRamp = World.GetClosest(position, World.GetAllProps());
            if (foundRamp != null && World.GetDistance(position, foundRamp.Position) < 2.0f) {

                foundRamp.Detach();

                TriggerServerEvent("VehicleTransport:DeleteRamp", foundRamp.NetworkId, IsOnesync);
            } else {
                Model model = new Model(transport.RampModelHash);
                Prop ramp = await World.CreateProp(model, position, closestTransport.Rotation, false, false);
                API.AttachEntityToEntity(ramp.Handle, closestTransport.Handle, -1, transport.RampPosition.X, transport.RampPosition.Y, transport.RampPosition.Z, transport.RampRotation.X, transport.RampRotation.Y, transport.RampRotation.Z, false, false, true, false, 2, true);

                model.MarkAsNoLongerNeeded();

                ramp.IsPersistent = true;
            }
        }

        /// <summary>
        /// Enables or disables the scripts functionality.
        /// </summary>
        /// <param name="enable">If the script should be enabled or disabled.</param>
        private void Event_Enable(bool enable) {
            enabled = enable;

            // enable / disable all Tick functions
            if (enabled) {
                Debug.WriteLine("Enabled VehicleTransport...");

                Tick += EveryFrame;
                Tick += Every250ms;
                Tick += Every2000ms;
            } else {
                Debug.WriteLine("Disabled VehicleTransport...");

                Tick -= EveryFrame;
                Tick -= Every250ms;
                Tick -= Every2000ms;
            }
        }

        /// <summary>
        /// Deletes the ramp with the given Network Id if one was found.
        /// </summary>
        /// <param name="rampNetId">The Network Id of the ramp.</param>
        private void Event_DeleteRamp(int rampNetId) {
            int rampHandle = API.NetworkGetEntityFromNetworkId(rampNetId);

            if (API.DoesEntityExist(rampHandle)) {
                API.DeleteEntity(ref rampHandle);
            }
        }

        /// <summary>
        /// Checks if a position is inside the given bounds.
        /// </summary>
        /// <param name="position">The position to check.</param>
        /// <param name="minPoint">The minimum point of the bounds.</param>
        /// <param name="maxPoint">The maximum point of the bounds.</param>
        /// <returns>True if the position is inside the bounds, false if not.</returns>
        private bool InBounds(Vector3 position, Vector3 minPoint, Vector3 maxPoint) {
            return position.X >= minPoint.X && position.X <= maxPoint.X
                && position.Y >= minPoint.Y && position.Y <= maxPoint.Y
                && position.Z >= minPoint.Z && position.Z <= maxPoint.Z;
        }

        /// <summary>
        /// Looks for the closest Vehicle that is a designated TransportVehicle.
        /// </summary>
        /// <param name="position">The position from which to check.</param>
        /// <param name="radius">The radius to check around the position.</param>
        /// <param name="vehicles">An array containing all vehicles to check.</param>
        /// <param name="transport">The Transport that has been found if there was one.</param>
        /// <returns>The Vehicle if one was found. Null if not.</returns>
        private Vehicle GetClosestTransportVehicle(Vector3 position, float radius, ref Vehicle[] vehicles, ref Transport transport) {
            Vehicle closestVehicle = null;
            float closestDistance = radius;

            for (int i = 0; i < vehicles.Length; i++) {
                int modelHash = vehicles[i].Model.Hash;
                float distance = World.GetDistance(position, vehicles[i].Position);

                if (distance > closestDistance)
                    continue;

                for (int j = 0; j < transports.Count; j++) {
                    if (modelHash == transports[j].ModelHash) {
                        closestDistance = distance;
                        closestVehicle = vehicles[i];

                        transport = transports[j];

                        break;
                    }
                }
            }

            return closestVehicle;
        }

        /// <summary>
        /// Gets the Transport struct from a given Vehicle.
        /// </summary>
        /// <param name="vehicle">The Vehicle to check.</param>
        /// <returns>The Transport if the Vehicle has one. Empty Transport if Vehicle is not a Transport.</returns>
        private Transport GetTransportFromVehicle(Vehicle vehicle) {
            int vehicleHash = vehicle.Model.Hash;

            for (int i = 0; i < transports.Count; i++) {
                if (transports[i].ModelHash == vehicleHash) {
                    return transports[i];
                }
            }

            return new Transport();
        }
        /// <summary>
        /// Gets the Transport struct from a given ModelHash.
        /// </summary>
        /// <param name="modelHash">The ModelHash of the Vehicle to check.</param>
        /// <returns>The Transport if the Vehicle has one. Empty Transport if Vehicle is not a Transport.</returns>
        private Transport GetTransportFromVehicle(int modelHash) {
            for (int i = 0; i < transports.Count; i++) {
                if (transports[i].ModelHash == modelHash) {
                    return transports[i];
                }
            }

            return new Transport();
        }

        /// <summary>
        /// Checks for the closest Vehicle that is not a Transport.
        /// </summary>
        /// <param name="position">The position to check from.</param>
        /// <param name="radius">The radius to check around the position.</param>
        /// <returns>The Vehicle if one was found. Null if no Vehicle was found.</returns>
        private Vehicle GetClosestVehicleNoTransport(Vector3 position, float radius) {
            float dist = 200000f;
            Vehicle vehicle = null;
            Transport transport = new Transport();
            Vehicle closestTransport = GetClosestTransportVehicle(position, radius, ref clientVehicles, ref transport);

            for (int i = 0; i < clientVehicles.Length; i++) {
                float tmpDist = Vector3.DistanceSquared(clientVehicles[i].Position, position);
                if (clientVehicles[i] != closestTransport && tmpDist <= dist) {
                    dist = tmpDist;
                    vehicle = clientVehicles[i];
                }
            }

            return vehicle;
        }
    }
}
