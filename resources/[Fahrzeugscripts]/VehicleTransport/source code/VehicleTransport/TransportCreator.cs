using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Newtonsoft.Json;

using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace VehicleTransport
{
    class TransportCreator
    {
        /// <summary>
        /// If the user is currently creating a transport.
        /// </summary>
        public bool CreatingTransport { get; set; } = false;

        private Vehicle transportVehicle;
        private Transport currTransport;

        private bool settingMinValue = false;
        private bool settingMaxValue = false;
        private bool settingRampPosition = false;

        private Vector3 minValue;
        private Vector3 maxValue;

        private Vector3 rampPosition;
        private Vector3 rampRotation;
        private Prop ramp = null;

        public TransportCreator() {
            // register all the commands for creating a transport
            API.RegisterCommand("transport", new Action<int, List<object>, string>(Cmd_NewTransport), false);
            API.RegisterCommand("min", new Action<int, List<object>, string>(Cmd_SetMin), false);
            API.RegisterCommand("max", new Action<int, List<object>, string>(Cmd_SetMax), false);
            API.RegisterCommand("rampmodel", new Action<int, List<object>, string>(Cmd_SetRampModel), false);
            API.RegisterCommand("save", new Action<int, List<object>, string>(Cmd_SaveTransport), false);
        }

        public void Process() {
            Game.DisableAllControlsThisFrame(0);
            Game.EnableControlThisFrame(0, Control.LookLeftRight);
            Game.EnableControlThisFrame(0, Control.LookUpDown);
            Game.EnableControlThisFrame(0, Control.NextCamera);
            Game.EnableControlThisFrame(0, Control.MpTextChatAll);

            float mult = 1f;
            if (Game.IsDisabledControlPressed(0, Control.Sprint))
                mult = 3f;

            Vector3 change = Vector3.Zero;
            change.X += Game.GetDisabledControlNormal(0, Control.MoveLeftRight) * Game.LastFrameTime * mult;
            change.Y -= Game.GetDisabledControlNormal(0, Control.MoveUpDown) * Game.LastFrameTime * mult;
            change.Z -= Game.GetDisabledControlNormal(0, Control.VehicleFlyPitchUpDown) * Game.LastFrameTime * mult;

            Vector3 changeRot = Vector3.Zero;
            if (Game.IsDisabledControlJustPressed(0, Control.VehicleFlyRollLeftOnly))
                changeRot.Z += 10f;
            if (Game.IsDisabledControlJustPressed(0, Control.VehicleFlyRollRightOnly))
                changeRot.Z -= 10f;
            if (changeRot.Z > 180f)
                changeRot.Z -= 360f;
            else if (changeRot.Z <= -180f)
                changeRot.Z += 360f;

            if (settingMinValue)
                minValue += change;
            else if (settingMaxValue)
                maxValue += change;
            else if (settingRampPosition)
            {
                rampPosition += change;
                rampRotation += changeRot;
            }

            if (settingMinValue || settingMaxValue) {
                Vector3 min = transportVehicle.GetOffsetPosition(minValue);
                Vector3 max = transportVehicle.GetOffsetPosition(maxValue);
                World.DrawMarker(MarkerType.DebugSphere, min, Vector3.Zero, Vector3.Zero, Vector3.One * 0.2f, System.Drawing.Color.FromArgb(255, 0, 255, 0), false, false, false, null, null, false);
                World.DrawMarker(MarkerType.DebugSphere, max, Vector3.Zero, Vector3.Zero, Vector3.One * 0.2f, System.Drawing.Color.FromArgb(255, 255, 0, 0), false, false, false, null, null, false);

                // draw cube
                {
                    Vector3[] verts = {
                        min,
                        transportVehicle.GetOffsetPosition(new Vector3(minValue.X, minValue.Y, maxValue.Z)),
                        transportVehicle.GetOffsetPosition(new Vector3(maxValue.X, minValue.Y, maxValue.Z)),
                        transportVehicle.GetOffsetPosition(new Vector3(maxValue.X, minValue.Y, minValue.Z)),
                        transportVehicle.GetOffsetPosition(new Vector3(maxValue.X, maxValue.Y, minValue.Z)),
                        max,
                        transportVehicle.GetOffsetPosition(new Vector3(minValue.X, maxValue.Y, maxValue.Z)),
                        transportVehicle.GetOffsetPosition(new Vector3(minValue.X, maxValue.Y, minValue.Z))
                    };

                    // cube lines
                    {
                        // front
                        World.DrawLine(verts[0], verts[1], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[1], verts[2], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[2], verts[3], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[3], verts[0], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        // back
                        World.DrawLine(verts[4], verts[5], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[5], verts[6], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[6], verts[7], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[7], verts[4], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        // between
                        World.DrawLine(verts[0], verts[7], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[1], verts[6], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[2], verts[5], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                        World.DrawLine(verts[3], verts[4], System.Drawing.Color.FromArgb(255, 255, 255, 255));
                    }

                    // cube faces
                    {
                        World.DrawPoly(verts[2], verts[1], verts[0], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[3], verts[2], verts[0], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[6], verts[5], verts[4], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[7], verts[6], verts[4], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[5], verts[2], verts[3], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[4], verts[5], verts[3], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[1], verts[6], verts[7], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[0], verts[1], verts[7], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[5], verts[6], verts[1], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[2], verts[5], verts[1], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[3], verts[0], verts[7], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                        World.DrawPoly(verts[4], verts[3], verts[7], System.Drawing.Color.FromArgb(100, 0, 0, 0));
                    }
                }
            } else if (settingRampPosition) {
                API.AttachEntityToEntity(ramp.Handle, Game.PlayerPed.Handle, -1, rampPosition.X, rampPosition.Y, rampPosition.Z, rampRotation.X, rampRotation.Y, rampRotation.Z, false, false, true, false, 2, true);
            }
        }

        private void Cmd_NewTransport(int source, List<object> args, string raw) {
            CreatingTransport = true;

            if (Game.PlayerPed.IsInVehicle())
                transportVehicle = Game.PlayerPed.CurrentVehicle;
            else
                transportVehicle = World.GetClosest(Game.PlayerPed.Position, World.GetAllVehicles());

            if (transportVehicle == null) {
                CreatingTransport = false;
                return;
            }

            minValue = -Vector3.One;
            maxValue = Vector3.One;
            rampPosition = Vector3.Zero;
            rampRotation = Vector3.Zero;

            ramp = null;

            currTransport = new Transport {
                ModelName = (string)args[0],
                ModelHash = transportVehicle.Model.Hash,
                Min = minValue,
                Max = maxValue,
                RampModelHash = -1,
                RampPosition = Vector3.Zero,
                RampRotation = Vector3.Zero
            };
        }

        private void Cmd_SetMin(int source, List<object> args, string raw) {
            settingMaxValue = false;
            settingMinValue = true;
            settingRampPosition = false;
        }

        private void Cmd_SetMax(int source, List<object> args, string raw) {
            settingMinValue = false;
            settingMaxValue = true;
            settingRampPosition = false;
        }

        private async void Cmd_SetRampModel(int source, List<object> args, string raw) {
            settingMinValue = false;
            settingMaxValue = false;

            if (ramp != null && ramp.Exists())
                BaseScript.TriggerServerEvent("VehicleTransport:DeleteRamp", ramp.NetworkId, VehicleTransport_Client.IsOnesync);

            string rampModel = (string)args[0];

            currTransport.RampModelHash = API.GetHashKey(rampModel);

            Model model = new Model(rampModel);

            rampPosition = Vector3.Zero;
            rampRotation = Vector3.Zero;

            ramp = await World.CreateProp(model, transportVehicle.Position, transportVehicle.Rotation, false, false);
            ramp.SetNoCollision(transportVehicle, true);

            model.MarkAsNoLongerNeeded();

            settingRampPosition = true;
        }

        private void Cmd_SaveTransport(int source, List<object> args, string raw) {
            settingMaxValue = false;
            settingMinValue = false;
            settingRampPosition = false;

            currTransport.Min = minValue;
            currTransport.Max = maxValue;
            currTransport.RampPosition = rampPosition;
            currTransport.RampRotation = rampRotation;

            BaseScript.TriggerServerEvent("VehicleTransport:SaveTransport", JsonConvert.SerializeObject(currTransport, Formatting.None));

            //transports.Add(currTransport);

            if (ramp != null) {
                ramp.Delete();
                ramp = null;
            }

            CreatingTransport = false;
        }
    }
}
